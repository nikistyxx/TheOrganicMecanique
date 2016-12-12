class Agent {

  PVector loc, vel;
  PVector prevLoc;
  float step;
  int hue; 
  float thickness, alpha;

  Agent(float _step, float _thickness, int _hue, float _alpha) {
    hue = _hue;
    alpha = _alpha;
    loc = new PVector(width/2, height/2);
    vel = new PVector(2, 1);
    prevLoc = loc.get();
    step = _step;
    thickness = _thickness;
  }

  void run() {
    prevLoc = loc.get();

    // Velocity direction
//    vel = PVector.random2D(); <-- this doesn't work in Processing.js!
    vel.x = random(-1.0,1.0);
    vel.y = random(-1.0,1.0);
    // Velocity magnitude
    vel.mult(step);
    // Add velocity to Location
    loc.add(vel);

    offScreen(); // boundary behaviour

    display();
  }

  void display() { 
   
    stroke(hue, 100, 100, alpha);
    strokeWeight(thickness);
    line(prevLoc.x, prevLoc.y, loc.x, loc.y);
  }

  void offScreen() {
    if (loc.x > width) { 
      loc.x = 0; 
      prevLoc.x = loc.x;
    }
    if (loc.x < 0) { 
      loc.x = width; 
      prevLoc.x = loc.x;
    }
    if (loc.y > height) { 
      loc.y = 0; 
      prevLoc.y = loc.y;
    }
    if (loc.y < 0) { 
      loc.y = height; 
      prevLoc.y = loc.y;
    }
  }

  void erase(int _hue) {  // method to set back location and hue of the bolt
    loc.mult(0); 
    loc.x = mouseX; 
    loc.y = mouseY;
    hue = _hue;
  }
}

class Cloud extends Agent {
  float rad;

  Cloud(float _step, float _alpha, float _rad) {
    super(_step, 0, 0, _alpha);
    rad = _rad;
  }

  void display()  {

    noStroke();
    fill(hue, 0, 0, alpha);
    ellipse(loc.x, loc.y, rad, rad);
  }
}