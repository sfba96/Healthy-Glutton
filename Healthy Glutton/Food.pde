
class Food {

  //create variables for location and velocity
  int x;
  int y;
  int vy;
  String type;
  color defaultColor;

  //initialize size and speed
  int size = 30;
  int speed;
  
  //create arrays of strings with the names of the images
  String[] meatsNames = { "chicken.png", "beef.png", "fish.png"};
  String[] vegetablesNames = { "lettuce.png", "tomato.png", "cucumber.png", "carrot.png"};
  String[] fruitsNames = { "apple.png", "banana.png", "grapes.png", "peach.png"};
  String[] grainsNames = { "bread.png", "cereal.png", "pasta.png", "rice.png"};
  String[] garbageNames = { "hamburger.png", "hotdog.png", "pizza.png"};
  String[] dairyNames = { "milk.png", "cheese.png"};
  
  //create arrays of images witht the length of the previous arrays of names except for water that never changes
  PImage[] meatsImages = new PImage[meatsNames.length];
  PImage[] vegetablesImages = new PImage[vegetablesNames.length];
  PImage[] fruitsImages = new PImage[fruitsNames.length];
  PImage[] grainsImages = new PImage[grainsNames.length];
  PImage[] dairyImages = new PImage[dairyNames.length];
  PImage[] garbageImages = new PImage[garbageNames.length];
  PImage water;

  //create a global boolean to be used in the points system
  boolean globalEaten;

  boolean onGround = false;
  
  //declare variable random that will be initialized after the images are set
  int random;

  //Food()
  //set up the initial values of the food
  //pass the type of food with a string
  //initialize all of the images with for loops and then assign a random number in order to draw them later

  Food(String _type) {
    
    type = _type;
    x = floor(random(width/4+25+size/2, width-size/2));
    y = -20;
    speed = 4;
    vy = speed;

    if (type == "meats") {
       for (int i=0; i<meatsImages.length; i++) {
        meatsImages[i] = loadImage(meatsNames[i]);
        int r = floor(random(0,meatsImages.length));
        random = r;
      }
    }

    if (type == "vegetables") {
       for (int i=0; i<vegetablesImages.length; i++) {
        vegetablesImages[i] = loadImage(vegetablesNames[i]);
        int r = floor(random(0,vegetablesImages.length));
        random = r;
      }
    }

    if (type == "fruits") {
       for (int i=0; i<fruitsImages.length; i++) {
        fruitsImages[i] = loadImage(fruitsNames[i]);
        int r = floor(random(0,fruitsImages.length));
        random = r;
      }
    }

    if (type == "garbage") {
       for (int i=0; i<garbageImages.length; i++) {
        garbageImages[i] = loadImage(garbageNames[i]);
        int r = floor(random(0,garbageImages.length));
        random = r;
      }
    }

    if (type == "water") {
      water = loadImage("water.png");
    }

    if (type == "grains") {
      for (int i=0; i<grainsImages.length; i++) {
        grainsImages[i] = loadImage(grainsNames[i]);
        int r = floor(random(0,grainsImages.length));
        random = r;
      }
    }

    if (type == "dairy") {
       for (int i=0; i<dairyImages.length; i++) {
        dairyImages[i] = loadImage(dairyNames[i]);
        int r = floor(random(0,dairyImages.length));
        random = r;
      }
    }

  }

  //update()
  //update y location with velocity
  //constrain it
  void update() {

    y += vy;

    y = constrain(y, -20, height -size/2);
    if (y == height - size/2) {
      onGround = true;
    }
  }

  //display()
  //draw random food images depending on the type
  void display() {

    if (type == "meats") {
      
      image(meatsImages[random], x, y);
      
    } else if (type == "vegetables"){
      
      image(vegetablesImages[random], x, y);
      
    }  else if (type == "fruits"){
      
      image(fruitsImages[random], x, y);
      
    }  else if (type == "grains"){
      
      image(grainsImages[random], x, y);
      
    }  else if (type == "dairy"){
      
      image(dairyImages[random], x, y);
      
    }  else if (type == "garbage"){
      
      image(garbageImages[random], x, y);
      
    } else {
      
      image(water,x,y);
    }
  }

  //collide()
  //get Glutton properties
  //set a boolean to true if the food is eaten
  //create logic for the food disappearing

  void collide(Glutton glutton) {

    //eaten is true when the ball is within the width of the glutton and within "the head"
    boolean eaten = (y + size/2  >= glutton.yTop && x + size/2 >= glutton.xTop && x <= glutton.xTop + (glutton.imageWidth-30) && y + size/2 < glutton.yTop + (glutton.imageHeight-100) );

    //pass eaten to globalEaten so it can be used outside
    globalEaten = eaten;

    //if food is not eaten then display, else take it out of the screen and stop moving
    if (!eaten  && y < height || y > glutton.yTop) {

      display();
    } 
    
  }
  
  //reset()
  //reset foods speed and velocity
  void reset(){
    speed = 4;
    vy = speed;
  }
}