public class Tile{
  boolean spike;
  int lane;
  float back, front;

  Tile(int l, float b, float f){
    //chance of being spike
    float r = random(6);
    if (r < 1){
      spike = true;
    } else{
      spike = false;
    }
    lane = l;
    back = b;
    front = f;
  }
}
