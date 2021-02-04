class Points {
  
  //declare a PApplet to use minim inside this class
  PApplet audio;
  
  //declare bite and drink players
  AudioPlayer bite;
  AudioPlayer drink;

  //declare variables for all the counters and initialize life counter to a 100
  int lifeCounter = 100;
  int caloriesCounter;
  int meatsCounter;
  int vegetablesCounter;
  int fruitsCounter;
  int grainsCounter;
  int dairyCounter;
  int waterCounter;

  //Create strings to desplay the titles of the points...
  String life = "Health ";
  String calories = "Calories ";
  String meats = "Meats: ";
  String vegetables = "Vegetables: ";
  String fruits = "Fruits: ";
  String grains = "Grains: ";
  String dairy = "Dairy: ";
  String water = "Water: ";

  //...and their limits
  String caloriesLimit = "/ 2500";
  String meatsLimit = "/ 2";
  String vegetablesLimit = "/ 5";
  String fruitsLimit = "/ 5";
  String grainsLimit = "/ 6";
  String dairyLimit = "/ 3";


  //Points()
  //pass minim
  //load audio files
  Points(PApplet min) {

    audio = min;
    minim = new Minim(audio);
    bite = minim.loadFile("bite.mp3");
    drink = minim.loadFile("drink.mp3");
    
  }

  //update()
  //update the scores with the eaten boolean from food
  //play and rewind the sound effects so they are played every time the glutton eats or drinks
  void update(Food f) {


    //for now if food is eaten then add to calories and to types of food and decrease life and speed depending on the points
    //all of them work the same way excepting garbage and water

    //if a meat is eaten then add 300 calories and 1 to the limit of the food
    if (f.type == "meats") {
      caloriesCounter += 300;
      meatsCounter++;
      bite.play();
      bite.rewind();

      //if you eat more than the limit then start decreasing speed and life
      if (meatsCounter > 2) {
        lifeCounter -= 15;
        glutton.speed -= 0.7;
      }
    }

    if (f.type == "vegetables") {
      caloriesCounter += 70;
      vegetablesCounter++;
      bite.play();
      bite.rewind();

      if (vegetablesCounter > 5) {
        lifeCounter -= 5;
        glutton.speed -= 0.2;
      }
    }

    if (f.type == "fruits") {
      caloriesCounter += 100;
      fruitsCounter++;
      bite.play();
      bite.rewind();

      if (fruitsCounter > 5) {
        lifeCounter -= 5;
        glutton.speed -= 0.2;
      }
    }

    if (f.type == "grains") {
      caloriesCounter += 120;
      grainsCounter++;
      bite.play();
      bite.rewind();

      if (grainsCounter > 6) {
        lifeCounter -= 7;
        glutton.speed -= 0.5;
      }
    }

    if (f.type == "dairy") {
      caloriesCounter += 110;
      dairyCounter++;
      bite.play();
      bite.rewind();

      if (dairyCounter > 3) {
        lifeCounter -= 10;
        glutton.speed -= 0.6;
      }
    }

    //if garbage then add 400 calories and decrease speed and life
    if (f.type == "garbage") {
      caloriesCounter += 400;
      lifeCounter -= 20;
      glutton.speed -= 1;
      bite.play();
      bite.rewind();
    }

    //if water then add life and speed
    if (f.type == "water") {
      //waterCounter++;
      lifeCounter += 2;
      glutton.speed += 1;
      
      drink.play();
      drink.rewind();
    }

    //constrain the life counter from 0 to 100
    lifeCounter = constrain(lifeCounter, 0, 100);


    //println("calories: " + caloriesCounter, meats + meatsCounter, vegetables + vegetablesCounter, dairy + dairyCounter);
    //println("is game finished " + excellentGame());
  }

  //display()
  //display prototype of the points system
  void display() {

    fill(255);
    textSize(15);
    textAlign(LEFT);
    text(life, 20, 40);
    text(calories + caloriesCounter + caloriesLimit, 20, 30*2);
    text(meats + meatsCounter + meatsLimit, 20, 30*5);
    text(vegetables + vegetablesCounter + vegetablesLimit, 20, 30*6);
    text(fruits + fruitsCounter + fruitsLimit, 20, 30*7);
    text(grains + grainsCounter + grainsLimit, 20, 30*8);
    text(dairy + dairyCounter + dairyLimit, 20, 30*9);
  }

  //reset()
  //reset all the counters in order to be able to play again
  void reset() {

    lifeCounter = 100;
    caloriesCounter = 0;
    meatsCounter = 0;
    vegetablesCounter = 0;
    fruitsCounter = 0;
    grainsCounter = 0;
    dairyCounter = 0;
    waterCounter = 0;
  }

  //boolean to check the game over conditions
  boolean gameLost() {

    return(caloriesCounter > 2850 || lifeCounter < 59);
  }

  boolean excellentGame() {

    return(caloriesCounter == 2500 && lifeCounter == 100);
  }

  boolean goodGame() {
    return(caloriesCounter > 2400 && caloriesCounter < 2700 &&  lifeCounter >= 85 &&  lifeCounter < 100);
  }

  boolean averageGame() { 
    return(caloriesCounter > 2250 && caloriesCounter < 2850 && lifeCounter >= 60 &&  lifeCounter < 85);
  }
}