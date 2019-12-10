class snake {
  float x;
  float y;
  float partSize = 15;
  
  float velX = 0;
  float velY = 0;

  int len = 0;
  int health = 100; //50
  int fitness = 200; //100
  
  ArrayList<part> b = new ArrayList<part>();
  

  NeuralNetwork brain = new NeuralNetwork(4, 8, 4);  //6 input nodes for 2 for x and y pos of closest food and 2 for snakes heads x and y pos

  //Constructor
  snake(NeuralNetwork n){
    brain = n;
    init(3);
  }
  
  //Constructor
  snake(){
    init();
  }
  
  
  //Inititalization
  void init(){
    brain.init();
    b.add(new part());
    len++;
  }

  void init(int g){
    b.add(new part());
    len++;
  }



  void addAtBack(){
    if(velX > 0){
      addPart('l');
    }else if(velX < 0){
      addPart('y');
    }else if(velY > 0){
      addPart('u');
    }else if(velY < 0){
      addPart('d');
    }
  }
  
  void addPart(char a){
    int g = b.size();
    float x1 = b.get(g-1).x;
    float y1 = b.get(g-1).y;
    
    if(a == 'u'){
      b.add(new part(x1,y1-partSize));
    }else if(a == 'd'){
      b.add(new part(x1,y1+partSize));
    }else if(a == 'l'){
      b.add(new part(x1-partSize,y1));
    }else if(a == 'r'){
      b.add(new part(x1+partSize,y1));
    }
    len++;
  }
  
  void move(char a){
    if(a == 'u' && velY == 0){
      velX = 0;
      velY = -partSize;
    }else if(a == 'd' && velY==0){
      velX = 0;
      velY = partSize;
    }else if(a == 'l' && velX == 0){
      velX = -partSize;
      velY = 0;
    }else if(a == 'r'&& velX == 0){
      velX = partSize;
      velY = 0;
    }
    
  }
  
  void update(){
    //This is imp to update the x and y of snake to the head
    health--;
    x = b.get(0).x;
    y = b.get(0).y;

    if(b.size() > 1){
      for(int i = b.size() - 2;i >=0;i--){
        b.get(i+1).x = b.get(i).x;
        b.get(i+1).y = b.get(i).y;
      }
    }
    
    b.get(0).x += velX;
    b.get(0).y += velY;
  }
  
  //Display all the body parts
  void show() {
    fill(255);
    for (int i = 0; i < b.size(); i++) {
      b.get(i).show();
    }
  }

  void doPredictedMovement(ArrayList<food> f){
    food fi = calculateClosestFood(f);
  
    //brain.inputs.matrix[0][0] = (x - fi.x)/width;
    //brain.inputs.matrix[1][0] = (y - fi.y)/height;
    brain.inputs.matrix[0][0] = x;//x/width; 
    brain.inputs.matrix[1][0] = y;//y/height; 
    brain.inputs.matrix[2][0] = fi.x;//fi.x/width; 
    brain.inputs.matrix[3][0] = fi.y;//fi.y/height; 
    
    println("{X : ",x,"}{ Y : ",y,"}{ CLst F.X : ",fi.x,"}{ Clst F.y : ",fi.y);
  
    Matrix outputs = brain.feedForward();
    outputs.display();

    float minimum = 0.8;

    if(outputs.matrix[0][0] > minimum){
      move('l');
    }
    else if(outputs.matrix[1][0] > minimum){
      move('r');
    }
    else if(outputs.matrix[2][0] > minimum){
      move('u');
    }
    else if(outputs.matrix[3][0] > minimum){
      move('d');
    } 
  }
  //Calculates the closest food and returns it
  food calculateClosestFood(ArrayList<food> f){
    int closestIndex = 0;
    for(int i = 0;i < f.size();i++){
      if(distOfFood(f.get(i)) < distOfFood(f.get(closestIndex))){
        closestIndex = i;
      }
    }
    return f.get(closestIndex);
  }

  float distOfFood(food f){
    return sqrt((x-f.x)*(x-f.x) + (y-f.y)*(y-f.y));
  }

  float sqrt(float x){
    return pow(x,0.5);
  }

  float mod(float x){
    if(x < 0){return x*(-1);}
    return x;
  }

  //Check Whether the snake eats a food;
  void checkEat(ArrayList<food> f){

  }
  //MUTATE
  void mutate(){
    brain = brain.mutate();
  }
  
  //ALIVE check
  Boolean isAlive(){
    return fitness > 0;
  }

  //HIT Detection
  Boolean hit(){
    if(x<0 || x > width ||y > height||y < 0){
      return true;
    }
    return false;
  }
}
