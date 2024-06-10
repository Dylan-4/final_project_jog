class MyTile{
PVector location;
boolean spike;

MyTile(int x, int y){
  location = new PVector(x, y);
  if (random(4) < 1){
    spike = true;
  } else{
    spike = false;
  }
}
}
