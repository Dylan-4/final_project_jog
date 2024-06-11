private Character player;
private Tile one, two , three, four;
private float grav = 0.5;
private boolean alive, started;
private float up, down, left, right;
private int score;
private int ground = 660;

void setup(){
  size (800, 800);
  generate();
  player = new Character();
  player.location = new PVector (width/2, ground);
  player.direction = 1;
  player.velocity = new PVector(0, 0);
  player.walk = 5;
  player.jump = 20;
  score = 0;
  alive = false;
  started = false;
}

void scoreDraw(){
  if (alive){
    textSize (80);
    fill(0);
    text("SCORE: " + score, 230, 80);
  }
}

void score(){
  if (alive){
    score += 1;
  }
}

void draw(){
  if(alive && started){
    score();
    tunnel();
    update();
    scoreDraw();
    generate();
  }
  else if (!started && !alive) {
    background(255);
    textSize (120);
    fill(235, 64, 52);
    text("Jog", 300, 180);
    fill(66, 135, 245);
    textSize (60);
    text("Press = to start", 220, 650);
    stroke(0);
    strokeWeight(4);
    fill(200);
    ellipse(width/2, height/2, 250, 250);
    fill(0);
    triangle(width/2 + 40, height/2, width/2 - 40, height/2 - 40, width/2 - 40, height/2 + 40);
  }
  else if (started && !alive){
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

void generate(){
  if (score % 100 == 0){
    one = new Tile(1, 20, 25);
  }
}

void tileDraw(Tile t){
  float d = 2;
  if (t.spike){
    fill(245, 66, 66);
  } else {
    fill(0, 0);
  }
  if (t.lane == 1){
    quad(width/2 -(d * score % (d * 200)), height/2 +(d * score % (d * 200)), width/2 - ((d * score % (d * 200)))/2, height/2 +(d * score % (d * 200)), width/2 - (((d * 1.25) * score % (d * 250)))/2, height/2 +((d * 1.25) * score % (d * 250)), width/2 -((d * 1.25) * score % (d * 250)), height/2 +((d * 1.25) * score % (d * 250)));
  }
  else if (t.lane == 2){
    quad(width/2 - ((d * score % (d * 200)))/2, height/2 +(d * score % (d * 200)), width/2, height/2 +(d * score % (d * 200)), width/2, height/2 +((d * 1.25) * score % (d * 250)), width/2 - (((d * 1.25) * score % (d * 250)))/2, height/2 +((d * 1.25) * score % (d * 250)));
  }
  else if (t.lane == 3){
    quad(width/2 + ((d * score % (d * 200)))/2, height/2 +(d * score % (d * 200)), width/2, height/2 +(d * score % (d * 200)), width/2, height/2 +((d * 1.25) * score % (d * 250)), width/2 + (((d * 1.25) * score % (d * 250)))/2, height/2 +((d * 1.25) * score % (d * 250)));
  }
  else if (t.lane == 4){
    quad(width/2 +(d * score % (d * 200)), height/2 +(d * score % (d * 200)), width/2 + ((d * score % (d * 200)))/2, height/2 +(d * score % (d * 200)), width/2 + (((d * 1.25) * score % (d * 250)))/2, height/2 +((d * 1.25) * score % (d * 250)), width/2 +((d * 1.25) * score % (d * 250)), height/2 +((d * 1.25) * score % (d * 250)));
  } 
}

void tileDraw2(Tile t){
  if (t.spike){
    fill(245, 66, 66);
  } else {
    fill(0, 0);
  }
  if (t.lane == 1){
    quad(width/2 - t.p1, height/2 + t.p1, width/2 - t.p1/2, height/2 + t.p1, width/2 - t.p2/2, height/2 + t.p2, width/2 - t.p2, height/2 + t.p2);
    t.p1 += t.p1 * 0.03;
    t.p2 += t.p2 * 0.03;
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
  fill(0, 0);
  
  fill(0);
  line(width/2, height, width/2, height/2);
  line(width/4, height, width/2, height/2);
  line(3*width/4, height, width/2, height/2);
  tileDraw2(one);
  fill(0);
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
  ellipse(x, height - 97, 80, 40);
  stroke(80);
  strokeWeight(4);
  fill(150);
  line(x, y, x + 35, y - 60);
  line(x, y, x - 35, y - 60);
  ellipse(x + 35, y - 60, 8, 8);
  ellipse(x - 35, y - 60, 8, 8);
  
  triangle(x + 15, y - 23, x + 65, y + 6, x + 45, y + 14);
  triangle(x - 15, y - 23, x - 65, y + 6, x - 45, y + 14);
  
  triangle(x + 6, y + 20, x + 14, y + 52, x + 35, y + 45);
  triangle(x - 6, y + 20, x - 14, y + 52, x - 35, y + 45);
  
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
    alive = true;
    started = true;
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
