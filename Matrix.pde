class Matrix{

  int rows,columns;
  float[][] matrix;


  //Constructer
  Matrix(int r,int c){
    this.rows = r;
    this.columns = c;
    this.matrix = new float[r][c];
  }

  //Random numbers between 0 and 10
  void randomize(){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < columns;j++){
        this.matrix[i][j] = random(0,10);
      }
    }
  }
  
  //Random numbers between 0 and 10
  void randomizeInt(){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < columns;j++){
        this.matrix[i][j] = (int)random(0,10);
      }
    }
  }

  //Overloaded randomize
  void randomize(int upper){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < columns;j++){
        this.matrix[i][j] = random(0,upper);
      }
    }
  }
  
  //Overloaded randomize
  void randomizeInt(int upper){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < columns;j++){
        this.matrix[i][j] = (int)random(0,upper);
      }
    }
  }

  //overloaded Randomize
  void randomize(int lower,int upper){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < columns;j++){
        this.matrix[i][j] = random(lower,upper);
      }
    }
  }
  
  //overloaded Randomize
  void randomizeInt(int lower,int upper){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < columns;j++){
        this.matrix[i][j] = (int)random(lower,upper);
      }
    }
  }
  
  //Mutate
  Matrix mutate(){
    for(int i = 0;i < this.rows;i++){
      for(int j = 0;j < this.columns;j++){
        if(random(0,1) < 0.3){
          this.matrix[i][j] += randomGaussian()*0.5;
        }  
      }
    }
    return this;
  }

  //DISPLAY THE MATRIX
  void display(){
    if(this.rows == 0 && this.columns == 0){
      println("Null Matrix");
      return;
    }
    for(int j = 0;j < this.columns;j++){
        print("     ",j,"    ");
    }
    println();

    for(int i = 0;i < this.rows;i++){
      print(i," |");
      for(int j = 0;j < this.columns;j++){
        print(this.matrix[i][j],"| ");
      }

      println();
      for(int j = 0;j < this.columns;j++){
        print("____________");
      }
      println();
    }
  }

  //MULTIPLY A NUMBER 
  void multiply(float n){
    for(int i=0; i < this.rows;i++){
      for(int j = 0; j < this.columns;j++){
        this.matrix[i][j] *= n;
      }
    }
  }
  
  //ADD A NUMBER
  void add(float n){
    for(int i=0; i < this.rows;i++){
      for(int j = 0; j < this.columns;j++){
        this.matrix[i][j] += n;
      }
    }
  }

  
  //SUBTRACT A NUMBER
  void subtract(float n){
    this.add(-n);
  }

  void subtract(Matrix inp){
    float row = inp.rows;
    float col = inp.columns;

    if(this.rows != row || this.columns != col){
      println("Invalid Subtraction of matrix !! .. ");
      return;
    }

    for(int i=0; i < this.rows;i++){
      for(int j = 0; j < this.columns;j++){
        this.matrix[i][j] -= inp.matrix[i][j];
      }
    }

  }
  
  //ADD A MATRIX TO A MATRIX
  Matrix add(Matrix arg){
    if(this.rows != arg.rows || this.columns != arg.columns){
      println("Invalid operation (add) as rows or columns did not match ! ");
      return new Matrix(0,0);
    }
    Matrix newM = new Matrix(this.rows,this.columns);
    for(int i = 0;i < this.rows;i++){
      for(int j = 0;j < this.columns;j++){
        newM.matrix[i][j] = this.matrix[i][j] + arg.matrix[i][j];
      }
    }
    return newM;
  }
  
  //MULTIPLY A MATRIX WITH A MATRIX
  Matrix multiply(Matrix arg){
    if(this.columns != arg.rows){
      println("Invalid Multiplication of matrices !");
      return new Matrix(0,0);
    }
    Matrix newM = new Matrix(this.rows,arg.columns);
    for(int i =0;i < this.rows;i++){
      for(int j = 0;j < arg.columns;j++){
        
        float sum = 0;
        for(int k = 0;k < this.columns;k++){
          sum += this.matrix[i][k]*arg.matrix[k][j];
        }
        newM.matrix[i][j] = sum;
      }
    }
    return newM;
  }
  
  Matrix transpose(){
    int newCol = this.rows;
    int newRow = this.columns;
    Matrix newM = new Matrix(newRow,newCol);
    for(int i = 0; i < this.rows;i++){
      for(int j = 0; j < this.columns;j++){
        newM.matrix[j][i] = this.matrix[i][j];
      }  
    }
    
    return newM;
  }
  
  

}
