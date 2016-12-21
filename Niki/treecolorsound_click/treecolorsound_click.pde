import themidibus.*; //Import the library
import codeanticode.syphon.*;

ArrayList<Brush> brushes; //watercolor brush
pathfinder[] paths; //natural tree
Crack[] cracks;//mechanical tree
SyphonServer server; //syphon
MidiBus myBus; // The MidiBus

int[] channels = new int[4];

//all variables for digitaltree
int numCracks = 100;
int deathCount = 10;
int k = 0;
float stemPosX, stemPosY, stemVelX, stemVelY, stemLife, stemColor, stemFruit, diameter;
PGraphics natTree, mechTree; 

void settings() {
  size(800, 800);
  //PJOGL.profile=1;
}

void setup() {
  //server = new SyphonServer(this, "Processing Syphon");
  //frameRate(30);  

  MidiBus.list();
  myBus = new MidiBus(this, -1, 1 );

  pixelDensity(2);
  background(0);
  smooth();

  brushes = new ArrayList<Brush>(); //brushes
  natTree= createGraphics(width, height); //natural tree
  mechTree= createGraphics(width, height); //mechanical tree

  //Natural Tree Initialize
  paths = new pathfinder[1];
  paths[0] = new pathfinder();

  //Mechanical Tree Initizalize
  cracks = new Crack[numCracks];

  for (int i=0; i<cracks.length; i++) {
    cracks[i] = new Crack(width, height, i);
  }

  cracks[k].plant();
  k++;
  if (k>=numCracks)k=0;
}

void draw() {
  //MIDI//////////////////////////////////////////////////////
  if (keyPressed) thread("sendNotes");

  //WaterColor Brush//////////////////////////////////////////////////////
  //Initializes brush characteristics, but does not physically add brushes
  for (Brush brush : brushes) brush.paint();

  //Natural Tree//////////////////////////////////////////////////////
  natTree.beginDraw();
  natTree.noStroke();
  natTree.fill(255, 10);

  fill(255, 10);
  noStroke();

  for (int i=0; i<paths.length; i++) {
    PVector loc = paths[i].location;
    float diam = paths[i].diameter;
    natTree.ellipse(loc.x, loc.y, diam, diam);
    paths[i].update();
  }
  natTree.endDraw();

  //Mechanical Tree//////////////////////////////////////////////////////
  mechTree.beginDraw();
  mechTree.fill(100, 10);

  //stroke(70);
  noStroke();
  fill(150, 10);

  for (int j=0; j<numCracks; j++) {
    cracks[j].update();
    if (cracks[j].cChoice == 1) {
      if (cracks[j].cLife < 750) {
        cracks[j].turn();
      }
    }
    if (cracks[j].cChoice == 2||cracks[j].cChoice == 3) {
      if (cracks[j].cLife < 750) {
        cracks[j].stemSave();
        cracks[k].stem();
        k++;
        if (k>=numCracks) {
          k=0;
        }
      }
    }
    if (cracks[j].cChoice == 5) {
      if (cracks[j].cLife < 300) {
        //cracks[j].fruit();
      }
    }
    cracks[j].cChoice = 0;
  }
  mechTree.endDraw();
  image(natTree, 0, 0);
  image(mechTree, 0, 0);
  //server.sendScreen();
  
  if(frameCount%500==0) {
    addPaint();
  }
}

void addPaint() {
  brushes.add(new Brush());  //Adds new brush into array list
  cracks[k].plant();  //Draws Mechanical Tree
  k++;
  if (k>=numCracks)k=0;
}