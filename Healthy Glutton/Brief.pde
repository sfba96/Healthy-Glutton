class Brief{
  
  //boolean that sets the finished "state" of this screen to false
  boolean finished = false;
  
  //PImage declaring this screen's image
  PImage briefBackground;
  
  //constructor loading the image
  Brief(){
    briefBackground = loadImage("instructions.png");
 
  }
  
  //update()
  //calls display function
   void update() {
    display();
  }
  
  //display()
  //Show brief's image
  //show title and continue text
  void display() {
    background(briefBackground);
    textAlign(CENTER);
    textSize(25);
    fill(11,71,111);
    text("Instructions", width/2, 40);
    textAlign(LEFT);
    textSize(15);
    text("Press any key to continue", 40, 435);
  }
  
  //keyPressed()
  //any key pressed sets the finished "state" of this screen to true
  void keyPressed() {
    finished = true;
  }



}