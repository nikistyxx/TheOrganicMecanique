import java.util.Calendar;


Agent cloud; // The black hole
Agent[] movers; // The thunderbolts
int randHue; // storing random hue values

void setup() {
  size(800, 400);
  smooth();
  colorMode(HSB, 360, 100, 100);
  background(0);
 // cloud = new Cloud(5, 1, 160); // (speed, transparency, radius) of the black hole
  movers = new Agent[50]; // the more Agents, the denser the thunderstorm
  randHue = (int) random(361);
  for (int i = 0; i < movers.length; i++) {
    // thunderbolts (speed, size, hue, transparency)
    // thunderbolts get bigger, more transparent and faster with higher count
    movers[i] = new Agent(1, 10, randHue+i%millis(), 100/(i+1));
  }
}


void draw() {
  //cloud.run(); // display and update the black hole
  for (Agent m : movers) {
    m.run(); // display and update the thunderbolts
  }
}

void mouseClicked() { // restart thunderstorm by click
  background(0); 
  randHue = (int) random(361);
 
  for (int i = 0; i < movers.length; i++) {
    movers[i].erase( randHue+i*int(random(30)) );
  }
}


void keyPressed() { // save a screeny (Java-only)
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
}
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}