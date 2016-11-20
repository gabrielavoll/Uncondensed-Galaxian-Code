class EnemyBullets {
  PVector [] bullets; 

  EnemyBullets(){
    bullets = new PVector[0] ; 
  }
  
  void display() {
    rectMode(CENTER);
    fill(255, 255, 100);
    stroke(255, 255, 100);
    for (int i = 0; i< bullets.length; i++) ellipse(bullets[i].x, bullets[i].y, 1, 5);
    movement();
  } 

  void addBullet(PVector position) {
    bullets = (PVector [])append(bullets, new PVector( position.x, position.y -25));
  }

  void deleteBullet(int i) {
    bullets = (PVector [])concat( (PVector [])subset(bullets, 0, i), (PVector [])subset(bullets, i + 1 ));
  }

  void movement() {
    for (int i = 0; i< bullets.length; i++) {
      bullets[i] = new PVector( bullets[i].x, bullets[i].y + 6 );
      if (bullets[i].y > HEIGHT_) deleteBullet(i);
    }
  }
  
}