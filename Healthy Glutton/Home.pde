// Title
//
// A simple class to display the title of the game on the
// screen and listen for a press of any key. When a key is pressed
// it remembers the title is finished and the main program checks
// this in order to advance to the menu.

class Home {

  // A variable to track whether the title screen is finished
  boolean finished = false;
  PImage homeBackground;
  PFont styleFont;
  
  // The constructor does nothing
  Home() {
    textAlign(CENTER);
    homeBackground = loadImage("home.jpg");
    styleFont = createFont("lemon.ttf", 14);
  }

  // update()
  //
  // Just displays the title

  void update() {
    display();
  }

  // display()
  //
  // Displays the title of the game and the basic instructions
  // to press any key
  void display() {
    background(homeBackground);
    
    textAlign(CENTER, CENTER);
    textFont(styleFont);
    fill(11,71,111);
    text("Press any key to continue", width/2, 3*height/4);
  }
  
  // keyPressed()
  //
  // Called by the main program when the title is active.
  // Sets finished to true immediately (since it's any key)

  void keyPressed() {
    finished = true;
  }

  // keyReleased()
  //
  // Does nothing.
  
  void keyReleased() {
  }
}