// Watercolor
// Levente Sandor, 2013

ArrayList<Brush> brushes; 

void setup() {
  size(500, 500);
  background(0);
  brushes = new ArrayList<Brush>();

}

void draw() {
  for (Brush brush : brushes) {
    brush.paint();
  }
}


void mousePressed() {
 
    brushes.add(new Brush());
  
  
}

void keyPressed() {
 
    setup();
  
  
}