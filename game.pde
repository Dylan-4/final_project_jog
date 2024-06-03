private Character player;
private float grav = 0.5;
private boolean alive, started;
private float up, down, left, right;
private int score;
private int ground = 660;
private int jumps = 2;

void setup(){
  size (800, 800);
  player = new Character();
  player.location = new PVector (width/2, ground);
  player.direction = 1;
  player.velocity = new PVector(0, 0);
  player.walk = 5;
  player.jump = 15;
  score = 0;
  alive = true;
  started = true;
}

void draw(){
  if(alive && started){
    score();
    tunnel();
    update();
    startScreen();
  }
  else {
    background(0);
    textSize (120);
    fill(235, 64, 52);
    text("YOU DIED", 160, 200);
    textSize (80);
    text("Your score was: " + score, 60, 450);
    fill(66, 135, 245);
    textSize (60);
    text("Press = to play again", 150, 650);
  }
}

void startScreen(){
  if (alive){
    textSize (80);
    fill(0);
    text("SURVIVE", 255, 80);
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
  if (key == 'o'){
    alive = false;
  }
  if (key == '=' && !alive){
    setup();
    
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
