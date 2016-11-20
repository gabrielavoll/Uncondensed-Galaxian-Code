class Bullets {
  PVector bullet;

  Bullets() { bullet = null; }

  void display() {
    if( bullet != null){
      rectMode(CENTER);
      fill(255, 255, 100);
      stroke(255, 255, 100);
      ellipse(bullet.x, bullet.y, 1, 5);
      movement();
    }
  } 

  void addBullet(PVector position) {
    bullet = new PVector( position.x, position.y -25);
  }

  void deleteBullet() {
    bullet = null;
  }
  
  void movement() {
    bullet = new PVector( bullet.x, bullet.y - 6 );
    if (bullet.y < 0) bullet = null;
  }
}