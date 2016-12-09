class pathfinder {
  PVector location;
  PVector velocity;
  float diameter;
  
  pathfinder() {
    natTree.fill(255);
    location = new PVector(0, height);
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
    
    if (diameter>0.5) {
      location.add(velocity);
      
      //prevents tree from growing outside of screen. It grows diagonally upward when
      //branches are thicker and stops growing if it hits the edge when branches are thin.
      if (location.x < 0) {
        if (diameter > 20){
        PVector bump = new PVector(random(1, 0), random(1, 0));
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
      if (random(0, 1)<0.01) {
        paths = (pathfinder[]) append(paths, new pathfinder(this));
      }
    }
  }
}