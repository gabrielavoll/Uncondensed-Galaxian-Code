class Ship{
  PVector origin;
  float diameter; 
  int i; 
  boolean isdead; 
  boolean isexplode; 
  boolean isslide;
  
  Ship(boolean newGame){
    if(newGame)
      origin = new PVector(WIDTH_/2, 13* HEIGHT_/14); 
    else 
      origin= new PVector( WIDTH_/2, HEIGHT_ + 60); 
    diameter = 10;
    i = 0; 
    isdead = isexplode = false;
  }
  
  void moveRight(){
    origin= new PVector( constrain(origin.x + 2, 15, WIDTH_ - 15),origin.y);
  }
  
  void moveLeft(){
    origin= new PVector( constrain(origin.x - 2, 15, WIDTH_ - 15),origin.y);
  }
  
  void movement(){
   if(gameControls.right) moveRight(); 
   else if(gameControls.left) moveLeft(); 
  }
  
  void display(){
    if(isdead){ scoreObj.deathHandler(); return; }
    else if(isexplode){ exploder(); return; }
    shipDisplay();
    if(isslide){ slideInMovement(); return; }
    if(detectCollision()) { explode(); return; }
    movement();
    shoot();
  }
  
  void slideIn(){ isslide = true; } 
  
  void slideInMovement(){
    if( origin.y == 13* HEIGHT_/14) isslide = false;
    origin= new PVector( WIDTH_/2 , max(origin.y - 2, 13* HEIGHT_/14)  );
  }
  
  boolean detectCollision(){
    int eblen = enemeyBulletsObj.bullets.length,
        alen =  armyObj.army.length;
    for( int i = 0; i< eblen || i< alen; i++){
      if( i < alen ) {
        Enemy tempEnemy = armyObj.army[i];
        if((!tempEnemy.isActive() && !tempEnemy.isReturning()
            && dist(origin.x,origin.y, tempEnemy.origin.x, tempEnemy.origin.y) <= 27) || 
            (tempEnemy.isReturning() && dist(origin.x,origin.y, tempEnemy.curveOrigin.x, tempEnemy.curveOrigin.y) <= 27)){
          armyObj.deleteEnemy(i);
          return true; 
        } else if( tempEnemy.isActive() ){
          PVector curOr = tempEnemy.curveOrigin; 
          PVector oldOr = tempEnemy.origin;
          float rot = tempEnemy.defRotation;
          float x = curOr.x * cos(rot) - curOr.y * sin(rot) + oldOr.x;
          float y = curOr.x * sin(rot) + curOr.y * cos(rot) + oldOr.y;
          if( dist(origin.x,origin.y, x, y) <= 20){
            armyObj.deleteEnemy(i);
            return true; 
          }
        }
      } 
      if(  i< eblen && dist(origin.x,origin.y, enemeyBulletsObj.bullets[i].x,enemeyBulletsObj.bullets[i].y) <= 25){
        enemeyBulletsObj.deleteBullet(i);
        return true; 
      }
    }
    return false;
  }
  
  
  void shipDisplay(){ 
    rectMode(CENTER);
    fill(255);
    stroke(255);
    ellipse(origin.x - 12, origin.y + 5, 6, 20);
    ellipse(origin.x + 11, origin.y + 5, 6, 20);
    
    fill(0,255,255);
    stroke(0,255,255);
    rect( origin.x - 2, origin.y + 2, 1.5, 22);
    rect( origin.x + 2, origin.y + 2, 1.5, 22);
    
    quad(origin.x, origin.y -6, origin.x, origin.y -4 , origin.x-10, origin.y + 9, origin.x-10, origin.y+6);
    quad(origin.x, origin.y -6, origin.x, origin.y -4, origin.x+10, origin.y +9, origin.x+10, origin.y+6);
    
    rect(origin.x - 11, origin.y + 5, 1, 10);
    rect(origin.x + 12, origin.y + 5, 1, 10);
    
    fill(255,0,0);
    stroke(255,0,0);
    triangle(origin.x, origin.y - 18, origin.x + 8, origin.y - 9, origin.x - 8, origin.y - 9);
    rect(origin.x, origin.y + 1, 1, 19);
    
    if( bulletsObj.bullet == null ){
      stroke(255,255,100);
      rect(origin.x, origin.y - 19, 1, 5);
    }
  }
  
  void shoot(){
    if(gameControls.gun && bulletsObj.bullet == null ){
      bulletsObj.addBullet(origin);
    } 
  }
  
  void explode(){ isexplode=true; }
  
  void exploder(){
     noStroke(); 
     fill(0,255,255); 
     rect( origin.x-(i*10), origin.y, diameter, diameter);  
     rect( origin.x+(i*10), origin.y, diameter, diameter); 
     rect( origin.x, origin.y-(i*10), diameter, diameter); 
     rect( origin.x, origin.y+(i*10), diameter, diameter); 
     diameter-=0.5; 
     i++; 
     if(diameter <=0){ isexplode=false;  isdead=true; } 
  }
}