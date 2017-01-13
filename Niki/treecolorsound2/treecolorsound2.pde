  // Last edit Wed Jan 11 - 1:30pm

import themidibus.*;
import codeanticode.syphon.*;

SyphonServer server; //syphon

ArrayList<Brush> brushes; //watercolor brush
Crack[] cracks;//mechanical tree
MidiBus myBus; // The MidiBus

int[] channels = new int[4];
color fillColor[];
int brushAmt = 70;//moved from 80 to 70 for memory reasons/////////////////////

///////////all variables for digitaltree/////////////////////////////////////////
int numCracks = 70;
int k = 0;
float stemPosX, stemPosY, stemVelX, stemVelY, stemLife, stemColor, stemFruit, diameter;
int deathCount = 50;
int timer, speakerNumber;
int colorVal = 0;
//PGraphics mechTree;
float brushX, brushY;
boolean a = false; 


void settings() {
  size(9920, 720, P3D);
  //size(800, 800);
  //fullScreen();
  PJOGL.profile=1;
}

void setup() {
  frameRate(30); 
  server = new SyphonServer(this, "Processing Syphon");
  fillColor = new int[10];
  timer = millis();
  MidiBus.list();
  myBus = new MidiBus(this, -1, 1 );
  pixelDensity(2);
  background(0);
  smooth();

  brushes = new ArrayList<Brush>(); //brushes
  //mechTree= createGraphics(width, height); //mechanical tree
  cracks = new Crack[numCracks];  //Mechanical Tree Initizalize
  
  ///////////WHY IS THER A FOR LOOP IN SETUP SHOULD IT BE IN DRAW?//////////////////////////////
 for (int i = 0; i<cracks.length; i++) {
 cracks[i] = new Crack(width, height, i);}
    
/////////////TREE STUFF THAT WAS MOVED TO A FUNCTION (THIS WAS THAT RANDO TREE GROWING)//////////////////////
 // cracks[k].plant();
  //k++;
  //if (k>=numCracks) k=0;

//////////////BRUSH PLACEMENT//////////////////////////////////////////
  brushX = random(width);
  brushY = random(height);
}

void draw() { 
  //WaterColor Brush//////////////////////////////////////////////////////
  //Initializes brush characteristics, but does not physically add brushes
  for (Brush brush : brushes) {
    brush.paint(colorVal);
    for (int i = 0; i < brushes.size(); i++) {
      float brushXVal = brushes.get(i).x; 
      //speakerNumber = (int)map(brushXVal, 0, width, 127, 0);
    }
  }
   //float xValofBrush= brushes.x; 
  
  //////deletes brushes out of the array//////////////////////////////////////
  int brushSize = brushes.size();
   println("size" + brushSize);
    println("amt" + brushAmt);
  if (brushSize == brushAmt) {
    brushes.clear(); 
    colorVal++;
    println(colorVal);
    println("size" + brushSize);
    println("amt" + brushAmt);
  }
  if (colorVal == 10) colorVal = 0;
  
////////////Drawing the tree boolean////////////////////////////////////////////
if (a == true) { 
drawthelines();} 
println (a);

/////////////Draws tree and paint via framecount/////////////////////////////////////
  if (frameCount%100==0) {addPaint();}
  if (frameCount%50==0) {addTree();
      a = true; } // actvates the drawthelines function
  //if (keyPressed) sendNotes();
  
/////SYPHON//////////////////////////////////////////////////////////
  server.sendScreen();
  
} //////////  draw function closer   //////////////////////////////


///////    ADDING PAINT and SENDING MIDI   //////////////////////////////////
void addPaint() {
brushes.add(new Brush());   //Adds new br ush into array list
  //music sends
  thread("sendNotes");
 thread("sendNotes2");
   thread("sendNotes3");
}

/////////////////   Draws Mechanical Tree   //////////////////////////////
void addTree() {
  cracks[k].plant(); 
  k++;
  if (k>=numCracks) k=0;
}

////////////I HAVE NO IDEA!?! I WISH EMOJIS WERE IN CODE//////////////
void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

/////////////////// Drawing the BRANCHES /////////////////////////////////////////////////
void drawthelines(){
  fill(100, 230, 255, 160);
  //I moved this here because it was drawing when the addTree was commented out.
    for (int j=0; j<numCracks; j++) {
    cracks[j].update();
    if (cracks[j].cChoice == 1) {
      if (cracks[j].cLife < 350) {
        cracks[j].turn();
      }
    }

    if (cracks[j].cChoice == 2||cracks[j].cChoice == 3) {
      if (cracks[j].cLife < 750) {
        cracks[j].stemSave();
        cracks[k].stem();
        k++;
        if (k>=numCracks) k=0;
      }
    }
    cracks[j].cChoice = 0;
  }
  //^I moved this here because it was drawing when the addTree was commented out. ^
}

/////////////////   ALL the sound stuff////////////////////////////////////////////////////////
void sendNotes() {  
  //int[] channel = new int[4];
  int channel = (int)random(0, 4);
  int pitch = 64+int(random(0, 10));
  int velocity = 127;
  //int controllerNumber = 0;
  int speakerNumber = (int)random(0,127);
  int rando = (int)random(20,50);

  myBus.sendControllerChange(1, 1, speakerNumber); // Send a controllerChange
  delay(rando);    
  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  delay(rando);
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
}
void sendNotes2() {  
  int channel =2;
  //int channel = (int)random(0, 4);
  int pitch = 64+int(random(0, 10));
  int velocity = 127;
  //int controllerNumber = 0;
  int speakerNumber = (int)random(0,127);
  int rando = (int)random(20,50);

  myBus.sendControllerChange(2, 2, speakerNumber); // Send a controllerChange
  delay(rando);    
  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
 delay(rando);   
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
}
void sendNotes3() {  
  int channel =3;
  //int channel = (int)random(0, 4);
  int pitch = 64+int(random(0, 10));
  int velocity = 127;
  //int controllerNumber = 0;
  int speakerNumber = (int)random(0,127);
  int rando = (int)random(20,50);

  myBus.sendControllerChange(3, 3, speakerNumber); // Send a controllerChange
  delay(rando);    
  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  delay(20);
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
}