class GameOver {
  
  //declare images to show at game over screen
  PImage fit, good, average, bad;

  //booleans set to false. when set to true, the state of the game changes.
  boolean replayGame = false;
  boolean chooseLocation = false;

  
  //GameOver()
  //load images
  GameOver() {

    fit = loadImage("fit.png");
    good = loadImage("good.png");
    average = loadImage("average.png");
    bad = loadImage("bad.png");
 
  }


  //display()
  //draw gameOver screen depending on the performance of the player in the game
  void display() {
    
    //draw the same background as the location chosen
    background(location.bgImages[location.selected]);
    textAlign(CENTER);
    textSize(50);
    fill(224, 224, 224);
    
    if (points.excellentGame()) {


      image(fit, width/2, height/2+50);
      text("Excellent Form", width/2, 60);

      //else if it is a good game then display the respective screen
    } else if (points.goodGame()) {
      image(good, width/2, height/2+50);    
      text("Good Form", width/2, 60);

      //else if it is an average game then display the respective screen
    } else if (points.averageGame()) {
      image(average, width/2, height/2+50);
      text("Average Form", width/2, 60);

      //else if it is lost then display its screen
    } else if (points.gameLost()) {

      image(bad, width/2, height/2+50);
      text("EAT BETTER!!!", width/2, 60);
    }
    
     textSize(15);
     fill(224, 224, 224);
     text("Press "+"'R'" + " to replay the game", width/3, 100);
     text("Press "+"'L'" + " to choose another location", width-width/3, 100);
  }
  
  
  //reset()
  //reset everything by reinitializing all the game classes.
  void reset(){
   
  time = millis();
  t= millis();
  rate = 2000;
  glutton.reset();
  points.reset();
  replayGame = false;
  chooseLocation = false;
  location.finished = false;
  songs[location.selected].pause();
  songs[location.selected].rewind();
  
  
}
  
  //keyPressed()
  //set r to replay the game and l to choose another location
  void keyPressed(){
     if (key == 'r' || key == 'R') {
     replayGame = true; 
    }
    
    if (key == 'l' || key == 'L') {
     chooseLocation = true; 
    }
  
  }
}