private Character player;
private Tile[][] tiles = new Tile[26][4];
private float grav = 0.6;
private boolean alive, started = false;
private float up, down, left, right;
private int score = 0;
private int ground = 660;
private float wall = 140;

void setup(){
  size (800, 800);
  score = 0;
  player = new Character();
  player.location = new PVector (width/2, ground);
  //intially creates tiles
  for (int i = 0; i < tiles.length; i++){
    for (int j = 0; j < tiles[0].length; j++){
      tiles[i][j] = new Tile(j + 1, 25 / pow(1.25, i + 1), 25 / pow(1.25, i));
    }
  }
}

void score(){
  if (alive){
    score += 1;
    textSize (80);
    fill(0);
    text("SCORE: " + score, 200, 80);
  }
}

void startScreen(){
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
  fill(150);
  triangle(width/2 + 60, height/2, width/2 - 50, height/2 - 60, width/2 - 50, height/2 + 60);
}

void deathScreen(){
  background(0);
  textSize (120);
  fill(235, 64, 52);
  text("YOU DIED", 160, 200);
  textSize (80);
  text("Your score was: " + score, 60, 410);
  fill(66, 135, 245);
  textSize (60);
  text("Press = to play again", 150, 580);
  text("Press - to go to start screen", 60, 670);
}

void draw(){
  //active game
  if(alive){
    tunnel();
    update();
    generate();
    score();
    if (score <= 100){
      textSize (100);
      fill(50, 168, 82);
      text("SURVIVE", 220, 400);
    }
  }
  //start screen
  else if (!started && !alive) {
    startScreen();
  }
  //death screen
  else {
    deathScreen();
  }
}

void tunnel(){
  background(66, 135, 245);
  //draws every tile
  for (int i = 0; i < tiles.length; i++){
    for (int j = 0; j < tiles[0].length; j++){
      tile(tiles[i][j]);
    }
  }
  strokeWeight(5);
  stroke(0);
  fill(0);
  //walls of tunnel
  line(width, height, width/2, height/2);
  line(width, 0, width/2, height/2);
  line(0, 0, width/2, height/2);
  line(0, height, width/2, height/2);
  //four lanes
  line(width/2, height, width/2, height/2);
  line(width/4, height, width/2, height/2);
  line(3*width/4, height, width/2, height/2);
  rect(width/2 -25,height/2 -25, 50, 50);
}

void avatar(float x, float y){
  //shadow
  fill(0);
  strokeWeight(0);
  ellipse(x, height - 98, 80, 40);
  //antenna
  stroke(80);
  strokeWeight(4);
  fill(150);
  line(x, y, x + 35, y - 60);
  line(x, y, x - 35, y - 60);
  ellipse(x + 35, y - 60, 8, 8);
  ellipse(x - 35, y - 60, 8, 8);
  //arms
  triangle(x + 15, y - 23, x + 65, y + 6, x + 45, y + 14);
  triangle(x - 15, y - 23, x - 65, y + 6, x - 45, y + 14);
  //legs
  triangle(x + 6, y + 20, x + 14, y + 52, x + 35, y + 45);
  triangle(x - 6, y + 20, x - 14, y + 52, x - 35, y + 45);
  //body
  ellipse(x, y, 80, 80);
}

void tile(Tile t){
  strokeWeight(4);
  //red if spike
  if (t.spike){
    stroke(245, 66, 66);
    fill(245, 66, 66);
  //transparent if not
  } else {
    stroke(0, 0);
    fill(0, 0);
  }
  if (t.lane == 1){
    quad(width/2 - t.back, height/2 + t.back, width/2 - t.back/2, height/2 + t.back, width/2 - t.front/2, height/2 + t.front, width/2 - t.front, height/2 + t.front);
    if (ground <= player.location.y && player.location.x >= width/2 - t.back && player.location.x <= width/2 - t.back/2 && ground + 40 <= height/2 + t.front && ground + 40 >= height/2 + t.back && t.spike){
      alive = false;
    }
  } 
  else if (t.lane == 2){
    quad(width/2 - t.back/2, height/2 + t.back, width/2, height/2 + t.back, width/2, height/2 + t.front, width/2 - t.front/2, height/2 + t.front);
    if (ground <= player.location.y && player.location.x >= width/2 - t.back/2 && player.location.x <= width/2 && ground + 40 <= height/2 + t.front && ground + 40 >= height/2 + t.back && t.spike){
      alive = false;
    }
  }
  else if (t.lane == 3){
    quad(width/2 + t.back/2, height/2 + t.back, width/2, height/2 + t.back, width/2, height/2 + t.front, width/2 + t.front/2, height/2 + t.front);
    if (ground <= player.location.y && player.location.x >= width/2 && player.location.x <= width/2 + t.back/2 && ground + 40 <= height/2 + t.front && ground + 40 >= height/2 + t.back && t.spike){
      alive = false;
    }
  }
  else if (t.lane == 4){
    quad(width/2 + t.back, height/2 + t.back, width/2 + t.back/2, height/2 + t.back, width/2 + t.front/2, height/2 + t.front, width/2 + t.front, height/2 + t.front);
    if (ground <= player.location.y && player.location.x >= width/2 + t.back/2 && player.location.x <= width/2 + t.back && ground + 40 <= height/2 + t.front && ground + 40 >= height/2 + t.back && t.spike){
      alive = false;
    }
  }
  //moves each part based on where they are
  t.back += t.back * 0.03;
  t.front += t.front * 0.03;
}

//recreates tiles when they are out of frame
void generate(){
  for (int i = 0; i < tiles.length; i++){
    for (int j = 0; j < tiles[0].length; j++){
      if (tiles[i][j].back >= height/2){
        tiles[i][j] = new Tile(tiles[i][j].lane, 20, 25);
      }
    }
  }
}

void update(){
  //if not on the ground, gravity affects velocity
  if (ground > player.location.y){
    player.velocity.y += grav;
  }
  else {
    player.velocity.y = 0;
  }
  control();
  avatar(player.location.x, player.location.y);
}

void control(){
  //detects if player is on the ground and not already jumping
  if (ground <= player.location.y && up != 0){
    player.velocity.y -= player.jump;
  }
  //adds left and right together so movement is neutral when both directions are pressed
  player.velocity.x = (left + right) * player.walk;
  //prevents player from going out of bounds
  PVector future = new PVector(player.location.x, player.location.y);
  future.add(player.velocity);
  //if can move, player moves
  if (future.x > wall && future.x < (width - wall)){
    player.location.x = future.x;
  }
  player.location.y = future.y;
}

void keyPressed(){
  if (key == 'a'){
    left = -1;
  }
  if (key == 'd'){
    right = 1;
  }
  if (key == 's'){
    down = 1;
    grav += 0.6;
  }
  if (key == ' '){
    up = -1;
  }
  //play and retry
  if (key == '=' && !alive){
    setup();
    alive = true;
    started = true;
  }
  //start screen
  if (key == '-' && !alive){
    setup();
    started = false;
  }
}

void keyReleased(){
  //keyReleased makes controls feel responsive
  if (key == 'a'){
    left = 0;
  }
  if (key == 'd'){
    right = 0;
  }
  if (key == 's'){
    down = 0;
    grav = 0.6;
  }
  if (key == ' '){
    up = 0;
  }
}
