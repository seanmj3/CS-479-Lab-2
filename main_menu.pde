String[] tabs = {"Home", "Fitness", "Stress", "Meditation", "Graphs"}; // Labels for the tabs
int activeTab = 0; // Index of the active tab
int tabHeight = 75; // Height of the tabs



// main menu display
void main_menu() {
  background(#95DAF2);
  fill(250);
  rect(0, 0, width, height/2-200);
   fill(0);
   textAlign(CENTER, CENTER);
   textSize(20);
   text("Welcome!", width/2, 50);
   textSize(50);
   text("BPM: " + heartRate, width/2, (height/2-200)/2);
   noStroke();
   
   bpmGraph.drawGraph();
   noStroke();
   
   
   fill(255);
   rect(0, height/2 + 5, width, height);
   fill(#F26491);
   rect(25, height/2+50, 125, 100, 10);
   fill(255);
   textSize(16);
   text("Avg BPM\n\n", 86, height/2+100);
   textSize(25);
   text(averageRate, 86, height/2+110);
   fill(#CE73FC);
   rect(250, height/2+50, 125, 100, 10);
   textSize(16);
   fill(255);
   text("Avg \nBreathing Rate\n\n", width/2 + 112, height/2+95);
   textSize(25);
   text("20", width/2 + 110, height/2+110);
   fill(#58FF5E);
   rect(100, height - 225, 200, 100, 10);
   fill(255);
   //text("You are relaxed!", )
   
   
   
   
   textSize(12);
   
  
  
  
  
 
}

void drawTabs() {
  int tabWidth = width / tabs.length;
  for (int i = 0; i < tabs.length; i++) {
    // Highlight the active tab
    if (i == activeTab) {
      fill(200);
    } else {
      fill(255);
    }
    // Draw tabs at the bottom
    rect(i * tabWidth, windowHeight - tabHeight, tabWidth, tabHeight);
    fill(0);
    textAlign(CENTER, CENTER);
    // Adjust text position to be within the tab
    text(tabs[i], i * tabWidth + tabWidth / 2, height - tabHeight / 2);
  }
}

void mousePressed() {
  int tabWidth = width / tabs.length;
  if (mouseY >= height - tabHeight) { // Check if the click is within the tab bar area at the bottom
    int clickedTab = mouseX / tabWidth;
    activeTab = clickedTab;
  }
}
