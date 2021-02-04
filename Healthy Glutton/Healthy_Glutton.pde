//Healthy Glutton

//Healthy Glutton is a game that aims to promote a healthy diet while having fun. In the game the player’s 
//only goal is to eat the food that is falling from the sky but if you are careful enough to respect the 
//limits provided, then at the end you will realize that it has a positive outcome on your form. While doing 
//the game I once was questioned why did I put the option to choose a location, as if having food falling from the 
//sky was weird enough, it was then when I realized in reality why I do creative work. 
//So I answered “because it is the only opportunity I have to make the impossible a reality”. The interesting thing about 
//Healthy Glutton is that each location has a dedicated song that will provide a consistent theme and 
//add to the fun of playing it. Also, I decided to add some funny images to illustrate the form at the game 
//over screen just to have a little surprise by getting off the consistent visual theme present on the rest of the game. 

//Booleans and if statements are particularly interesting in the game because there are checks that are being made consistently 
//and states that switch depending on them. The combination of arrays and loops makes the code a lot simpler and shorter that 
//it would be otherwise. Although the game could be a finished product as it is, I think there is always room for 
//improvement and the addition and modification of features as it can be easily updated. That is why I don’t think this is a final 
//definitive version but rather a kind of 1.0 that will get better as my coding improves as well.


//import minim library
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//import interfascia library
import interfascia.*;

//declare a progress bar and a GUI controller that handles the display
IFProgressBar progress;
GUIController c;

//declare minim
Minim minim;


//Global variable for the glutton
Glutton glutton;

//Global variable for the points system
Points points;

//Global variables for the home, brief, location and gameover screens
Home home;
Brief brief;
Location location;
GameOver gameOver;

// This is the variable that actually tracks the state in the game
State state;

// An enum is a way to group together a set of named options
// In this case I'm using it for tracking the state the program is in. 
//Taken from Pongs.
enum State {
  NONE, 
    HOME, 
    BRIEF, 
    LOCATION, 
    HEALTHY_GLUTTON, 
    GAME_OVER
}

//Array Lists of Food Objects storing the foods that fall and that have fell.
ArrayList<Food> fallingFoods = new ArrayList<Food>();
ArrayList<Food> floorFoods = new ArrayList<Food>();

//Array of strings storing the types of foods.
String[] types = { "meats", "vegetables", "fruits", "garbage", "water", "grains", "dairy"};

//Array of strings storing the songs names
String[] songNames = { "asteroidSong.mp3", "castleSong.mp3", "christmasSong.mp3", "citySong.mp3", 
  "darkSong.mp3", "desertSong.mp3", "westlandSong.mp3", "flowerlandSong.mp3", "forestSong.mp3", "japanSong.mp3", "flowerlandSong.mp3", "treasureSong.mp3"};
 
//create an array of audio players with the length of the song names
AudioPlayer[] songs = new AudioPlayer[songNames.length];

//3 different variables initialized to millis in order to have 3 different timers
int time = millis();
int t = millis();
int removeTime = millis();

//variable rate to store the rate in which the foods start falling
int rate = 2000;

//create PImage with background
PImage background;


//SetUp()
//define size and initialize glutton, food and point system
//more to come...
void setup() {
  
  //size of the canvas
  size(920, 480);
  
  //initialize home, brief, location and game over screens with their respective objects
  home = new Home();
  brief = new Brief();
  location = new Location(this);
  gameOver = new GameOver();

  //initialize minim passing the main program
  minim = new Minim(this);
  
  //for loop that loads all the songs in the array
  for (int i =0; i<songs.length; i++) {

    songs[i] = minim.loadFile(songNames[i]);
   
  }

  //create a glutton passing these parameters to the class object
  glutton = new Glutton (width/2, height-height/3+10, "r", 15, 2);

  //GUI Controller to get interfascia's progress bar to work
  c = new GUIController (this);

  //Initialize a life (progress) bar
  progress = new IFProgressBar(80, 27, 100);

  //initialize points with the Points class
  points = new Points(this);

  //Initialize state to home
  state = State.HOME;
}

//draw()
//switch state to show and control the different screens states
//in the HEALTHY_GLUTTON state. All the actual gameplay functions get called


void draw() {

  switch (state) {

    // If our state is NONE, we do nothing
  case NONE:
    break;

    //if it is home then display home and if finished pass to brief
  case HOME:
  
    
    home.display();
    if (home.finished) {
      state = State.BRIEF;
    }
    break; 

    //if it is brief then display its screen and if finished pass to choose location and add buttons
  case BRIEF:
  
    brief.display();
    if (brief.finished) {
      state = State.LOCATION;
      
      //add buttons by calling location add button's function
      location.addButtons();
    }

    break;

  //if it is location then display the location screen and if finished remove buttons, add progress bar and pass to game
  case LOCATION:
  
    location.display();
    if (location.finished) {
      
      //remove buttons by calling location remove button's function
      location.removeButtons();
      state = State.HEALTHY_GLUTTON;
      
      //add GUI controller for the progress bar which displays the bar
      c.add (progress);
    }

    break;

    //if Healthy Glutton then draw the game. If the game is over, pass to the game over state
  case HEALTHY_GLUTTON:

    //call healthyGlutton() that is where all the gameplay is stored
    healthyGlutton();
    

    break;

  //if game is over then display game over screen.
  //if the person choses to replay or choose another location then pass to the corresponding state
  case GAME_OVER:
    
    
    gameOver.display();
    if(gameOver.replayGame){
      state = State.HEALTHY_GLUTTON;
      
      //if the player chooses to replay then reset the game, re-add progress bar and pass to the HEALTHY_GLUTTON state
      gameOver.reset();
      c.add(progress);
      
    }
    
    if(gameOver.chooseLocation){
      
      //if the player chooses to select another location then reset the game and then pass to the LOCATION state
      gameOver.reset();
      state = State.LOCATION;
  
    }
    break;
  }
} 

//healthyGlutton()
//draw the gameplay in a function so the draw gets cleaner
void healthyGlutton() {
  
  //if the game is not over by any means
  if (!points.gameLost() && !points.excellentGame() &&!points.goodGame() &&!points.averageGame()) {
    
    
    //call backGround() function
    backGround();
    
    //update and display glutton
    glutton.update();
    glutton.display();

    //launch food and display points
    launchFood();
    points.display();

    //if points are less than or equal to 100 (always true) 
    //update the life bar depending on life points
    if (points.lifeCounter <=100) {

      progress.setProgress(points.lifeCounter*0.01);
    }

    //for loop that counts backwards to draw the falling food
    for (int i = fallingFoods.size() - 1; i >= 0; i--) {
      Food f = (Food)fallingFoods.get(i);
      f.update();
      f.display();
      f.collide(glutton);

      //if the food is eaten then remove from the falling foods list and update points
      if (f.globalEaten) {
        fallingFoods.remove(i);
        points.update(f);

        //if the food is on the ground then remove it from the falling foods list and add it to the floor foods list
      } else if (f.onGround) {
        fallingFoods.remove(i);
        floorFoods.add(f);
      }
    }

    //for loop that counts backwards to draw the floor food
    for (int i = floorFoods.size() - 1; i >= 0; i--) {
      Food f = (Food)floorFoods.get(i);
      f.update();
      f.display();

      if (millis() > removeTime + rate) {
        floorFoods.remove(i);
        removeTime = millis();
      }
    } 

    //else pass state to game over and remove progress bar
  } else {
    
    state = State.GAME_OVER;
    c.remove(progress);
    
  }
}

//backGround()
//controls the background
void backGround() {
  
  //draw background depending on the location selected
  background(location.bgImages[location.selected]);
  //play song according to location selected
  songs[location.selected].play();

  //the following if statements draw a rectangle on the limit of the game area
  //they have a color depending on the background
  if (location.bgImages[location.selected] == location.bgImages[0]) {

    noStroke();
    fill(199, 200, 201, 120);
    rect(0, 0, width/4+20, height);
  }

  if (location.bgImages[location.selected] == location.bgImages[1]) {

    noStroke();
    fill(11, 32, 18, 120);
    rect(0, 0, width/4+20, height);
  }

  if (location.bgImages[location.selected] == location.bgImages[2]) {

    noStroke();
    fill(0, 108, 129, 120);
    rect(0, 0, width/4+20, height);
  }

  if (location.bgImages[location.selected] == location.bgImages[3]) {

    noStroke();
    fill(0, 74, 95, 120);
    rect(0, 0, width/4+20, height);
  }

  if (location.bgImages[location.selected] == location.bgImages[4]) {

    noStroke();
    fill(176, 176, 176, 120);
    rect(0, 0, width/4+20, height);
  }

  if (location.bgImages[location.selected] == location.bgImages[5]) {

    noStroke();
    fill(250, 168, 25, 120);
    rect(0, 0, width/4+20, height);
  }

  if (location.bgImages[location.selected] == location.bgImages[6]) {

    noStroke();
    fill(214, 80, 41, 120);
    rect(0, 0, width/4+20, height);
  }

  if (location.bgImages[location.selected] == location.bgImages[7]) {

    noStroke();
    fill(117, 65, 106, 120);
    rect(0, 0, width/4+20, height);
  }

  if (location.bgImages[location.selected] == location.bgImages[8]) {

    noStroke();
    fill(68, 176, 202, 120);
    rect(0, 0, width/4+20, height);
  }

  if (location.bgImages[location.selected] == location.bgImages[9]) {

    noStroke();
    fill(243, 217, 211, 120);
    rect(0, 0, width/4+20, height);
  }

  if (location.bgImages[location.selected] == location.bgImages[10]) {

    noStroke();
    fill(234, 46, 108, 120);
    rect(0, 0, width/4+20, height);
  }

  if (location.bgImages[location.selected] == location.bgImages[11]) {

    noStroke();
    fill(88, 43, 38, 120);
    rect(0, 0, width/4+20, height);
  }
}


//KeyPressed()
//call home, brief, and glutton's keyPressed depending on state
void keyPressed() {

  switch (state) {
  case NONE:
    break;

  case HOME:
    home.keyPressed();
    break;

  case BRIEF:
    brief.keyPressed();
    break;

  case LOCATION:
    break;


  case HEALTHY_GLUTTON:
    glutton.keyPressed();
    break;

  case GAME_OVER:
    gameOver.keyPressed();
    break;
  }
}


//KeyReleased()
//call home, brief, and glutton's keyPressed depending on state
void keyReleased() {

  switch (state) {
  case NONE:
    break;

  case HOME:
    home.keyReleased();
    break;

  case BRIEF:
    break;

  case LOCATION:
    break;

  case HEALTHY_GLUTTON:
    glutton.keyReleased();
    break;

  case GAME_OVER:
    break;
  }
}

//calls action performed from the location object in order to recognize the click of the buttons
void actionPerformed (GUIEvent e) {

  location.actionPerformed(e);
  
}


//launchFood()
//Controls the creation of the food by adding items to the array list every x seconds
void launchFood() {
  //create new food depending on the type
  Food f = new Food(types[floor(random(1) * types.length)]);

  //every 2 seconds
  if (millis() > time + rate) {

    //add the food created to the list
    fallingFoods.add(f);

    //each ten seconds create food faster
    if (millis() > t + 100) {
      rate -= 300;
      t = millis();
    }

    rate = constrain(rate, 500, 2000);

    //reset millis
    time = millis();
  }
}