
void displayNormal() {
  resetDrawingState();
  fill(#2DC96A);
  noStroke();
  rect(0, 0, width, height/ 1.3  + 30);
  boolean stress = false;
 
  
  strokeWeight(2);
  float t = (millis() - startTime) / 1000.0;
  drawAxes(t);
  // drawing graph
  for (int i = 0; i < heartRates.size() - 1; ++i) {
    float currRate = heartRates.get(i+1);
    stroke(#3B5BD8);
    if (currRate > 100) {
      stroke(#F01F1F);
      stress = true;
  
    } 
    
    
    float x1 = xPoints.get(i) + padding;
    float x2 = xPoints.get(i+1) + padding;
    float y1 = map(heartRates.get(i), 0, 220, (height)/2 - padding, padding);
    float y2 =  map(heartRates.get(i+1), 0, 220, (height)/2 - padding, padding);
    
    line(x1, y1, x2, y2);
    
     noStroke();
  }
  if (!heartRates.isEmpty()) {
  float latestRate = heartRates.get(heartRates.size() - 1);
  float latestX = xPoints.get(xPoints.size() - 1) + padding;
  float latestY = map(latestRate, 40, 220, (height)/2 - padding, padding);


  fill(20); 
  textSize(12);
  textAlign(CENTER, CENTER);

 
  text(nf(latestRate, 0, 2) + " bpm", latestX - 40, latestY - 10); // Position text slightly above the latest point
}
  
  strokeWeight(1);
  
  

  // Display heart rate
  fill(255);
  rect(0, height/2, width, height/2);
  fill(0);
  textSize(16);
  text("Heart Rate: " + heartRate + " BPM", width/2, (height / 2)+25);
  // Display time between beats
  text("Time Between Beats: " + timeBetweenBeats + " ms", width/2, (height / 2) + 50);

  // Display blood oxygen level and confidence level
  text("Blood Oxygen Level: " + nf(bloodOxygenLevel, 2, 1) + "%", width/2, (height / 2) + 75);
  text("Confidence Level: " + nf(confidenceLevel, 2, 1) + "%", width/2, (height / 2) + 100);
  text("Average BPM: " + nf(averageRate, 0, 2) + "bpm", width/2, (height / 2) - 250);
  textSize(22);
  if (stress) {
   fill(#F50C43);
   text("Stress detected!", width/2, height/2 + 125); 
   fill(0);
  } else {
   text("No stress detected.", width/2, height/2 + 125);
  }
     
 
  backButton.display();

}
