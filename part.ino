class part{
  int size = 15;
  float x;
  float y;
  
  part(){
    x = random(width-size);
    y = random(height-size);
    
    //x = width-20;
    //y = height-20;
  }
  part(float x1,float y1){
    x = x1;
    y = y1;
  }
  
  void show(){
    rect(x, y, size, size, 3);
  }
}
