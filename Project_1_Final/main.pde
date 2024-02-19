import processing.serial.*;

int heartRate;
int lastBeatTime;
int timeBetweenBeats;
int bloodOxygenLevel;
int confidenceLevel;
String readValues;
float restingHeartRate = 0;
int start_time;
boolean stress;


// graph data
ArrayList<Float> heartRates = new ArrayList<Float>();     // An array to store the data
ArrayList<Float> xPoints = new ArrayList<Float>(); 
int graphWidth = 800;
int goodZone = 70;
int mediumZone = 95;
int padding = 30;
long startTime = millis();
int totalPeak = 0;
int totalCardio = 0;
int totalBurn = 0;
int age = 23;
int totalRateSum = 0;
int numRates = 0;
int averageRate = 0;
int maxZone = 220 - age;


// modes and buttons
int currentState;
final int MAIN_MENU = 0, FITNESSMODE = 1, NORMALMODE = 2;
Button fitnessButton, normalButton, backButton;

// bar setup
Bar cardioBar, peakBar, burnBar;

int currentIndex = 0;     // Current index for inserting new data
Serial myPort;

void setup() {
  
  
  println("We are at setup");
  
  //Setting up User-Interface 
  size(800, 600);         //Set dimensioning for user-interface. We set it similar to phone layout
  fitnessButton = new Button(width/2 - 350, height - 325, 174, 229, "Fitness Mode");
  normalButton = new Button(width/2 + 175, height - 325, 174, 229, "Resting Mode");
  backButton = new Button(50, height-50, 200, 40, "Back");
  peakBar =  new Bar(height / 2+50, 50, 300, color(#DE1414));
  cardioBar =  new Bar(height / 2 + 115, 50, 300, color(#DED714));
  burnBar =  new Bar(height / 2 + 175, 50, 300, color(#148EDE));
  
  
  //Setting up Variables
  heartRate = 0;
  start_time = millis()/1000;
  lastBeatTime = millis();
  timeBetweenBeats = 0;
  currentState = MAIN_MENU;
  
  
  //Set up serial
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 15200);
  myPort.clear();
  delay(100);
  myPort.bufferUntil('\n');
  print(myPort);
  
  //resting heart rate calculation
 
  // Set up the user interface
  textAlign(CENTER, CENTER);
}

void draw() {
 
 //draw initalization screen
  fill(61, 65, 80);
  rect(0,0, 1000, 1000);
  
  fill(0);
  textSize(30);
  text("Welcome.", 400, 250);
  
  fill(135, 220, 210);
  text("Place finger on device to calculate testing heart rate", 400, 300);
  
  //read Values from serial
  //restingHeartRate = 30;
  if (restingHeartRate == 0) {
     restingHeartRate = restingheartrate(restingHeartRate, start_time);
     print("resting heart rate is: ");
     print(restingHeartRate);
  }
 
  
  
  readValues = myPort.readStringUntil('\n'); //"78;45;34;23"; //myPort.readStringUntil('\n');
 
 
  
  
  //Overall Formating of Main menus
  background(255); 
  
  //Create top graphic
  fill(61, 65, 80);  
  stroke(61, 65, 80);  
  rect(0,0, 1000, 200);
  
 //Create Text for Top Graphic
  fill(255);
  textSize(50);
  text("Fitness", 325, 75);
  fill(135, 220, 210);
  text("Tracker", 475, 75);
  
  //Create Initial graphic
  fill(88, 156, 156);  
  stroke(88, 156, 156);  
  ellipse(400, 200, 140, 140);
  
  //Text for circle
  fill(255);
  textSize(70);
  text("N", 400, 200);
  textSize(10);



     if (readValues != null) {
       String[] list = split(readValues, ";");
         // Simulate heart rate calculation
      // Update heart rate every second
      int currentTime = millis();
      timeBetweenBeats = currentTime - lastBeatTime;
      lastBeatTime = currentTime;
  
      // Simulate a random heart rate between 60 and 100 beats per minute
      if (Integer.parseInt(list[0]) > 0) {
        heartRate = Integer.parseInt(list[0]);
      }
      
      print("heart rate: ");
      println(heartRate);
      numRates += 1;
      totalRateSum += heartRate;
      averageRate = (totalRateSum / numRates);
  
      // Simulate blood oxygen level change
      if (Integer.parseInt(list[2]) > 0) {
        bloodOxygenLevel = Integer.parseInt(list[2]);
      }
      
      print("blood oxygen: ");
      println(bloodOxygenLevel);
  
      // Simulate confidence level change
      
      if (Integer.parseInt(list[1]) > 0) {
        confidenceLevel = Integer.parseInt(list[1]);
      }
      
      insertHeartRate(float(heartRate));
      float percent = (float) (restingHeartRate*100)/(maxZone);
      
      if (percent <= 70.0 && percent > 60) {
        burnBar.addWidth(1);
      } else if (percent >= 70.0 && percent <= 90) {
        cardioBar.addWidth(1);
      } else if (percent > 90) {
        peakBar.addWidth(1);
      }
  }
  
  
  switch(currentState) {
    case MAIN_MENU:
      resetDrawingState();
      fitnessButton.display();
      normalButton.display();

      break;
      
    case NORMALMODE:
      displayNormal();
      break;
    case FITNESSMODE:
      displayFitness();
      break;

  }
  
  
  if (currentState == NORMALMODE) {
    if (frameCount % 60 == 0) {
    stress = stressDetection(heartRate);
    print(stress);
    if (stress) {
      if (myPort.readStringUntil('\n') != null) {
        print(myPort.readStringUntil('\n'));
      }
      
      myPort.write("1");
    } else {
      myPort.write("0");
    }
    
    }
  }
}


void resizeWindow(int w, int h) {
  // Check if the size is different to avoid unnecessary resizing
  if (width != w || height != h) {
    surface.setSize(w, h);
  }
}
