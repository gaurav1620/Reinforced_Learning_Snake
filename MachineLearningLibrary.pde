import java.util.Collections;
//#region [rgba(100,0,100,0.5)]
//Auto Format for Processing(Ctrl-T)
/**********************************************************************
 * NEURAL NETWORK 
 * Designed by :
 
   ______                            
  / ____/___ ___  ___________ __   __
 / / __/ __ `/ / / / ___/ __ `/ | / /
/ /_/ / /_/ / /_/ / /  / /_/ /| |/ / 
\____/\__,_/\__,_/_/   \__,_/ |___/ 
 
    __ __ __          _                      
   / //_// /_  ____ _(_)________  ____ ______
  / ,<  / __ \/ __ `/ / ___/ __ \/ __ `/ ___/
 / /| |/ / / / /_/ / / /  / / / / /_/ / /    
/_/ |_/_/ /_/\__,_/_/_/  /_/ /_/\__,_/_/     
 
 ****************************************************************
 //July 2019
 
 @ Website : gaurav1620.rf.gd
 @ Github  : gaurav1620
 @ Insta   : may_be_gaurav 
 @ Gmail   : gauravak007@gmail.com
 
 */
//************************************************************************************************
//#endregion
// ArrayList<snake> sL = new ArrayList<snake>();

// void init(){
//   for(int i = 0;i < 10;i++){
//     sL.add(new snake());
//   }
//   for(int i = 0;i < 10;i++){
//     sL.get(i).init();
//   }
// }

// void setup(){
//   size(600,400);
//   init();
// }
// void draw(){
//   background(0);

//   for(int i = 0;i < 10;i++){
//     sL.get(i).show();
//     sL.get(i).doPredictedMovement();
//   }
//   for(int i = 0;i < 10;i++){
//     sL.get(i).doPredictedMovement();
//   }

// }

int noOfSnakes = 10;
int noOfFoods =30;
int fr = 100;
int frchange = 1;

ArrayList<snake> snakes = new ArrayList<snake>();
ArrayList<snake> savedSnakes = new ArrayList<snake>();
ArrayList<food> foods = new ArrayList<food>();

void setup(){
  newGeneration();
  size(600,400);
  frameRate(fr);
}

//
void keyPressed(){
  fr-= frchange;
}

void draw(){
  frameRate(fr);
  background(0);
  showFoods();
  showSnakes();
  checkHitForAllSnakes();
  checkEatenFood();
  moveSnakes();
  
  if(snakes.size() == 0){
    newGeneration(69);
  }  
}

//Move snakes by predicted movement
void moveSnakes(){
  for(int i = 0;i < snakes.size();i++){
    snakes.get(i).doPredictedMovement(foods);
  }
}

//Stores the indexes to be removed and removes from back
void checkHitForAllSnakes(){
  ArrayList<Integer> toRemove = new ArrayList<Integer>();
  for(int i = 0;i < snakes.size();i++){
    if(snakes.get(i).hit() || snakes.get(i).health == 0){
      toRemove.add(i);
    }
  }
  for(int i = toRemove.size()-1 ;i >= 0 ;i--){
    int c = toRemove.get(i);
    snake tmp = snakes.get(c);
    savedSnakes.add(tmp);
    snakes.remove(c);
  }
  
}

//Check if the food is eaten then remove it
void checkEatenFood(){
  ArrayList<Integer> foodRemInd = new ArrayList<Integer>();
  ArrayList<Integer> toAddPartSnakes = new ArrayList<Integer>();
  for(int i = 0;i < snakes.size();i++){
    for(int j = 0;j < foods.size();j++){
      if(sqrt((snakes.get(i).x + 15*0.5 - foods.get(j).x + 10*0.5)*(snakes.get(i).x + 15*0.5 - foods.get(j).x + 10*0.5)
       + (snakes.get(i).y  + 15*0.5 - foods.get(j).y + 10*0.5)*(snakes.get(i).y  + 15*0.5 - foods.get(j).y)) < 15){
        
        if(!foodRemInd.contains(j)){ 
          foodRemInd.add(j);
        }

        if(!toAddPartSnakes.contains(i)){
          toAddPartSnakes.add(i);
        }
      }
    }
  }
  Collections.sort(foodRemInd);
  for(int i = foodRemInd.size() -1 ;i >=0;i--){
    int j = foodRemInd.get(i);
    foods.remove(j);
  }
  for(int i =0;i < toAddPartSnakes.size();i++){
    int k = toAddPartSnakes.get(i);
    snakes.get(k).health += 100;

    snakes.get(k).addAtBack();
  }
}


void showSnakes(){
  for(int i = 0;i < snakes.size();i++){
    snakes.get(i).update();
    snakes.get(i).show();
  }
}

void showFoods(){
  for(int i = 0;i < foods.size();i++){
    foods.get(i).show();
  }
}

//With brain passed as arg and also does mutation
void newGeneration(int x){
  snake bestSnake = new snake();
  int bstHealth = 0;
  for(int i = 0;i < savedSnakes.size();i++){
    if(bstHealth < savedSnakes.get(i).health){
      bstHealth = savedSnakes.get(i).health;
      bestSnake = savedSnakes.get(i);
    }
  }

  NeuralNetwork b = bestSnake.brain;
  //begin test
  // println("Best snake weights before mutation : ");
  // b.debugPrint();
  //end test

  //b = b.mutate();
  
  //b.mutate(2);

  //begin test
  // println("Best snake weights after mutation : ");
  // b.debugPrint();
  //end te  
  for(int i = 0;i < noOfSnakes;i++){
    snakes.add(new snake(b.mutate()));
  }
  foods = new ArrayList<food>();
  for(int i = 0;i < noOfFoods;i++){
    foods.add(new food());
  }
}

//For first init
void newGeneration(){
  for(int i = 0;i < noOfSnakes;i++){
    snakes.add(new snake());
  }
  
  foods = new ArrayList<food>();
  for(int i = 0;i < noOfFoods;i++){
    foods.add(new food());
  }
}void mouseClicked(){
  foods.add(new food(mouseX,mouseY));
}
