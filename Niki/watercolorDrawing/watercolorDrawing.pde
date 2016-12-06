// Watercolor Drawing Tool by Niki Selken
//Special Thanks to Levente Sandor, for Watercolor brush

ArrayList<Brush> brushes; 

void setup() {
  size(500, 500);
  background(0,0,0);
  brushes = new ArrayList<Brush>();
  for (int i = 0; i < 1; i++) {
    brushes.add(new Brush());
  }
}
void setupClick() {
 
  brushes = new ArrayList<Brush>();
  for (int i = 0; i < 1; i++) {
    brushes.add(new Brush());
  }
}

void draw() {
  for (Brush brush : brushes) {
    brush.paint();
  }
}

void mouseClicked() {
  setupClick();
}

class Brush {
  float angle;
  int components[];
  float x, y;
  color clr;

  Brush() {
    angle = random(TWO_PI);
    x = mouseX;
    y = mouseY;
    clr = color(random(255), random(255), random(255), 6);
    components = new int[2];
    for (int i = 0; i < 1; i++) {
      components[i] = int(random(1, 5));
    }
  }

  void paint() {
    float a = 0;
    float r = 0;
    float x1 = mouseX;
    float y1 = mouseY;
    float u = random(0.5, 1);

    fill(clr);
    noStroke();    

    beginShape();
    while (a < TWO_PI) {
      vertex(x1, y1); 
      float v = random(0.85, 1);
      x1 = mouseX + r * cos(angle + a) * u * v;
      y1 = mouseY + r * sin(angle + a) * u * v;
      a += PI / 180;
      for (int i = 0; i < 1; i++) {
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