import themidibus.*; //Import the library
//import codeanticode.syphon.*;

ArrayList<Brush> brushes; //watercolor brush

Crack[] cracks;//mechanical tree
//SyphonServer server; //syphon
MidiBus myBus; // The MidiBus


int[] channels = new int[4];
color fillColor[];


int brushAmt = 45;




//all variables for digitaltree
int numCracks = 50;
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
int colorVal=0;
PGraphics mechTree;
float brushX = random(width);
float brushY = random(height);


void settings() {
  //size(9920,720,P3D);
  size(800,800,P3D);
  PJOGL.profile=1;
}



void setup() {

   fillColor = new int[10];
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

  brushes = new ArrayList<Brush>(); //brushes
  mechTree= createGraphics(width,height); //mechanical tree


  
  
//Mechanical Tree Initizalize
  cracks = new Crack[numCracks];
  
  for(int i = 0;i<cracks.length; i++){
    cracks[i] = new Crack(width,height,i);
  }
  
  cracks[k].plant();
  k++;
  
    cracks[k].plant_top();
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
      
      brush.paint(colorVal);
      for (int i = 0; i < brushes.size(); i++){
        float brushXVal = brushes.get(i).x; 
        int speakerNumber = (int)map(brushXVal, 0,9920, 0, 127);
          //midi
        thread("sendNotes");
        
      }
      
      //println(brush.x); 
  }


    //float xValofBrush= brushes.x; 
    //deletes brushes out of the array
    int brushSize = brushes.size();
    //println(brushSize);

    if (brushSize == brushAmt){
       brushes.clear(); 
       colorVal++;
       
       println(colorVal);
      }
      if (colorVal == 11){
       colorVal = 0; 
      }

  
  


  
 //Mechanical Tree//////////////////////////////////////////////////////

  fill(100,230,255,160);

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

  

  
  if(frameCount%50==0) {
    addPaint();
  }
   if(frameCount%500==0){
    addTree();  
  }

  // server.sendScreen();
  
}




void addPaint() {
  

  
  //Adds new brush into array list
  brushes.add(new Brush());
 
 
  
  
  
}

void addTree() {
  
  //Draws Mechanical Tree
  cracks[k].plant();
  k++;
  
  //Draws Mechanical Tree on top
  cracks[k].plant_top();
  k++;
  
  if (k>=numCracks){
    k=0;
  }
}