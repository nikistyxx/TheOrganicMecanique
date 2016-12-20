// Watercolor
// Levente Sandor, 2013

ArrayList<Brush> brushes; 

void setup() {
  size(500, 500);
  background(0);
  brushes = new ArrayList<Brush>();
  for (int i = 0; i < 50; i++) {
    brushes.add(new Brush());
  }
}

void draw() {
  for (Brush brush : brushes) {
    brush.paint();
  }
}

void mouseClicked() {
  brushes.add(new Brush());
}