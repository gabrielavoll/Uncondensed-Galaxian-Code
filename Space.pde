class Space{
  int count =0;
  PVector [] wStars = new PVector[0]; 
  PVector [] rStars = new PVector[0]; 
  PVector [] bStars = new PVector[0]; 
  
  Space(){
    for(int i = 0; i< 90; i ++) wStars = (PVector [])append(wStars, new PVector(random(0,WIDTH_), random(0,HEIGHT_)));
    for(int i = 0; i< 10; i ++) rStars = (PVector [])append(rStars, new PVector(random(0,WIDTH_), random(0,HEIGHT_)));
  } 
  
  void display(){
    background(0);
    noStroke();
    fill(255);
    for(int i = 0; i< 30; i ++) ellipse(wStars[i].x, (wStars[i].y + count) % HEIGHT_, 2,2); 
    fill(255,150);
    for(int i = 30; i< 60; i ++) ellipse(wStars[i].x, (wStars[i].y + count/2) % HEIGHT_, 2,2); 
    fill(255, 75);
    for(int i = 60; i< 90; i ++) ellipse(wStars[i].x, (wStars[i].y + count/6) % HEIGHT_, 2,2); 
    fill(100,200,255);
    for(int i = 0; i< 5; i ++) ellipse(rStars[i].x, ( rStars[i].y + count) % HEIGHT_, 2,2); 
    fill(100,200,255, 150);
    for(int i = 3; i< rStars.length; i ++) ellipse(rStars[i].x, ( rStars[i].y + count/2) % HEIGHT_, 2,2); 
    movement();
  }
  
  void movement(){
    count = count + 1;
    if( count > HEIGHT_ * 6) count = 0;
  }
  
   void hyperDisplay(int hyperSpeed){
    background(0);
    noStroke();
    fill(255);
    for(int i = 0; i< 30; i ++) ellipse(wStars[i].x, (wStars[i].y + count) % HEIGHT_, 2,2); 
    fill(255,150);
    for(int i = 30; i< 60; i ++) ellipse(wStars[i].x, (wStars[i].y + count/2) % HEIGHT_, 2,2); 
    fill(255, 75);
    for(int i = 60; i< 90; i ++) ellipse(wStars[i].x, (wStars[i].y + count/6) % HEIGHT_, 2,2); 
    fill(100,200,255);
    for(int i = 0; i< 5; i ++) ellipse(rStars[i].x, ( rStars[i].y + count) % HEIGHT_, 2,2); 
    fill(100,200,255, 150);
    for(int i = 3; i< rStars.length; i ++) ellipse(rStars[i].x, ( rStars[i].y + count/2) % HEIGHT_, 2,2); 
    hyperMovement(hyperSpeed);
  }

   void hyperMovement(int hyperSpeed){
    if(hyperSpeed >= 5000 ) count = count + max(2 * (5000 - (hyperSpeed-5000))/500, 1);
    else  count = count + max(2 * hyperSpeed/500, 1);
    
    if( count > HEIGHT_ * 6) count = 0;
  }
  
}