
// grsph class
class Graph {
  ArrayList<Float> rates;
  ArrayList<Float> xPoints;
  ArrayList<Integer> colors; // Store colors for each line segment
  float graphWidth;
  float graphHeight;
  float startX;
  float startY;
  float padding;
  long startTime; 
  int type; // For displaying y-axis values for heartRate: 1, for other arbitrary value graphs, i.e ekg signals, 0, respiratory, 2
  
  Graph(float startX, float startY, float graphWidth, float graphHeight, float padding, int type) {
    this.rates = new ArrayList<Float>();
    this.xPoints = new ArrayList<Float>();
    this.colors = new ArrayList<Integer>(); // Initialize the colors ArrayList
    this.graphWidth = graphWidth;
    this.graphHeight = graphHeight;
    this.startX = startX;
    this.startY = startY;
    this.padding = padding;
    this.startTime = millis();
    this.type = type;
    
  }
  
  // takes in a value and a color parameter to color the line for the value
  void insertRate(float value, int c) { 
    if (rates.isEmpty()) {
      xPoints.add(0.0);
      colors.add(c); 
    } else {
      xPoints.add(xPoints.get(xPoints.size() - 1) + 5);
      colors.add(c); 
    }
    rates.add(value);
    
    if (xPoints.get(xPoints.size() - 1) + startX >= startX + graphWidth) {
      rates.remove(0);
      xPoints.remove(0);
      colors.remove(0);
      
      for (int i = 0; i < xPoints.size(); i++) {
        xPoints.set(i, xPoints.get(i) - 5);
      }
    }
  }

// call this to display the graph
void drawGraph() {
    drawAxes();
    noFill();
    
    // for heart rate
    if (type == 1) {
    if (rates.size() > 1) {
      for (int i = 0; i < rates.size() - 1; i++) {
        float x1 = startX + xPoints.get(i);
        float y1 = map(rates.get(i), 0, 220, startY + graphHeight - padding, startY + padding);
        float x2 = startX + xPoints.get(i + 1);
        float y2 = map(rates.get(i + 1), 0, 220, startY + graphHeight - padding, startY + padding);
        
        stroke(colors.get(i)); 
        strokeWeight(2);
        line(x1, y1, x2, y2); 
        strokeWeight(1);
      }
    }
    } else {
       beginShape();
   
    if (rates.size() > 1) {
      curveVertex(startX + xPoints.get(0), map(rates.get(0), 0, 220, startY + graphHeight - padding, startY + padding));
      for (int i = 0; i < rates.size(); i++) {
        float x = startX + xPoints.get(i);
        float y = map(rates.get(i), 0, 220, startY + graphHeight - padding, startY + padding);
        curveVertex(x, y);
      }
      curveVertex(startX + xPoints.get(rates.size() - 1), map(rates.get(rates.size() - 1), 0, 220, startY + graphHeight - padding, startY + padding));
    }
    endShape();
  }
 
 }
  


  private void drawAxes() {
     stroke(0);
    // y axis
    line(startX + padding, startY + padding, startX + padding, startY + graphHeight - padding);
    // x axis
    line(startX + padding, startY + graphHeight - padding, startX + graphWidth - padding, startY + graphHeight - padding);
    fill(0);
    textSize(12);

      float minutes = (millis() - startTime) / 60000.0;
      String timeLabel = nf(minutes, 0, 2) + " min";
      text(timeLabel, startX + graphWidth - padding - textWidth(timeLabel), startY + graphHeight - (padding / 4));
    
    if (type == 1) {
      
      text("Heart Rate (BPM)", startX + graphWidth / 10, startY + padding / 2);
    
      
      for (int i = 0; i <= 220; i += 50) {
          float labelY = map(i, 0, 220, startY + graphHeight - padding, startY + padding);
          text(i, startX + padding - 30, labelY); 
      }
    
      
     } else if (type == 0) {
       text("EKG Signal", startX + graphWidth / 10, startY + padding / 2);
     } else {
      `text("Respiratory Graph", startX + graphWidth / 10, startY + padding / 2); 
     }
  }
}
