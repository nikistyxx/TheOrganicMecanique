class Brush {
  float angle;
  int components[];
  float x, y;
  color clr;
  int compVal = 2;
  color clr2;
  color black;
  int timer;
  int num = 0;

  Brush() {
    timer = millis();
    angle = random(TWO_PI);
    x = random(width);
    y = random(height);
    //clr = color(random(100,255), random(0,30), random(60,255), 5);
    clr = color(random(100,120), random(0,10), random(60,255), 5);
    black = color(0,120);
    components = new int[compVal];
    for (int i = 0; i < compVal; i++) {
      components[i] = compVal;
    }
  }

  void paint() {
    float a = 0;
    float r = 0;
    float x1 = x;
    float y1 = y;
    float u = random(0.5, 1);
    
    if (millis() - timer >= 30000){
      num = 1;
    }
    
    switch(num){
      case 0:
        fill(clr);
        println("color");
        break;
      case 1:
        println("black");
        fill(black);
        break;
    }
    
    noStroke();    

    beginShape();
    while (a < TWO_PI) {
      vertex(x1, y1); 
      float v = random(0.85, 1);
      x1 = x + r * cos(angle + a) * u * v;
      y1 = y + r * sin(angle + a) * u * v;
      a += PI / 180;
      for (int i = 0; i < compVal; i++) {
        r += sin(a * components[i]);
      }
    }
    endShape(CLOSE);
  pushMatrix();
   fill(clr2);
    noStroke();  
    scale(.4);
    beginShape();
    while (a < TWO_PI) {
      vertex(x1+20, y1+30); 
      float v = random(0.85, .8);
      x1 = x + r * cos(angle + a) * u*.3 * v;
      y1 = y + r * sin(angle - a) * u * .3*v;
      a += PI / 180;
      for (int i = 0; i < compVal; i++) {
        r += sin(a * components[i]);
      }
    }
    endShape(CLOSE); 
    popMatrix();
    if (x < 0 || x > width ||y < 0 || y > height) {
      angle += HALF_PI;
    }

    x += 2 * cos(angle);
    y += 2 * sin(angle); 
    angle += random(-0.45, 0.45);
  }
}