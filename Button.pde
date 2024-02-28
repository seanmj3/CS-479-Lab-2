
// Button class
class Button {
 float x,y;
 float radius;
 String text;
 boolean transparent;
 color background;
 color textColor;
 
 Button(float x, float y, float diameter, String text, boolean transparent, color background, color textColor) {
  this.x = x;
  this.y = y;
  this.radius = diameter /2;
  this.text = text;
  this.transparent = transparent;
  this.textColor = textColor;
  this.background = background;
 }
 
 boolean onHover() {
     float distance = dist(mouseX, mouseY, x, y);
    return distance < radius;
 }
 
 void display() {
   if (transparent) {
    fill(textColor);
    textAlign(CENTER, CENTER);
    // Display the text at the center of the button
    text(text, x, y);
     
   } else {
    fill(background);
    stroke(0);
    // Draw the circle for the button
    ellipse(x, y, radius * 2, radius * 2); // Diameter is radius*2 for both width and height
    fill(textColor);
    textAlign(CENTER, CENTER);
    // Display the text at the center of the button
    text(text, x, y);
    
   }
    noStroke();
  }
  
}

/*
void mousePressed() {
 switch(current_mode) {
  case main_menu:
    if (fitnessButton.onHover()) {
      current_mode = fitness_mode;
    }
    
    else if (stressButton.onHover()) {
      current_mode = stress_mode; 
  
   } else if (meditationButton.onHover()) {
      current_mode = meditation_mode; 
    }
    break;
    
   case fitness_mode:
     if (backButton.onHover()) {
       current_mode = main_menu;
       break;
     }
     
    case stress_mode:
     if (backButton.onHover()) {
       current_mode = main_menu;
       break;
     }
     
    case meditation_mode:
     if (backButton.onHover()) {
       current_mode = main_menu;
       break;
     }
 }
 
 */
