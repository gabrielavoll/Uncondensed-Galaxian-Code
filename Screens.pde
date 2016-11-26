void startScreen(){
  rectMode(CORNER);
  textAlign(CENTER); 
  textLeading(20); 
  textFont(Akashi48);
  fill(255);
  noStroke();
  text("Galaxian Replica",0,height/3.5,width, height); 
  textFont(Akashi24);
  text("click to start",0, height/3.5 + 100, width, height);
  scoreObj.displayTopHighscore( int(height/3.5 + 225) );
}

void levelDisplay(){
  int time = scoreObj.transportTime();
  if(time > 4000 && time < 7500 ) {
    int alpha = 255; 
    if( time <= 5000) alpha = (time - 4000)/4;
    else if ( time >= 6000) alpha = (7500 - time)/4; 
    rectMode(CORNER);
    textAlign(CENTER); 
    noStroke();
    textLeading(20); 
    fill(255, alpha);
    textFont(Akashi48);
    text("LEVEL " + scoreObj.level ,0,height/2.3,width, height);  
  }
  if(time > 8000) armyObj.slideIn();
}

void pauseScreen(){
  rectMode(CORNER);
  fill(0, 170); 
  noStroke();
  rect(0,0,width,height); 
  textAlign(CENTER); 
  textLeading(20); 
  fill(255);
  textFont(Akashi48);
  text("Paused",0,height/3,width, height); 
  textFont(Akashi24);
  text("Press p to continue playing " ,0,height/3 + 100 ,width, height); 
}


void loseScreenName(){
  rectMode(CORNER);
  noStroke();
  fill(0, 170); 
  rect(0,0,width,height); 
  textAlign(CENTER); 
  textLeading(20); 
  fill(255);
  textFont(Akashi48);
  text("You lost!",0,height/5 - 50,width, height); 
  textFont(Akashi24);
  text("Your Score: " + scoreObj.shipScore,0,height/5 +20 ,width, height);
  enterName();

  textFont(Akashi24);
  text( "press enter to continue", 0, int( width/3 * 1.8), width, height);
  noStroke();
}

void enterName(){
  rectMode(CORNER);
  noStroke();
  fill(0);
  rect( width/2-90, height/2, 180, 95);
  stroke(255);
  strokeWeight(5);
  fill(0, 50);
  rect(width/2-90, height/2, 180,60); 
  strokeWeight(3);
  line( width/2-75, height/2 + 50, width/2-35, height/2 +50 );
  line( width/2-20, height/2 + 50, width/2+ 20, height/2 + 50 );
  line( width/2+35, height/2 + 50, width/2+75, height/2 + 50 );
  
  fill(255);
  int baseLeft = gameControls.activeInputIndex;
  strokeWeight(5);
  triangle( (width/2-55) + (baseLeft * 55), height/2 + 75, (width/2-67) + (baseLeft * 55), height/2 + 90, (width/2-43) + (baseLeft * 55), height/2 + 90);
  textFont(Akashi36);
  text( gameControls.nameInput[0], width/2-75, height/2  + 15, 40, 40 );
  text( gameControls.nameInput[1] , width/2-20, height/2  + 15, 40, 40 );
  text( gameControls.nameInput[2] , width/2+35, height/2  + 15, 40, 40 ); 
  noStroke();
  strokeWeight(1);
}

void loseScreen(){
  rectMode(CORNER);
  noStroke();
  fill(0, 170); 
  rect(0,0,width,height); 
  fill(100,255,255); 
  rect(width/2-90, height - 150, 180,50); 
  fill(0); 
  rect(width/2-90, height - 75, 180,50);
  textAlign(CENTER); 
  textLeading(20); 
  fill(255);
  textFont(Akashi48);
  text("You lost!",0,height/5 - 50,width, height); 
  textFont(Akashi24);
  text("Your Score: " + scoreObj.shipScore,0,height/5 + 20 ,width, height); 
  fill(0);
  text("Try Again?", width/2-75, height - 135, 150,50); 
  fill(255); 
  text("Exit", width/2-75, height - 60, 150,50); 
  scoreObj.displayTopHighscore(int( height/3.5 + 75));
  noStroke();
}

void winScreen(){
  rectMode(CORNER);
  noStroke();
  fill(200, 50); 
  rect(0,0,width,height); 
  fill(100,255,255); 
  rect(width/2-90, height/2, 180,50); 
  fill(0); 
  rect(width/2-90, height/2 + 75, 180,50);
  textAlign(CENTER); 
  textLeading(20); 
  fill(0);
  textFont(Akashi36);
  text("Congradulations, you won!",0,height/3,width, height); 
  text("Your Score: " + scoreObj.shipScore,0,height/3 + 50 ,width, height); 
  textFont(Akashi24);
  fill(0);
  text("Play Again?", width/2-75, height/2+15, 150,50); 
  fill(255); 
  text("Exit", width/2-75, height/2+92, 150,50); 
}
