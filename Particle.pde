class Particle {
  PVector loc, vel, acc;
  float maxSpeed, mass;

  Particle() {
    loc = new PVector(random(width), random(height));
    vel = new PVector(5, -10);
    acc = new PVector(0, 0);
    maxSpeed = 5;
    mass = 2;
  }

  void applyForce(PVector force_) {
    acc.add(force_);
  }
  
  void follow(perlinNewtonFlowfield ff){
    PVector desired = new PVector(cos(ff.lookup(loc)), sin(ff.lookup(loc)));
    desired.mult(maxSpeed);
    
    PVector steer = PVector.sub(desired,vel);
    steer.limit(maxSpeed);
    applyForce(steer);
  }

  void update() {
    vel.limit(maxSpeed);
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
  }

  void show() {

    ellipse(loc.x, loc.y, mass, mass);
  }
  
  void checkEdges(){
    if(loc.x > width || loc.x < 0 || loc.y > height || loc.y < 0){
      loc = new PVector(random(width), random(height));
    }
  
  }
}