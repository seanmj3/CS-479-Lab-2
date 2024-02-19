void insertHeartRate(float value) {
  
  //float space = 5;
  if (heartRates.isEmpty()) {
    xPoints.add(0.0);
    
  } else {
    xPoints.add(xPoints.get(xPoints.size() - 1) + 15);
    
  }
  heartRates.add(value);
  
  if (xPoints.get(xPoints.size() - 1) >= 750) {
    heartRates.remove(0);
    xPoints.remove(0);
    
    for (int i = 0; i < xPoints.size(); i++) {
      xPoints.set(i, xPoints.get(i) - 15);
    }
  }
  
  
}

void drawAxes(float time) {
  stroke(0);
  
  // y axis
  line(padding, padding, padding, (height/2)-padding);
  
  // x axis
  line(padding, (height/2)-padding, width-padding, (height/2)-padding);
  
  // Axis labels
  fill(0);
  textSize(12);
  text("Heart Rate (BPM)", width / 10, padding / 2);
  
  // Add labels on the y axis
  for (int i = 0; i <= 220; i += 50) {
    float labelY = map(i, 0, 220, (height / 2) - padding, padding);
    text(i, padding-15, labelY); // Adjust the x-position of the label as needed
  }
  
  // Time label on the x axis
  float minutes = (millis() - startTime) / 60000.0;
  String timeLabel = nf(minutes, 0, 2) + " min";
  text(timeLabel, width - padding - textWidth(timeLabel), (height / 2) - (padding / 4));
}
