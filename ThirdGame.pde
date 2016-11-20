int WIDTH_ = 800;
int HEIGHT_ = 650;
Space spaceObj;
Ship shipObj;
Controls gameControls;
Bullets bulletsObj;
EnemyBullets enemeyBulletsObj;
Enemy enemyObj;
EnemyArmy armyObj; 
Score scoreObj;
PFont Akashi48;
PFont Akashi24;
PFont Akashi36;

void setup(){
  size(800,650);
  spaceObj = new Space();
  gameControls = new Controls();
  scoreObj = new Score();
  gameControls.restartGame();
  Akashi48 = createFont("Akashi", 48);
  Akashi36 = createFont("Akashi", 36);
  Akashi24 = createFont("Akashi", 24);
}


void draw(){
  if(gameControls.gameStatus == "start"){ 
    spaceObj.display();
    startScreen();
  }if(gameControls.gameStatus == "transport"){
    if(scoreObj.transportStart == 0)  scoreObj.setTransportStart();
    spaceObj.hyperDisplay(scoreObj.transportTime());
    levelDisplay();
    shipObj.display();
    if(scoreObj.transportDone()){
      gameControls.gameOn(); 
      scoreObj.clearTransport();
    }  
  } else if(gameControls.gameStatus == "on"){
    spaceObj.display();
    scoreObj.display();
    armyObj.display();
    shipObj.display();
    bulletsObj.display();
    enemeyBulletsObj.display();
  }


