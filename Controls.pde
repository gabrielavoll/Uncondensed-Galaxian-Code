class Controls {
 boolean right; 
 boolean left;
 boolean gun;
 String nameInput = "AAA";
 int activeInputIndex = 0; 
 String gameStatus = "lose";
 
 void restartGame() {
  activeInputIndex = 0; 
  nameInput = "AAA";
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

 void gameLose(){ gameStatus = "lose"; }
 void gameLoseName(){ gameStatus = "lose-name"; }
 void rightOn(){ right=true; }
 void rightOff(){ right=false; }
 void leftOn(){ left=true; }
 void leftOff(){ left=false; }
 void gunOn(){ gun=true; }
 void gunOff(){ gun=false; }
 
 void rightIndexShift(){ 
   if( activeInputIndex < 2) activeInputIndex++; 
   enterName();
 }
 void leftIndexShift(){ 
   if( activeInputIndex > 0) activeInputIndex--; 
   enterName();
 }
 void incrementActiveInput(){ 
   char letter = nameInput.charAt(activeInputIndex);
   if(letter == "A") letter = ' ';
   else if(letter == " ") letter = 'Z';
   else  letter = char( nameInput.charCodeAt(activeInputIndex) - 1 );
   String newNameInput = "";
   for ( int i =0; i < 3; i++){
     if(i ==  activeInputIndex) newNameInput += str(letter);
     else newNameInput += nameInput[i];
   }
   nameInput = newNameInput;
   enterName();
 }
 void decrementActiveInput(){ 
   char letter = nameInput.charAt(activeInputIndex);
   if(letter == "Z") letter = ' ';
   else if(letter == " ") letter = 'A';
   else  letter = char(nameInput.charCodeAt(activeInputIndex) +1 );
   String newNameInput = "";
   for ( int i =0; i < 3; i++){
     if(i ==  activeInputIndex) newNameInput += str(letter);
     else newNameInput += nameInput[i];
   }
   nameInput = newNameInput;
   enterName();
 }
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
  } else if( gameControls.gameStatus == "lose-name"){
    if( key == 'a' || ( key == CODED && keyCode == LEFT ) ) gameControls.leftIndexShift();
    else if( key == 'd' || ( key == CODED && keyCode == RIGHT ) ) gameControls.rightIndexShift();
    else if( key == 'w' || ( key == CODED && keyCode == UP ) ) gameControls.incrementActiveInput();
    else if( key == 's' || ( key == CODED && keyCode == DOWN ) ) gameControls.decrementActiveInput();
    else if( keyCode == ENTER ){
      scoreObj.saveHighScore();
      gameControls.gameLose();
    }
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
  else if(gameControls.gameStatus == "win" ){
    if(mouseX >= width/2 - 75 && mouseX <= width/2 + 75 && mouseY >= height/2 && mouseY <= height/2 + 50){
      gameControls.restartGame(); 
      gameControls.transportStart();
    } else if(mouseX >= width/2 - 75 && mouseX <= width/2 + 75 && mouseY >= height/2 + 75 && mouseY <= height/2 + 125){
      exit();
    }
  } else if (gameControls.gameStatus == "lose"){
    if(mouseX >= 310 && mouseX <= 500 && mouseY >= 500 && mouseY <= 550){
      gameControls.restartGame(); 
      gameControls.transportStart();
    } else if(mouseX >= 310 && mouseX <= 500 && mouseY >= 570 && mouseY <= 620){
      exit();
    } 
  }
  
}
