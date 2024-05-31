private Character player;
private float grav = 0.5;
private String name;
private boolean alive, canJump;
private float up, down, left, right;
private int speed, score;
private int ground = 680, leftWall, rightWall;

void setup(){
  size (800, 800);
  player = new Character();
  player.location = new PVector (width/2, ground);
  score = 0;
  alive = true;
}
void score(){
  if (alive){
    score += 500;
  }
  if(score % 1000 == 0){
    print(score);
  }
}
void draw(){
  background(66, 135, 245);
  stroke(0);
  strokeWeight(4);
  fill(0);
  line(width, height, width/2, height/2);
  line(width, 0, width/2, height/2);
  line(0, 0, width/2, height/2);
  line(0, height, width/2, height/2);
  rect(width/2 - 50, height/2 - 50, 100, 100);
  
  line(width/2, height, width/2, height/2);
  line(width/4, height, width/2, height/2);
  line(3*width/4, height, width/2, height/2);
  rect(width/2 - 50, height/2 - 50, 100, 100);
  vy += grav;
  x += vx;
  y += vy;
  if (alive){
    guy(x, y);
  }
  control();
}
  
void guy(float x, float y){
  fill(41, 84, 153);
  strokeWeight(0);
  ellipse(x, height - 100, 80, 40);
  stroke(0);
  strokeWeight(4);
  fill(150);
  ellipse(x, y, 80, 80);
  y ++;
}
  
void jump(){
  y = 200;
  canJump = true;
}

void keyPressed(){
  if(key == 'a'){
    x -= 5;
  }
  if(key == 'd'){
    x += 5;
  }
  if(key == ' ' && canJump){
    y -= 40;
  }
}

void control(){
  if (y == height - 135){
    canJump = true;
  }
  if (keyPressed){
    if(key == 'a'){
      x = x - 5;
    }
    else if(key == 'd'){
      x = x + 5;
    }
  }
}
