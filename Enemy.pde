class Enemy {
  PVector origin; 
  PVector curveOrigin;
  String type;
  String movementStatus;
  String lifeStatus;
  int diameter;
  int i;
  float defRotation;
  float angle = 0.05;
  float scalar = 1.7;
  float speed = 0.02;
  int shooterCooldown = 0;
  int coolDownInterval = 90;
  float [] levelSpeedMod = {0, 1, 1.4, 1.9 };
  
  void setActive(){ movementStatus = "active"; }
  void setReturning(){ movementStatus = "returning"; }
  void setExploding(){ lifeStatus = "explode"; }
  void setDead(){ lifeStatus = "dead"; }
  void clearStatus(){ movementStatus = ""; }
  boolean isActive() { return movementStatus == "active"; }
  boolean isReturning() { return movementStatus == "returning"; }
  boolean isDead() { return lifeStatus == "dead"; }
  boolean isExploding() { return lifeStatus == "explode"; }

  Enemy(PVector position, String enemyType) {
    origin = position; type = enemyType;
    movementStatus = "normal";
    lifeStatus = "alive";
    diameter = 6;
    i = 0;
  }
  
  color getDefaultColor(){
    if (type == "2") return color(160, 137, 214);
    else if ( type == "3") return color(189, 47, 14); 
    return color(26, 160, 18);
  }

  void display(PVector addition) {
    if(isDead()) return;
    else if(isExploding()){ exploder(); return; }
    movement(addition);
    
    PVector corigin = isActive() || isReturning() ? curveOrigin : origin;
    color defaultColor = getDefaultColor();
    rectMode(CENTER);

    fill(46, 78, 127);
    stroke(46, 78, 127);
    triangle(corigin.x-5, corigin.y - 11, corigin.x + 16, corigin.y-3, corigin.x +16, corigin.y  );
    triangle(corigin.x+4, corigin.y - 11, corigin.x - 17, corigin.y-3, corigin.x -17, corigin.y );

    fill(defaultColor);
    stroke(defaultColor);
    triangle(corigin.x + 7, corigin.y - 5, corigin.x, corigin.y +2, corigin.x -7, corigin.y -5);
    rect(corigin.x, corigin.y-7, 15, 3);

    rect(corigin.x, corigin.y - 9, 30, 1);
    rect(corigin.x - 15, corigin.y - 11, 1, 2);
    rect(corigin.x + 15, corigin.y - 11, 1, 2);

    rect(corigin.x - 5, corigin.y - 11, 2, 4);
    rect(corigin.x + 5, corigin.y - 11, 2, 4);

    fill(255);
    stroke(255);
    rect(corigin.x-5, corigin.y - 7, 1, 2);
    rect(corigin.x+5, corigin.y - 7, 1, 2);
    
    if( isActive() ){
      popMatrix();
      shoot();
      if(curveOrigin.y > HEIGHT_ + 48 ){
        curveOrigin = new PVector(250, 0);
        setReturning();
      }
    } else if (isReturning() && 
      curveOrigin.x <= origin.x + 3 && curveOrigin.x >= origin.x - 3 &&
      curveOrigin.y <= origin.y + 3 && curveOrigin.y >= origin.y - 3 ){ 
      clearStatus();
    }
  }
  
  void shoot(){
    if( shooterCooldown <= 0 ){
      float x = curveOrigin.x * cos(defRotation) - curveOrigin.y * sin(defRotation) + origin.x;
      float y = curveOrigin.x * sin(defRotation) + curveOrigin.y * cos(defRotation) + origin.y + 25;
      PVector actualPos = new PVector( x, y);
      enemeyBulletsObj.addBullet(actualPos);
      shooterCooldown = coolDownInterval;
    } 
    shooterCooldown = shooterCooldown - 1;
  }
  
  void movement( PVector addition){
    if( isReturning() ){
      if( curveOrigin.x > origin.x) curveOrigin.x--; 
      else if( curveOrigin.x < origin.x) curveOrigin.x++; 
      if(curveOrigin.y > origin.y) curveOrigin.y--; 
      else if(curveOrigin.y < origin.y) curveOrigin.y++;
    } else if( isActive() ){
      pushMatrix();
      translate(origin.x, origin.y);
      rotate(defRotation);
      curveOrigin.x = curveOrigin.x + (sin(angle) *scalar * levelSpeedMod[scoreObj.level]);
      angle = angle + speed;
      curveOrigin.y = (curveOrigin.y + (1* levelSpeedMod[scoreObj.level])) % (HEIGHT_ + 50);
    }
    origin = new PVector( origin.x + addition.x, origin.y + addition.y);
  }
  
  void activate(boolean fromR){ 
    setActive();
    curveOrigin = new PVector(0,0);
    if( fromR ) defRotation = PI/5.0;
    else defRotation = -PI/9.0;
  }
  
  void explode(){ setExploding(); }
  
  void exploder(){
     if( isActive() ){
      pushMatrix();
      translate(origin.x, origin.y);
      rotate(defRotation);
     } 
     PVector corigin = isReturning() || isActive() ? curveOrigin : origin;
     noStroke(); 
     fill(getDefaultColor()); 
     rect( corigin.x-(i*10), corigin.y, diameter, diameter);  
     rect( corigin.x+(i*10), corigin.y, diameter, diameter); 
     rect( corigin.x, corigin.y-(i*10), diameter, diameter); 
     rect( corigin.x, corigin.y+(i*10), diameter, diameter); 
     diameter-=0.5; 
     i++; 
     if( isActive()) popMatrix();
     if(diameter <=0){ setDead(); } 
  }
}