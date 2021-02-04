
class Glutton {

  //initialize non-changing height, width and speed 
  int speed = 3;

  //array of images to animate
  PImage[] images;

  //declare variable for the number of images
  int imageCount;
  int imageWidth;
  int imageHeight;

  //declare variable for current frame
  int currentFrame;

  //declare variable for rate 
  float rate;

  //create variables for location and velocity
  int xTop;
  int yTop;
  int vx;

  //Glutton()
  //Construct a glutton with the parameters passed from the main program
  //Set velocity to 0

  Glutton(int _xTop, int _yTop, String imagePrefix, int count, float tempRate) {

    xTop = _xTop;
    yTop = _yTop;
    vx = 0;

    imageCount = count;

    // Create the array 
    images = new PImage[imageCount];

    // Loop through the number of images and generate their filenames
    // then load that image into the array
    //Taken from Anim example.
    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + (i+1) + ".png";
      images[i] = loadImage(filename);
    }
    // Save the rate
    rate = tempRate;
  }

  //update()
  //update location with velocity
  //constrain it to a quarter of the screen plus 50 pixels to the left and the end of the canvas to the right
  void update() {

    xTop += vx;
    
    xTop = constrain(xTop, width/4+30, width);
    //xBottom = constrain(xBottom, width/4+104,width);
    //println(speed);
    
  }

  
  //display()
  //draw a rectangle (glutton) white and without a stroke...for now
  void display() {

    if (frameCount % rate == 0 && vx != 0) {
      // Change the frame (loop if we reach the end of the array)
      currentFrame = (currentFrame+1) % imageCount;
    }
    
     imageWidth = images[currentFrame].width;
    imageHeight = images[currentFrame].height;
    
    
    // Draw the image corresponding to this frame
    if( vx == speed){
    imageMode(CENTER);
    image(images[currentFrame], xTop, yTop);
    } else if (vx == -speed) {
      pushMatrix();
      scale(-1,1);
      imageMode(CENTER);
      image(images[currentFrame], -xTop, yTop);
      popMatrix();
    } else {
      imageMode(CENTER);
      image(images[currentFrame], xTop, yTop);
    }
   
  }
  
  //reset()
  //reset position, speed and velocity
  void reset(){
    
    xTop = width/2;
    vx = 0;
    speed = 3;
  }

  //keyPressed()
  //update the velocity when the left and right keys are pressed
  void keyPressed() {

    if (keyCode == LEFT) {

      vx = -speed;
    } else if (keyCode == RIGHT) {

      vx = speed;
    }
  }


  //keyReleased()
  //update the velocity when the left and right keys are released
  void keyReleased() {

    if (keyCode == LEFT && vx < 0) {

      vx = 0;
    } else if (keyCode == RIGHT && vx > 0) {

      vx = 0;
    }
  }
}