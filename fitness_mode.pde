float time = 0;
float scrollY = 0; // The vertical scroll position
float contentHeight = 1500; // The total height of the content to be scrolled
float windowHeight = 800; // The height of the window (viewable area)
int zoneColor = #2919E3;
String zone = "Normal";

int cardioTime = 0;
int fatBurnTime = 0;
int normalTime = 0;
int peakTime = 0;


// fitness mode display
void fitness_display() {
   background(#A59DFF);
   fill(250);
   rect(0, 0, width, height/2-250);
   fill(0);
   textAlign(CENTER, CENTER);
   textSize(20);
   text("Fitness Mode", width/2, 50);
   textSize(35);
   fill(zoneColor);
   rect(0, 75, width, 75);
   fill(255);
   text("Current Zone: " + zone, width/2, 115);
   fitnessGraph.drawGraph();
 
   noStroke();
   
   fill(255);
   rect(0, height/2 + 5, width, height);
   fill(#F26491);
   rect(25, height/2+50, 125, 100, 10);
   fill(255);
   textSize(16);
   text("Peak Time\n\n", 86, height/2+100);
   textSize(25);
   text(convertTime(peakTime), 86, height/2+110);
   fill(#CE73FC);
   rect(250, height/2+50, 125, 100, 10);
   textSize(16);
   fill(255);
   text("Cardio Time\n\n", width/2 + 112, height/2+100);
   textSize(25);
   text(convertTime(cardioTime), width/2 + 110, height/2+110);
   fill(#58FF5E);
   rect(250, height/2+200, 125, 100, 10);
   fill(255);
   textSize(16);
   text("Normal Time\n\n", width/2 + 112, height/2+250);
   textSize(25);
   text(convertTime(normalTime), width/2 + 110, height/2+260);
   
   /*
   stroke(0);
   fill(0);
   //text("Fitness", width/2, height/2);
   float value = generateEKGSignal(time);
   time += 0.1; // Increment time to simulate the signal's progression
   ekgGraph.insertRate(value, #FF1265);
  
   ekgGraph.drawGraph();
   
   noStroke();
   stroke(255);
   fill(255);
   */
   
   
   textSize(12);
}


// This function generates a simple EKG-like signal
float generateEKGSignal(float t) {
  // Reset the pattern every 2π to simulate a repeating heartbeat signal
  float localTime = t % TWO_PI;
  
  // Generate different parts of the EKG signal
  if (localTime < 1) {
    // P wave
    return 120 + 20 * sin(localTime * TWO_PI);
  } else if (localTime >= 1 && localTime < 1.5) {
    // QRS complex
    return 120 + 100 * sin((localTime - 1) * TWO_PI * 2);
  } else if (localTime >= 1.5 && localTime < 2) {
    // T wave
    return 120 + 40 * sin((localTime - 1.5) * TWO_PI);
  } else {
    // Baseline
    return 120;
  }
}



void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scrollY += e * 20; // Adjust scrolling speed and direction
}
