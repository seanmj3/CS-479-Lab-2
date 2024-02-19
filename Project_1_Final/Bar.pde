
// class Bar
class Bar {
  float barWidth;
  int barHeight;
  int barX;
  int barY;
  int maxWidth;
  int value;
  color fill;
  String type;
  
  Bar(int y, int height, int maxWidth, color fill) {
    this.barHeight = height; // Static height for horizontal bar
    this.barWidth = 5.0; // Dynamic width starting at 5
    this.maxWidth = maxWidth;
    this.value = 0;
    this.fill = fill;
    this.barX = 0; 
    this.barY = y; 
  }
  
  void display(String type) {
    String unit;
    int time;
    fill(this.fill);
    rect(barX, barY, barWidth, barHeight); 
    
    fill(0);
    textAlign(CENTER, CENTER);
    if (value < 60) {
      time = value;
      unit = " s";
    } else if (value >= 60 && value < 3600) {
      time = value / 60;
      unit = " min";
    } else {
      time = value / 3600;
      unit = " hrs";
    }
   
    text(time + unit, barX + barWidth / 2 + 50, barY + barHeight / 2);
    text(type, barX + barWidth / 2 + 50, barY - 5); 
  }
  
  void addWidth(int num) { 
    if (barWidth + num <= maxWidth) {
      barWidth += 0.3; 
      value += num; 
    } 
  }
}
