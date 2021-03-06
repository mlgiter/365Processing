// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Particle {
  PVector loc, vel, acc;
  float lifespan, radius, c;

  Particle(PVector l, float c_) {
    loc = l.get();
    vel = new PVector(random(-1, 1), random(-2, -2));
    acc = new PVector(0,0.1);
    lifespan = 255;
    c = c_;
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void run() {
    update();
    display();
  }

  void update() {
    loc.add(vel);
    vel.add(acc);
    acc.mult(0);
    lifespan -= 2;
    radius = 1;
  }

  void display() {
    noStroke();
    fill(0, lifespan);
    ellipse(loc.x, loc.y, radius, radius);
  }
  
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

