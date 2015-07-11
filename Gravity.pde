Ball myBall;
badBall badBall1;
badBall badBall2;
badBall badBall3;
goodBall goodBall1;
goodBall goodBall2;
int totalscore=0; 
float gravity = 0.6;
float tcon = 0.00001;
float easing = 0.05;
void setup(){
  size(420,800);
  smooth();
  ellipseMode(CENTER);
  myBall = new Ball(color(0,0,0),100,50,0,0);
  badBall1 = new badBall(color(255,0,0),135,550);
  badBall2 = new badBall(color(255,0,0),100,350);
  badBall3 = new badBall(color(255,0,0),325,500);
  goodBall1 = new goodBall(color(0,0,0),300,375);
  goodBall2 = new goodBall(color(0,0,0),375,200);
  noStroke();
}
void draw(){
  background(255);
  strokeWeight(20);
  stroke(1);
  line(0,300,100,300);
  line(200,300,420,300);
  line(0,450,250,450);
  line(325,450,420,450);
  line(0,600,50,600);
  line(130,600,420,600);
  line(0,800,420,800);
  myBall.display();
  myBall.drop();
  badBall1.display();
  badBall2.display();
  badBall3.display();
  goodBall1.display();
  goodBall2.display();
  fill(0);
  textSize(18);
  text("Your score: " + totalscore, 10, 30); 
}

class badBall {
  color c;
  float xpos;
  float ypos;
  boolean clearDone = false;
  badBall(color tempC, float tempXpos, float tempYpos){
    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
  }
  void display(){
    noStroke();
    if (clearDone == false){
      fill(255,0,0);
      ellipse(xpos,ypos,30,30);
    }
    if ((dist(myBall.xpos,myBall.ypos,xpos,ypos) <= 40) && clearDone == false){
      clearDone = true;
      totalscore = 0;
      goodBall1.scoreDone = false;
      goodBall2.scoreDone = false;
    }
  }
}

class goodBall {
  color c;
  float xpos;
  float ypos;
  boolean scoreDone = false;
  goodBall(color tempC, float tempXpos, float tempYpos){
    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
  }
  void display(){
    noStroke();
    if (scoreDone == false){
      fill(0,0,0);
      ellipse(xpos,ypos,30,30);
    }
    if ((dist(myBall.xpos,myBall.ypos,xpos,ypos) <= 40) && scoreDone == false){
      scoreDone = true;
      totalscore++;
    }
  }
}

class Ball {
  color c;
  float xpos;
  float ypos;
  float vx;
  float vy;
  Ball(color tempC, float tempXpos, float tempYpos, float tempVx, float tempVy){
    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
    vx = tempVx;
    vy = tempVy;
  }
  void display(){
    noStroke();
    fill(c);

    if (ypos <= 800-25 ){
      ellipse(xpos, ypos, 50, 50);
    }
    else{
      ellipse(xpos, 800 - 25, 50, 50);
      fill(255,0,0);
      textSize(64);
      if (totalscore == 2)
        text("Congrats! " , 50, 100); 
      else 
        text("Try Again! " , 50, 100); 
    }
  }
  void drop(){
    for (int i = 0; i < 100000; i++){
      vy += gravity*tcon;
      ypos += vy*tcon;
    }
    float targetX = mouseX;
    float dx = targetX - xpos;
    xpos += dx * easing;  
    /* The code below configures the bouncing. */
    if ((ypos > 800 - 25) && (vy > 0))
      vy *= -0.6;
    if ((ypos > 300 - 25) && (ypos < 330 - 25) && !( xpos > 125 && xpos < 175) && (vy > 0))
      vy *= -0.9;  
    if ((ypos > 450 - 25) && (ypos < 480 - 25) && !( xpos > 275 && xpos < 300) && (vy > 0))
      vy *= -0.9;  
    if ((ypos > 600 - 25) && (ypos < 650 - 25) && !( xpos > 75 && xpos < 105) && (vy > 0))
      vy *= -0.9;    
    if ((ypos > 270 + 25) && (ypos < 300 + 25) && !( xpos > 125 && xpos < 175) && (vy < 0))
      vy *= -0.9;  
    if ((ypos > 420 + 25) && (ypos < 450 + 25) && !( xpos > 275 && xpos < 300) && (vy < 0))
      vy *= -0.9;  
    if ((ypos > 570 + 25) && (ypos < 600 + 25) && !( xpos > 75 && xpos < 105) && (vy < 0))
      vy *= -0.9;    
  }
}
