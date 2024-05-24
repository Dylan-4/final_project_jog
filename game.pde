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
  y = height/2;
  grounded = false;
  speed = 1;
  alive = true;
}
void score(){
  while (alive){
    score++;
  }
  if(score % 1000 == 0){
    print(score);
  }
}
  void draw(){
    background(0);
    if(alive){
      guy(x, y);
    }
    if(key == 'a'){
    x = x - speed;
    }
    if(key == 'd'){
      x = x + speed;
    }
  }
  
  void guy(int x, int y){
    stroke(1);
    strokeWeight(3);
    fill(64, 222, 140);
    ellipse(x, y, 150, 150);
    y ++;
  }
  
void control(){
  if(key == 'a'){
    x = x - speed;
  }
  if(key == 'd'){
    x = x + speed;
  }
  if(key == ' '){
  }
}
