void displayFitness() {
  resetDrawingState();
  fill(#D397E5);
  color currColor = 0;
  String currText = "";
 
  noStroke();
  rect(0, 0, width, height/ 1.3  + 30);
 
  
  strokeWeight(2);
  float t = (millis() - startTime) / 1000.0;
  drawAxes(t);
  // drawing graph
  for (int i = 0; i < heartRates.size() - 1; ++i) {
    float currRate = heartRates.get(i+1);
    float percent = (float) (currRate*100)/(maxZone);
    // add the ranges after testing
    
    if (percent < 60) {
       stroke(#35FA78);
       currColor = #35FA78;
       currText = "Normal activity";
    } else if (percent <= 70 && percent > 60) { // fat burn
       stroke(#266FEA);
       currColor = #266FEA;
       currText = "Fat burn zone";
    }
    else if (percent > 70 && percent <= 90) { /// cardio
      stroke(#FAB935);
      currColor = #FAB935;
      currText = "cardio zone";
  
    } else if (percent > 90 && percent <= 100) { // peak
      stroke(#FA4F35);
      currColor = #FA4F35;
      currText = "peak zone";
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

  // Text settings
  fill(20); // Black text
  textSize(12); // Adjust text size as needed
  textAlign(CENTER, CENTER);

  // Display text for the latest heart rate value
  text(nf(latestRate, 0, 2) + " bpm", latestX - 40, latestY - 10); // Position text slightly above the latest point
}
  strokeWeight(1);
  
  

  // Display heart rate
  fill(190);
  rect(0, height/2, width, height/2);
  fill(0);
  textSize(16);
  text("Average BPM: " + nf(averageRate, 0, 2) + "bpm", width/2,  (height / 2)+25);
  fill(currColor);
  text(currText, width/2, height/2 - 225);
  fill(0);
  
  backButton.display();
  peakBar.display("peak");
  cardioBar.display("cardio");
  burnBar.display("fat burn");
  
}
