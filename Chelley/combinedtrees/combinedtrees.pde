

pathfinder[] paths;
Crack[] cracks;
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

PGraphics natTree;
PGraphics mechTree;



void setup() {

  size(800, 600,P2D);
  //pixelDensity(2);
  background(0);
  smooth();
  frameRate(20);

  natTree= createGraphics(width,height);
  mechTree= createGraphics(width,height);
  
//Natural Tree Initialize
  paths = new pathfinder[1];
  paths[0] = new pathfinder();
  
  
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
  
  
  
}





void draw() {


  
  
//Natural Tree//////////////////////////////////////////////////////
  natTree.beginDraw();
  natTree.noStroke();
  natTree.fill(255);

  fill(255);
  noStroke();

  for (int i=0;i<paths.length;i++) {
    PVector loc = paths[i].location;
    float diam = paths[i].diameter;
    natTree.ellipse(loc.x, loc.y, diam, diam);
    paths[i].update();
    
  }
  natTree.endDraw();
  

  
 //Mechanical Tree//////////////////////////////////////////////////////
  mechTree.beginDraw();
  mechTree.fill(100);

  stroke(70);
  fill(150);

    for (int j=0; j<numCracks; j++){
    cracks[j].update();
    if (cracks[j].cChoice == 1){
      if(cracks[j].cLife < 750){
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
    if (cracks[j].cChoice == 5){
      if(cracks[j].cLife < 300){
         cracks[j].fruit();
    }
    }
    cracks[j].cChoice = 0;
  }
  mechTree.endDraw();
  
  //blendMode(SUBTRACT);
  image(natTree,0,0);
  image(mechTree,0,0);
  //natTree.filter(BLUR,2);
  
}




void mousePressed() {
  
  //Draws Mechanical Tree
  background(0);
  paths = new pathfinder[1];
  paths[0] = new pathfinder();
  
  cracks[k].plant();
  k++;
  
  if (k>=numCracks){
    k=0;
  }
  
  
}