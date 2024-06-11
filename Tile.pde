public class Tile{
boolean spike;
int lane;
float multi;

Tile(int l, float m){
  float r = random(3);
  if (r < 1){
    spike = true;
  } else{
    spike = false;
  }
  lane = l;
  multi = m;
}

}
