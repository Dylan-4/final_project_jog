private Character player;
private float grav = 0.5;
private String name;
private boolean alive;
private float up, down, left, right;
private int score;
private int ground = 660;

void setup(){
  size (800, 800, P3D);
  player = new Character();
  player.location = new PVector (width/2, ground);
  player.direction = 1;
  player.velocity = new PVector(0, 0);
  player.walk = 5;
  player.jump = 15;
  score = 0;
  alive = true;
}

void startScreen(){
  if (alive){
    textSize (80);
    fill(0);
    text("Choose your character", 40, 200);
    text("Choose your character", 40, 200, -120);
  }
}

void score(){
  if (alive){
    score += 4;
  }
  if(score % 1000 == 0){
    println("Score is " + score);
  }
}

void tunnel(){
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
}

void draw(){
  score();
  tunnel();
  update();
  startScreen();
}

void update(){
  if (player.location.y < ground){
    player.velocity.y += grav;
  }
  else {
    player.velocity.y = 0;
  }
  control();
  guy(player.location.x, player.location.y);
}
  
void guy(float x, float y){
  fill(0);
  strokeWeight(0);
  ellipse(x, height - 100, 80, 40);
  stroke(0);
  strokeWeight(4);
  fill(150);
  ellipse(x, y, 80, 80);
  y ++;
}

void control(){
  if (ground <= player.location.y && up != 0){
    player.velocity.y = -player.jump;
  }
  player.velocity.x = (left + right) * player.walk;
  
  PVector future = new PVector(player.location.x, player.location.y);
  future.add(player.velocity);
  
  float wall = 140;
  
  if (future.x > wall && future.x < (width - wall)){
    player.location.x = future.x;
  }
  if (future.y > 0 && future.y < (height - 0)){
    player.location.y = future.y;
  }
}

void keyPressed(){
  if (key == 'a'){
    left = -1;
    player.direction = 1;
  }
  if (key == 'd'){
    right = 1;
    player.direction = -1;
  }
  if (key == 's'){
    down = 1;
  }
  if (key == ' '){
    up = -1;
  }
}

void keyReleased(){
  if (key == 'a'){
    left = 0;
  }
  if (key == 'd'){
    right = 0;
  }
  if (key == 's'){
    down = 0;
  }
  if (key == ' '){
    up = 0;
  }
}
