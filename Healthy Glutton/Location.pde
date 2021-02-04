
class Location {

  //boolean setting the finished "state"of this screen to false
  boolean finished = false;

  //variable to track the selected background index
  int selected;

  //declare a PApplet in order to use interfascia in this class
  PApplet interfascia;

  //declare a GUI controller to show buttons
  //declare IFLookAndFeel to change the aspect of the buttons
  GUIController d;
  IFLookAndFeel defaultLook;

  //array of strings storing the names of the location images
  String[] locationNames = { "asteroid.png", "castle.png", "christmas.png", "city.png", 
    "dark.png", "desert.png", "flatland.png", "flowerland.png", "forest.png", "japan.png", "playland.png", "treasure.png"};

  //array of images in order to display them in the location screen
  PImage[] locationImages = new PImage[locationNames.length];
  //array of images that are not resize in order to draw in the gameplay
  PImage[] bgImages = new PImage[locationNames.length];

  //declare image that acts as background color
  PImage locationBg;

  //array of buttons to put over the location images
  IFButton[] bg = new IFButton[locationNames.length];

  //position and size of buttons and images
  int x = 20;
  int y = 60;
  int imageWidth = 205;
  int imageHeight = 107;


  Location(PApplet pa) {

    //load background image
    locationBg = loadImage("instructions.jpg");

    //pass pa from the main program to use interfascia
    interfascia = pa;
    //initialize controller
    d = new GUIController(interfascia);

    //set all the buttons
    bg[0] = new IFButton("Space", x, y, imageWidth, imageHeight);
    bg[1] = new IFButton("Kingdom", x+225, y, imageWidth, imageHeight);
    bg[2] = new IFButton("North Pole", x+450, y, imageWidth, imageHeight);
    bg[3] = new IFButton("City", x+675, y, imageWidth, imageHeight);
    bg[4] = new IFButton("Hunted Forest", x, y+127, imageWidth, imageHeight);
    bg[5] = new IFButton("Desert", x+225, y+127, imageWidth, imageHeight);
    bg[6] = new IFButton("Westland", x+450, y+127, imageWidth, imageHeight);
    bg[7] = new IFButton("Flowerland", x+675, y+127, imageWidth, imageHeight);
    bg[8] = new IFButton("Forest", x, y+254, imageWidth, imageHeight);
    bg[9] = new IFButton("Japan", x+225, y+254, imageWidth, imageHeight);
    bg[10] = new IFButton("Playland", x+450, y+254, imageWidth, imageHeight);
    bg[11] = new IFButton("Treasure Cave", x+675, y+254, imageWidth, imageHeight);

    //add action listeners to all buttons
    for (int i=0; i<bg.length; i++) {

      bg[i].addActionListener(pa);
    }


    //set the default look of the buttons
    defaultLook = new IFLookAndFeel(interfascia, IFLookAndFeel.DEFAULT);
    defaultLook.baseColor = color(255, 255, 255, 0);
    defaultLook.borderColor = color(255, 255, 255, 0);
    defaultLook.activeColor = color(43, 84, 150, 255);
    defaultLook.highlightColor = color(14, 72, 165, 40);

    defaultLook.textColor = color(255);

    d.setLookAndFeel(defaultLook);

    //add the look to all buttons
    for (int i = 0; i<bg.length; i++) {

      bg[i].setLookAndFeel(defaultLook);
    }

    //load all location screen images
    for (int i=0; i<locationImages.length; i++) {
      locationImages[i] = loadImage(locationNames[i]);
    }

    //load all background images
    for (int i=0; i<bgImages.length; i++) {
      bgImages[i] = loadImage(locationNames[i]);
    }
  }

  //addButtons()
  //use a for loop to add controllers to all buttons so they display
  void addButtons() {

    for (int i = 0; i<bg.length; i++) {

      d.add(bg[i]);
    }
  }

  //addButtons()
  //use a reversed for loop to remove controllers to all buttons so they don't display
  void removeButtons() {

    for (int i = bg.length-1; i>=0; i--) {

      d.remove(bg[i]);
    }
  }

  //recognized the click of the buttons and save the index of the selected location in order to draw the respective background in the main program
  void actionPerformed (GUIEvent e) {
    if (!location.finished) {
      for (int i = 0; i < bg.length; i++) {
        if (bg[i] == e.getSource()) {
          finished = true;
          selected = i;
        }
      }
    }
  }


  //display()
  //display all the resized images of the location options
  void display() {

    background(locationBg);
    imageMode(CORNER);
    textAlign(CENTER);
    fill(11, 71, 111);
    textSize(20);
    text("Choose Location", width/2, 40);


    image(locationImages[0], x, y);
    locationImages[0].resize(205, 107);

    image(locationImages[1], x+225, y);
    locationImages[1].resize(205, 107);

    image(locationImages[2], x+450, y);
    locationImages[2].resize(205, 107);

    image(locationImages[3], x+675, y);
    locationImages[3].resize(205, 107);

    image(locationImages[4], x, y+127);
    locationImages[4].resize(205, 107);

    image(locationImages[5], x+225, y+127);
    locationImages[5].resize(205, 107);

    image(locationImages[6], x+450, y+127);
    locationImages[6].resize(205, 107);

    image(locationImages[7], x+675, y+127);
    locationImages[7].resize(205, 107);

    image(locationImages[8], x, y+254);
    locationImages[8].resize(205, 107);

    image(locationImages[9], x+225, y+254);
    locationImages[9].resize(205, 107);

    image(locationImages[10], x+450, y+254);
    locationImages[10].resize(205, 107);

    image(locationImages[11], x+675, y+254);
    locationImages[11].resize(205, 107);
  }
}