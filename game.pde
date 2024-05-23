private int score = 0;
private int location;
private float grav = 0.2;
private String name;
private boolean alive;

void setup(){
  size (800, 800);
  while (alive){
    score++;
  }
  Player p = new Player();
}

void control(){
  if(key == 'a'){
    Player.move(-1);
  }
  if(key == 'd'){
    Player.move(-1);
  }
  if(key == ' '){
    Player.move(-1);
  }
}
