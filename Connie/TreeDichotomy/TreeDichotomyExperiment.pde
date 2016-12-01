class pathfinder {
  PVector location;
  PVector velocity;
  float diameter;
  
  pathfinder() {
    location = new PVector(width, height);
    velocity = new PVector(0, -1);
    diameter = 32;
  }
  
  //calculates new diameter for branch(consists of many ellipses)
  pathfinder(pathfinder parent) {
    location = parent.location.get();
    velocity = parent.velocity.get();
    float area = PI*sq(parent.diameter/2);
    float newDiam = sqrt(area/2/PI)*2;
    diameter = newDiam;
    parent.diameter = newDiam;
  }
  
  void update() {
 //change from original minimum diameter to a bigger minimum, so there'll be less thin branches   
    if (diameter>2) {
      location.add(velocity);
      
      //prevents tree from growing outside of screen. It grows diagonally upward when
      //branches are thicker and stops growing if it hits the edge when branches are thin.
      if (location.x > width) {
        if (diameter > 20){
        PVector bump = new PVector(random(-1, 0), random(-1, 0));
        bump.mult(0.1);
        velocity.add(bump);
        velocity.normalize();
        }
        
        else {
          velocity.set(0, 0, 0); 
        }
      }
      
      else {
        PVector bump = new PVector(random(-1, 1), random(-1, 1));
        bump.mult(0.1);
        velocity.add(bump);
        velocity.normalize();
      }
      
     //splits existing branch to create new branches 2% of the time
      if (random(0, 1)<0.02) {
        paths = (pathfinder[]) append(paths, new pathfinder(this));
      }
    }
  }
}

//runner
pathfinder[] paths;
//to fix the size error
void settings(){
  size(800, 600);
}
void setup() {
  
  background(0);
  ellipseMode(CENTER);
  fill(255);
  noStroke();
  smooth();
  paths = new pathfinder[1];
  paths[0] = new pathfinder();
}
void draw() {
  for (int i=0;i<paths.length;i++) {
    PVector loc = paths[i].location;
    float diam = paths[i].diameter;
    ellipse(loc.x, loc.y, diam, diam);
    paths[i].update();
  }
}
void mousePressed() {
  background(0);
  paths = new pathfinder[1];
  paths[0] = new pathfinder();
}