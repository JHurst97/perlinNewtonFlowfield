PVector[][] grid;
Particle[] particles;
int cols, rows;
int spc = 5;
int total = 5000;
PVector gravity;
float inc = 0.1;  
float baseNoise = 0;

void setup() {
  background(51);
  size(800, 800);
  noStroke();
  gravity = new PVector(0, 0.1);
  cols = width/spc;
  rows = height/spc;
  grid = new PVector[cols][rows];

  particles = new Particle[total];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
}

void draw() {
  //fill(0,5);
  //rect(0,0,width,height);
  fill(255, 2);
  println(frameRate);
  float xOff = noise(baseNoise);
  for (int i = 0; i < cols; i++) {
    float yOff = noise(baseNoise);
    for (int j = 0; j < rows; j++) {
      float theta = map(noise(xOff, yOff), 0, 1, 0, TWO_PI );
      grid[i][j] = new PVector(i*spc, j*spc, theta);
      yOff+=inc;
    }
    xOff+=inc;
  }
  //baseNoise+=0.01;

  for (Particle p : particles) {

    p.follow(this);
    p.update();
    p.checkEdges();
    p.show();
  }
}



float lookup(PVector lookup_) {
  int column = int(constrain(lookup_.x/spc, 0, cols-1));
  int row = int(constrain(lookup_.y/spc, 0, rows-1));
  return grid[column][row].z;
}