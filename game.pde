private int score = 0;
private float grav = 0.2;
private String name;
private boolean alive;
private int x, y;
private int speed;
private boolean grounded;

void setup(){
  size (800, 800);
  x = width/2;
  y = height - 135;
  speed = 4;
  alive = true;
}
void score(){
  if (alive){
    score++;
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
  if (y == height - 135){
    grounded = true;
  }
  if(alive){
    guy(x, y);
  }
  if (keyPressed){
    if(key == 'a'){
      x = x - speed;
    }
    else if(key == 'd'){
      x = x + speed;
    }
    if (mousePressed && mouseButton == LEFT && grounded){
      jump();
    }
  }
}
  
void guy(int x, int y){
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
  y = y - 60;
  grounded = false;
}
