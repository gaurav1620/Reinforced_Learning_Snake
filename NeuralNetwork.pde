//  THIS NEURAL NETWORKS IS CAPABLE OF MAKING ONLY ONE HIDDEN LAYER OF VARIABLE NEURONS
class NeuralNetwork {
  int input;
  int output;
  int hidden;

  Matrix inputs; //inputs
  Matrix Wih;    //Weights of inputs to hidden
  Matrix Bih;    //Biases of inputs to hidden
  Matrix ih;     //weighted sum of input nodes
  Matrix ho;     //output of activation function for hidden layer
  Matrix Who;    //Weight for hidden to output
  Matrix Bho;    //Biases for hidden to output
  Matrix wo;     //Weighted sum for output layer
  Matrix outputs;//wo after passing through a activation function



  //Construcor
  NeuralNetwork(int i, int h, int o) {
    input = i;
    hidden = h;
    output = o;

    inputs  = new Matrix(input, 1);
    Wih     = new Matrix(hidden, input);
    Bih     = new Matrix(hidden, 1);
    ih      = new Matrix(hidden, 1);
    ho      = new Matrix(hidden, 1);
    Who     = new Matrix(output, hidden);
    Bho     = new Matrix(output, 1);
    wo      = new Matrix(output, 1);
    outputs = new Matrix(output, 1);
  }

  //INITIALIZE RANDOM WEIGHTS
  void init() {
    Wih.randomize(-1, 1);
    Who.randomize(-1, 1);
    Bih.randomize(-1, 1);
    Bho.randomize(-1, 1);
  }

  //FEED FORWARD
  Matrix feedForward() {
    Matrix tmp = Wih.multiply(inputs);
    ih = tmp.add(Bih);
    ho = sigmoid(ih);
    Matrix var = Who.multiply(ho);
    wo = var.add(Bho);
    outputs = sigmoid(wo);

    // this.debugPrint();
    //outputs.display();
    return outputs;
  }

  //MUTATE
  NeuralNetwork mutate() {
    
    //&
    //Matrix bef = Wih;
    //Wih.display();
    //&
    //println("\n\nPrevious : \n");
    //debugPrint();
    //println("\n\n");
    Wih = Wih.mutate();
    Who = Who.mutate();
    //println("\n\nAfter mutation : \n");
    //debugPrint();
    //println("\n\n");
    //*
    //Wih.display();
    //Matrix after = Wih;
    //bef.subtract(after);
    //bef.display();
    //*
    return this;
  }
  void mutate(int c) {
    Wih = Wih.mutate();
    Who = Who.mutate();
    
  }

  //DEBUG
  void debugPrint() {
    println("inputs");
    inputs.display();
    println("Wih");
    Wih.display();
    println("Bih");
    Bih.display();
    println("ih");
    ih.display();
    println("ho");
    ho.display();
    println("Who");
    Who.display();
    println("Bho");
    Bho.display();
    println("wo");
    wo.display();
    println("Outputs");
    outputs.display();
  }


  //SIGMOID for matrix
  Matrix sigmoid(Matrix arg) {
    int row = arg.rows;
    int col = arg.columns;
    Matrix newM = new Matrix(row, col);
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        newM.matrix[i][j] = sigmoid(arg.matrix[i][j]);
      }
    }
    return newM;
  }

  float sigmoid(float arg) {
    return 1/(1+exp(-arg));
  }
}
