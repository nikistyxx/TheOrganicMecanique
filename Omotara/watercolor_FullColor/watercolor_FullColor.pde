//Framed from:
// Watercolor
// Levente Sandor, 2013
class Brush {
  float angle;
  int components[];
  float x, y;
  color clr;

  Brush() {
    angle = random(TWO_PI);
    x = mouseX;
    y = mouseY;
    //for right now I have it in the center of the screen, but I want to trigger the response using mouse X and Mouse Y
    //I tried but it came out of the corner of the screen
   clr = color(random(450), random(450), random(450), 5);
    //the fourth parameter determines speed, which affects the color
    // I decreased speed from 5 to 4.
    //I changed the color so that it would give off a more oil spill color vibe (with in the blue/red spectrum)
    components = new int[3];
    for (int i = 0; i < 3; i++) {
      components[i] = int(random(1, 5));
      // I changed the int from 2 to 3. I don't know what it did, but I like it.
    }
  }

  void paint() {
    float a = 0;
    float r = 1;
    //I changed float r which changes the radius of th ebutterfly water brush.
    float x1 = x;
    float y1 = y;
    float u = random(0.5, 1);

    fill(clr);
    noStroke();    

    beginShape();
    while (a < TWO_PI) {
      vertex(x1, y1); 
      float v = random(0.65, .85);
      //I changed the parameter range of vecotr v, to change the texture of the spill.
      x1 = x + r * cos(angle + a) * u * v;
      y1 = y + r * sin(angle + a) * u * v;
      a += PI / 180;
      for (int i = 0; i < 2; i++) {
        r += sin(a * components[i]);
      }
    }
    endShape(CLOSE);

    if (x < 0 || x > width ||y < 0 || y > height) {
      angle += HALF_PI;
    }

    x += 2 * cos(angle);
    y += 2 * sin(angle); 
    angle += random(-0.15, 0.15);
  }
}



ArrayList<Brush> brushes; 

void setup() {
  size(1000, 720);
  //I changed the size of the screen, but I don't really know the measurements.
  background(0);
  brushes = new ArrayList<Brush>();
  
}

void draw() {
  for (Brush brush : brushes) {
    brush.paint();
  }
}

void mouseClicked() {
  brushes.add(new Brush());
  brushes.add(new Brush());
  
}