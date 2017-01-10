import themidibus.*; //Import the library
//import codeanticode.syphon.*;

ArrayList<Brush> brushes; //watercolor brush

Crack[] cracks;//mechanical tree
//SyphonServer server; //syphon
MidiBus myBus; // The MidiBus


int[] channels = new int[4];
//color fillColor[];

//all variables for digitaltree
int numCracks = 100;
int k = 0;
float stemPosX;
float stemPosY;
float stemVelX;
float stemVelY;
float stemLife;
float stemColor;
float stemFruit;
int deathCount = 10;
float diameter;
int timer;

PGraphics mechTree;

//variables for brush
int timerbrush;
int rand;

// variables for brush color
int[] fillColor;
color purple1 = color(random(100,150), random(0,10), random(60,255), 5);
color purple2 = color(random(100,255), random(0,80), random(60,255), 5);
color blue = color(0, random(1, 70), random(20, 120), 4);
color pastel1 = color(random(100, 255), 150, random(100, 200), 4);
color pastel2 = color(random(100, 255), 190, random(100, 200), 4);
color black = color(0, 0, 0, 100);

void settings() {
  //size(9920,720);
  size(800,800,P3D);
  PJOGL.profile=1;
}

void setup() {

  // server = new SyphonServer(this, "Processing Syphon");
  frameRate(30);  
    
  timer = millis();
  
  MidiBus.list();
  myBus = new MidiBus(this, -1, 1 );
  myBus.sendNoteOn(0,0,1);

  //fullScreen();
  pixelDensity(2);
  background(0);
  smooth();

  mechTree= createGraphics(width,height); //mechanical tree


  // initialize color array
  fillColor = new int[5];
  fillColor[0] = purple1;
  fillColor[1] = purple2;
  fillColor[2] = blue;
  fillColor[3] = pastel1;
  fillColor[4] = pastel2;
  
    //timer and random selector for color palletes
  timerbrush = millis();
  rand = (int)random(0,4);
  
  brushes = new ArrayList<Brush>(); //brushes
  
  
//Mechanical Tree Initizalize
  cracks = new Crack[numCracks];
  
  for(int i = 0;i<cracks.length; i++){
    cracks[i] = new Crack(width,height,i);
  }
  
  cracks[k].plant();
  k++;
  
  if (k>=numCracks){
    k=0;
  }
  
  for (int j=0; j<cracks.length; j++){
     if (cracks[j].alive == false){
       //delete object 
     }
  }
  
}
void draw() {
int alpha = 6;

  color erase = color(0);

//WaterColor Brush//////////////////////////////////////////////////////
//Initializes brush characteristics, but does not physically add brushes


 for (Brush brush : brushes) {
   //int colorAdd = 0 ;
   //int colorVal = 0 + colorAdd;
   
     if (millis() - timerbrush <= 50000){
      //int rand = (int)random(0,3);
      brush.paint(fillColor[rand]);
       print("fill color is " + rand);
      }
    else if (millis() - timerbrush <= 75000){
      //for (float i = 2; i < 255; i = i+.01) {
    // color black = color(0, 0, 0, i);
     //brush.paint(black);
//}
      
      
      print(" black ");
      }
    else{
      timerbrush = millis();
      rand = (int)random(0,4);
      //colorVal++;
      print(" brush timer refresh ");
      }    
  }

    //deletes brushes out of the array
    int brushSize = brushes.size();
      print(" brush size ");
    println(brushSize);

    if (brushSize == 30){
       brushes.clear(); 
         print(" clear ");
      }
  
 //Mechanical Tree//////////////////////////////////////////////////////

  fill(100,230,255);

    for (int j=0; j<numCracks; j++){
    cracks[j].update();
    if (cracks[j].cChoice == 1){
      if(cracks[j].cLife < 350){
         cracks[j].turn();
       }
    }
    if (cracks[j].cChoice == 2||cracks[j].cChoice == 3){
      if(cracks[j].cLife < 750){
         cracks[j].stemSave();
         cracks[k].stem();
         k++;
         if (k>=numCracks){
           k=0;
         }
       }
    }
   
    cracks[j].cChoice = 0;
  }

  
  if(frameCount%300==0) {
    addPaint();
  }

  // server.sendScreen();
   if(frameCount%500==0){
    addTree();  
  }

  // server.sendScreen();
}

void addPaint() {
  //midi
  thread("sendNotes");
  
  //Adds new brush into array list
  brushes.add(new Brush());  
}

void addTree() {
  
  //Draws Mechanical Tree
  cracks[k].plant();
  k++;
  
  if (k>=numCracks){
    k=0;
  }
}