public class Tile{
boolean spike;
int lane;
float p1, p2;

Tile(int l, float s, float e){
  float r = random(3);
  if (r < 1){
    spike = true;
  } else{
    spike = false;
  }
  lane = l;
  p1 = s;
  p2 = e;
}

}
