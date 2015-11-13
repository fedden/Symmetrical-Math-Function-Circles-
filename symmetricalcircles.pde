int amount = 50;
float rate = 0.008;
int radius = 100;
int smallCircleSize = 10;
int a = 0;
int b = 255;
float range = 1;
float increment = 0;
int symState = 0;
int colState = 0;
float lower = 0;
float higher = 100;
float r = 0;
float lerpX;
float lerpY;

void setup() {
  size(300, 300);                                  // set size
  noStroke();                                      // no stroke
  frameRate(60);                                 // init framerate
  colorMode(HSB);
}

void draw() {
  range = (1+(sin(increment+=rate)))*(78/30);
  colorManagement();
  background(0);                                   // set background
  for (int i = 0; i < amount; ++i) {               // loop through all circles
    //int f = (millis()/100 % amount == i) ? a : b;    // if frame % no circles equals current then colour differntly
    //fill(f);             // fill and then display ellipse below

    float f = map((i+1), 1, amount, lower, higher);
    fill(f, 255, 255);

    display(i, 0);
    display(i, PI/2);
    display(i, PI);
    display(i, 3*PI/2);
  }
}

void colorManagement() {
  float am = map(frameCount/10 % 100, 0, 100, 0, 1);
  if (am == 0) { 
    colState = ++colState % 3;
  }
  println(am);
  switch (colState) {
  case 0:
    lerpX = lerp(243, 88, am);
    lerpY = lerp(58, 101, am);
    break;
  case 1:
    lerpX = lerp(88, 3, am);
    lerpY = lerp(101, 113, am);
    break;
  case 2:
    lerpX = lerp(3, 243, am);
    lerpY = lerp(113, 58, am);
    break;
  }
  lower = map(lerpX, 0, width, 0, 255 - r);
  r = map(lerpY, 0, height, 1, 255);
  higher = lower + r;
}

void display(int _i, float _rot) {
  switch (symState) {
  case 0:
    ellipse(width/2 + sin(TWO_PI/amount*_i+_rot)*radius*cos(map(_i, 0, amount, -range, range)), height/2 + cos(TWO_PI/amount*_i+_rot)*radius*cos(map(_i, 0, amount, -range, range)), smallCircleSize, smallCircleSize);
    break;
  case 1:
    ellipse(width/2 + atan(TWO_PI/amount*_i+_rot)*radius*cos(map(_i, 0, amount, -range, range)), height/2 + atan(TWO_PI/amount*_i+_rot)*radius*sin(map(_i, 0, amount, -range, range)), smallCircleSize, smallCircleSize);
    break;
  case 2:
    ellipse(width/2 + sin(TWO_PI/amount*_i+_rot)*radius*sin(map(_i, 0, amount, -range, range)), height/2 + cos(TWO_PI/amount*_i+_rot)*radius*sin(map(_i, 0, amount, -range, range)), smallCircleSize, smallCircleSize);
    break;
  case 3:
    ellipse(width/2 + sin(TWO_PI/amount*_i+_rot)*radius*cos(map(_i, 0, amount, -range, range)), height/2 + cos(TWO_PI/amount*_i+_rot)*radius*sin(map(_i, 0, amount, -range, range)), smallCircleSize, smallCircleSize);
    break;
  }
}

void keyPressed() {
  if (key == ' ') {
    int temp = a;
    a = b;
    b = temp;
  }
  if (keyCode == UP) amount++;                      
  if (keyCode == DOWN && amount > 0) amount--;
  if (keyCode == LEFT && rate > 0) rate -= 0.01;
  if (keyCode == RIGHT) rate += 0.01;
  if (keyCode == ENTER) symState = ++symState % 4;
  println(symState);
} 

void mousePressed() {
  println(mouseX + " " + mouseY);
}