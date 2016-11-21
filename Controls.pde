class Controls {
 boolean right; 
 boolean left;
 boolean gun;
 String gameStatus = "start";
 
 void restartGame() {
  right=false; left= false; 
  bulletsObj = new Bullets();
  armyObj = new EnemyArmy(39);
  shipObj = new Ship(true);
  scoreObj = new Score();
  enemeyBulletsObj = new EnemyBullets();
 }
 
 void softRestartGame(){
   right=false; left= false; 
   enemeyBulletsObj = new EnemyBullets();
   bulletsObj = new Bullets();
   armyObj = new EnemyArmy(39);
 }
 
 void transportStart(){ gameStatus = "transport"; }
 void gameOn(){ gameStatus = "on"; }
 void gamePause(){ gameStatus = "pause"; }
 void gameWin(){ 
   if( scoreObj.isFinalLevel()){
     gameStatus = "win";
     winScreen();
   } else { // progress Level
     scoreObj.nextLevel();
     softRestartGame();
     transportStart();
   }
 }

 void gameLose(){ 
   gameStatus = "lose";
   scoreObj.saveHighScore();
 }
 void rightOn(){ right=true; }
 void rightOff(){ right=false; }
 void leftOn(){ left=true; }
 void leftOff(){ left=false; }
 void gunOn(){ gun=true; }
 void gunOff(){ gun=false; }
}

void keyPressed(){
  if(gameControls.gameStatus == "on"){
    if( key == 'a' || ( key == CODED && keyCode == LEFT ) ) gameControls.leftOn();
    else if( key == 'd' || ( key == CODED && keyCode == RIGHT ) ) gameControls.rightOn();
    else if( key == ' ' ) gameControls.gunOn(); 
    else if( key == 'p' ) { gameControls.gamePause();  pauseScreen(); }
  } else if(gameControls.gameStatus == "pause"){
    if( key == 'p' ) gameControls.gameOn(); 
  } else if( gameControls.gameStatus == "transport"){
    if( key == 'a' || ( key == CODED && keyCode == LEFT ) ) gameControls.leftOn();
    else if( key == 'd' || ( key == CODED && keyCode == RIGHT ) ) gameControls.rightOn();
  }
}

void keyReleased(){
  if(gameControls.gameStatus == "on" || gameControls.gameStatus == "transport" ){
    if( key=='a' || ( key == CODED && keyCode == LEFT ) ) gameControls.leftOff();
    else if( key=='d' || ( key == CODED && keyCode == RIGHT ) ) gameControls.rightOff();
    else if( key == ' ' ) gameControls.gunOff(); 
  } 
}

void mousePressed(){
  if(gameControls.gameStatus == "start") gameControls.transportStart();
  else if(gameControls.gameStatus == "win"  || gameControls.gameStatus == "lose" ){
    if(mouseX >= width/2 - 75 && mouseX <= width/2 + 75 && mouseY >= height/2 && mouseY <= height/2 + 50){
      gameControls.restartGame(); 
      gameControls.transportStart();
    } else if(mouseX >= width/2 - 75 && mouseX <= width/2 + 75 && mouseY >= height/2 + 75 && mouseY <= height/2 + 125){
      exit();
    }
  }
  
}
