import themidibus.*; //Import the library
//import codeanticode.syphon.*;

ArrayList<Brush> brushes; //watercolor brush

Crack[] cracks;//mechanical tree
//SyphonServer server; //syphon
MidiBus myBus; // The MidiBus


int[] channels = new int[4];



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

PGraphics mechTree;


void settings() {
  //size(9920,720);
  size(800,800,P3D);
  PJOGL.profile=1;
}



void setup() {

  // server = new SyphonServer(this, "Processing Syphon");
  frameRate(30);  
  
  MidiBus.list();
  myBus = new MidiBus(this, -1, 1 );

  //fullScreen();
  pixelDensity(2);
  background(0);
  smooth();

  brushes = new ArrayList<Brush>(); //brushes
  mechTree= createGraphics(width,height); //mechanical tree


  
  
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

  
//WaterColor Brush//////////////////////////////////////////////////////
//Initializes brush characteristics, but does not physically add brushes
 for (Brush brush : brushes) {
    brush.paint();
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

  

  
  if(frameCount%500==0) {
    addPaint();
  }

  // server.sendScreen();
  
}




void addPaint() {
  
  //midi
  thread("sendNotes");
  
  //Adds new brush into array list
  brushes.add(new Brush());
  
  //Draws Mechanical Tree
  cracks[k].plant();
  k++;
  
  if (k>=numCracks){
    k=0;
  }
  
  
}