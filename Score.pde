class Score {
   int shipScore; 
   int highScore = 999;
   int lives;
   int level; 
   int transportStart; 
   
   Score(){
     shipScore = 0;
     lives = 3;
     level = 1; 
     transportStart = 0;
   }
   
   void displayTopHighscore(){ 
      rectMode(CORNER);
      textAlign(CENTER); 
      textLeading(20); 
      textFont(Akashi24);
      fill(255);
      noStroke();
      String currentHighScore[] = loadStrings("d.txt");
      if( currentHighScore == null) highScore = 0;
      text("Galaxian Replica",0,height/3.5,width, height); 
    
   }
   
   void saveHighScore(){
     String currentHighScore[] = loadStrings("d.txt");
     if( currentHighScore == null  || shipScore > int(currentHighScore[0] )){
       String [] arr = {str(shipScore)};
       highScore = shipScore;
       saveStrings("d.txt", arr);
     }
   }
   
   boolean isFinalLevel(){  return level == 3;  }
   
   void nextLevel(){ level += 1; }
   
   void normalKill(){ shipScore = shipScore + 40; }
   
   void display(){
     stroke(255);
     rectMode(CORNER);
     fill(255);
     textFont(Akashi24);
     text(shipScore, 100, 30);
     stroke(255,100,100);
     text("HI-SCORE",WIDTH_/2 - 50, 30);
     stroke(255);
     if(shipScore > highScore ) text(shipScore, WIDTH_/2 + 100, 30);
     else text(highScore, WIDTH_/2 + 100, 30);
     
     if(lives >= 1) livesIcon( new PVector(WIDTH_ -80, 20));
     if(lives >= 2) livesIcon( new PVector(WIDTH_ -100, 20));
     if(lives >= 3) livesIcon( new PVector(WIDTH_ -120, 20));
   }
   
   void livesIcon(PVector origin){
     fill(255,100,100);
     stroke(255,100,100);
     ellipse(origin.x, origin.y, 6,6);
     fill(255); stroke(255);
     ellipse(origin.x, origin.y, 2,2);
   }
  
   void setTransportStart(){ transportStart = millis();  }
   void clearTransport(){ transportStart = 0; }
   int transportTime(){ return millis() - transportStart; } 
   boolean transportDone(){ return transportTime() > 10000;  }// 10 sec 
   
   void deathHandler(){
     if(lives > 0){
       lives--; 
       shipObj = new Ship(false);
       shipObj.slideIn();
     } else {
        gameControls.gameLose(); 
        loseScreen();
     }
   }
}
