
// ChatGPT-recommended ekg and respiratory simulaion for testing
float maxLungCapacity = 100; // Simulated maximum lung capacity
float currentUserBreath = 0; // Current breath amount (simulating user's lung capacity usage)
boolean isBreathingIn = true; // Track breathing direction
int lastUpdateTime; // When the last update occurred
float totalCycleTime = 12000; // Total time for one full breath cycle (inhalation + exhalation) in milliseconds
float inhalationPortion = 0.25; // Portion of the cycle time dedicated to inhalation
float exhalationPortion = 0.75; // Portion of the cycle time dedicated to exhalation

// display globals
long startTime_sec = millis();
int age = 23; // NOTE: We can maybe add an input for the user to enter age at start-up.
int heartRate = 0;
int numRates = 0;
int totalRateSum = 0;
int maxZone = 220 - age;
final int main_menu = 0, fitness_mode = 1, stress_mode = 2, meditation_mode = 3, graph_mode = 4;
int current_mode = 0; //  may not be needed as we are using tabs for modes


// button inits
Button fitnessButton, stressButton, meditationButton, backButton;

// graph inits
Graph ekgGraph, respGraph, bpmGraph, fitnessGraph;

// average globals
int averageRate = 0;

void setup() {
  size(400, 800);
  
  //  button defines
  // NOTE: may NOT be needed unless we need buttons
  fitnessButton = new Button(width/2-100, height/2, 150, "Fitness mode", false, #0F3AAA, 255);
  stressButton = new Button(width/2+100, height/2, 150, "Stress mode", false, #0F3AAA, 255);
  meditationButton = new Button(width/2, height/2 + 150, 150, "Meditation mode", false, #0F3AAA, 255);
  backButton = new Button(width/2, height/2 +100, 150, "< back", true, 0, #E81018);
  
  // graph defines. Here we can modify size and positions of graphs as necessary.
  ekgGraph = new Graph(20, 20, width, 200,30, 0);
  respGraph = new Graph(20, 20, width, 200, 30,0);
  bpmGraph = new Graph(20, height/2 -200, width, 200, 30,1);
  fitnessGraph = new Graph(20, height/2 - 200, width, 200, 30, 1);
   
  lastUpdateTime = millis();
  
}

void draw() {
 background(255);
 
 // I am simulating heartRate here. Just apply this to Serial and it will work
 // NOTE: apply filtering and other methods before inserting to graphs
 // TODO: the zones are not yet finalized. Below is for testing only
 if (frameCount % 60 == 0) {
   heartRate = int(random(60, 100));
   numRates += 1;
   totalRateSum += heartRate;
   averageRate = (totalRateSum / numRates);
   bpmGraph.insertRate(heartRate, #FF1265);
   if (heartRate < 70) {
     zoneColor = #02F739;
     zone = "Normal";
     normalTime += 1;
   } else if (heartRate > 70 && heartRate < 90) {
     zoneColor = #FAC608;
     zone = "Fat Burn";
     fatBurnTime += 1;
   } else {
     zoneColor = #F7023C;
     zone = "Cardio";
     cardioTime += 1;
   }
   
   fitnessGraph.insertRate(heartRate, zoneColor);
 }
 
 //bpmGraph.insertRate(heartRate);
 

 // for switching tabs
 switch(activeTab) {
    case 0:
      main_menu();
      break;
    case 1:
      fitness_display();
      break;
    case 2:
      stress_display();
      break;
     case 3:
      meditation_display();
      break;
     case 4:
       graph_display();
       break;
  }
  
  drawTabs();

}

// used for converting time depending on value
String convertTime(int value) {
  String time = "";
  if (value < 60) {
    time = value + " s";
  } else if (value >= 60 && value < 3600) {
    value = value / 60;
    time = value + " min";
  } else if (value >= 3600) {
    value = value / 3600;
    time = value + "hrs";
  }
  
  return time;
  
}
