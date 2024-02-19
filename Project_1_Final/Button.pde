// Button class
class Button {
 float x,y, width, height;
 String text;
 
 Button(float x, float y, float width, float height, String text) {
  this.x = x;
  this.y = y;
  this.width = width;
  this.height = height;
  this.text = text;
  
 }
 
 boolean onHover() {
    return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
 }
 
 void display() {
    fill(135, 220, 216);  
    stroke(135, 220, 216);
    rect(x, y, width, height, 5);
    textAlign(CENTER, CENTER);
    textSize(20);
    fill(0);
    text(text, x + width / 2, y + height / 2);
  }
  
}

void mousePressed() {
 switch(currentState) {
  case MAIN_MENU:
    if (fitnessButton.onHover()) {
      currentState = FITNESSMODE;
    }
    
    else if (normalButton.onHover()) {
      currentState = NORMALMODE; 
      println("We got here");
    }
    
    break;
    
   case FITNESSMODE:
     if (backButton.onHover()) {
       currentState = MAIN_MENU;
       break;
     }
     
    case NORMALMODE:
     if (backButton.onHover()) {
       currentState = MAIN_MENU;
       break;
     }
     
 }
  
}
