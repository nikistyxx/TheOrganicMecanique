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
int deathCount = 0;
float diameter;



void setup() {
  size(800, 600);
  background(0);
  smooth();
  paths = new pathfinder[1];
  paths[0] = new pathfinder();
  
  
    //initialize cracks array
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
  fill(255);
  noStroke();
  for (int i=0;i<paths.length;i++) {
    PVector loc = paths[i].location;
    float diam = paths[i].diameter;
    ellipse(loc.x, loc.y, diam, diam);
    paths[i].update();
  }
  
  stroke(50);
  fill(100);
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
  
  
}




void mousePressed() {
  background(0);
  paths = new pathfinder[1];
  paths[0] = new pathfinder();
  
  
    cracks[k].plant();
  k++;
  if (k>=numCracks){
    k=0;
  }
  
  
}