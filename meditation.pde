void meditation_display() {
  background(255);
  updateBreathingSimulation(); // Simulate breathing based on inhalation/exhalation rates
  drawBreathingCircle();
  displayInstructions();
  textSize(12);
  
 
 
  
}
void updateBreathingSimulation() {
  int currentTime = millis();
  float elapsedTime = currentTime - lastUpdateTime;
  float cycleElapsedTime = elapsedTime % totalCycleTime; // Time elapsed in the current cycle
  
  if (cycleElapsedTime <= totalCycleTime * inhalationPortion) {
    // Inhalation phase
    isBreathingIn = true;
    currentUserBreath = map(cycleElapsedTime, 0, totalCycleTime * inhalationPortion, 0, maxLungCapacity);
  } else {
    // Exhalation phase
    isBreathingIn = false;
    currentUserBreath = map(cycleElapsedTime, totalCycleTime * inhalationPortion, totalCycleTime, maxLungCapacity, 0);
  }

  lastUpdateTime = currentTime; // Update the last update time for the next iteration
}

void drawBreathingCircle() {
  // Calculate the fill level as a fraction of the maximum capacity
  float fillLevel = map(currentUserBreath, 0, maxLungCapacity, 0, 360);

  // Draw the circle background
  fill(240);
  ellipse(width / 2, height / 2, 200, 200);

  // Draw the filled portion of the circle
  fill(0, 0, 255); // Blue for the circle fill
  arc(width / 2, height / 2, 200, 200, -PI/2, -PI/2 + radians(fillLevel), PIE);
}

void displayInstructions() {
  fill(0);
  textSize(20);
  textAlign(CENTER);
  if (isBreathingIn) {
    text("Breathe In", width / 2, 30);
  } else {
    text("Breathe Out", width / 2, 30);
  }
}
