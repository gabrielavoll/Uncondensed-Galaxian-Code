class EnemyArmy {
  PVector origin; 
  PVector slideOrigin; 
  PVector move;
  Enemy [] army;
  int startX;
  int startY;
  boolean directionR;
  boolean activeEnemyDirectionR;
  int activeCountDown; 
  int coolDownInterval;
  int minArmyCountActive; 
  float [] levelSpeedMod = {0, 1, 1.4, 1.9 };
  
  EnemyArmy(int armyCount){
    origin = move = new PVector( 0, -320);
    directionR = false;
    army = new Enemy[0]; 
    startX = 100;
    startY = HEIGHT_/3;
    activeEnemyDirectionR = true;
    minArmyCountActive = 3 * armyCount/4;
    activeCountDown = 0;
    coolDownInterval  = 220;
    for( int i = 0; i< int(armyCount/2); i++){
      army = (Enemy [])append(army, new Enemy(new PVector(startX, startY), "1"));
      modulatePosition();
    }
    for( int i = int(armyCount/2); i< int(3 * armyCount/4); i++){
      army = (Enemy [])append(army, new Enemy(new PVector(startX, startY), "2"));
      modulatePosition();
    }
    for( int i = int(3 * armyCount/4); i< armyCount; i++){
      army = (Enemy [])append(army, new Enemy(new PVector(startX, startY), "3"));
      modulatePosition();
    }
  }
  
  void modulatePosition(){
    startX = startX + 50; 
    if(startX > WIDTH_ - 100) { 
        startX = 100; startY = startY - 25; 
     } 
  }
  
  void display(){
    if(army.length == 0) gameControls.gameWin();
    for( int i = 0; i< army.length; i++){ 
      army[i].display(move); 
      if(army[i].isDead()) { deleteEnemy(i); return;}
      else if(detectCollision(army[i]) && !army[i].isExploding() ) army[i].explode();
     }
     triggerArc();
     movement();
  }
  
  void slideIn(){
    for( int i = 0; i< army.length; i++) army[i].display(move);
    slideInMovement();
  }
  
  void slideInMovement(){
    move = new PVector( 0,  2);
    origin = new PVector(origin.x, origin.y + 2);
  }
  
  void deleteEnemy(int i){
    scoreObj.normalKill();
    if(army.length == 1) army = new Enemy[0];
    else army = (Enemy [])concat( (Enemy [])subset(army, 0, i), (Enemy [])subset(army, i + 1 ));
  }
  
  boolean detectCollision(Enemy es){
    if( bulletsObj.bullet != null ){
      if( es.isActive() ) {
        float x = es.curveOrigin.x * cos(es.defRotation) -
          es.curveOrigin.y * sin(es.defRotation) + es.origin.x;
        float y = es.curveOrigin.x * sin(es.defRotation) +
          es.curveOrigin.y * cos(es.defRotation) + es.origin.y;
        if(dist(x,y, bulletsObj.bullet.x,bulletsObj.bullet.y)<=20){
          bulletsObj.deleteBullet();
          return true; 
        }
      } else if( es.isReturning() && 
      dist(es.curveOrigin.x, es.curveOrigin.y, bulletsObj.bullet.x,bulletsObj.bullet.y)<=20){
        bulletsObj.deleteBullet();
        return true; 
      } else if( !es.isActive() && !es.isReturning() && dist(es.origin.x, es.origin.y, bulletsObj.bullet.x,bulletsObj.bullet.y)<=17){
        bulletsObj.deleteBullet();
        return true;
      }
    }
    return false;
  }
  
  int findEdgeMost(){
    if( army.length == 0 ) return -1;
    int edgeMost = 0; 
    for( int i = 1; i< army.length; i++){
      if( (( activeEnemyDirectionR && army[i].origin.x > army[edgeMost].origin.x ) 
        || ( !activeEnemyDirectionR && army[i].origin.x < army[edgeMost].origin.x )) 
        && army[i].isActive() == false && army[i].isReturning() == false && army[i].isDead() ==false && army[i].isExploding() ==false){ 
        edgeMost = i;
      }
    }
   if ( army.length > edgeMost && 
      (army[edgeMost].isActive() ||  army[edgeMost].isReturning() || army[edgeMost].isDead() ||  army[edgeMost].isExploding()) ){
      edgeMost = -1; 
      for( int i = 1; i< army.length; i++){
        if(army[i].isActive()== false && army[i].isReturning() == false && army[i].isDead() ==false && army[i].isExploding() ==false){ 
          edgeMost = i;
        }
      }
    } 
    return edgeMost;
  }
  
  void triggerArc(){
    if( minArmyCountActive > army.length ){
      if( activeCountDown <= 0 && findEdgeMost() != -1 ){
        army[findEdgeMost()].activate(activeEnemyDirectionR);
        activeEnemyDirectionR = !activeEnemyDirectionR;
        activeCountDown = coolDownInterval;
      } else activeCountDown--;
    }
  }
  
  void movement(){
    if(directionR) {
      if(origin.x >= 70){
        directionR = false;
        move = new PVector( -1 * levelSpeedMod[scoreObj.level],  2);
      } else move = new PVector(1 * levelSpeedMod[scoreObj.level], 0); 
    } else {
      if(origin.x <= -70){
        directionR = true;
        move = new PVector( 1 * levelSpeedMod[scoreObj.level],  2);
      } else move = new PVector(  -1 * levelSpeedMod[scoreObj.level], 0); 
    }
    origin = new PVector(origin.x + move.x, origin.y + move.y);
  }
}