//GROWTREES by KIERNAN
//Plant near bottom. Trees will grow and produce fruit!
//p to save image
//n to reset, but the trees remember
//k to kill everything

Crack[] cracks;
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


class Crack{
  
  PVector cPos;
  PVector cVel;
  float cSize;
  float cLife;
  float cChoice;
  float cPause;
  float cColor;
  float fColor;
  boolean alive;
  int cID;
  
  Crack(float cXtemp, float cYtemp, int cIDtemp){
    cPos = new PVector(cXtemp, cYtemp);
    cColor = 255;
    fColor = random(1000);
    alive = false;
    cID = cIDtemp;
    cChoice = 0;
  }
    //METHODS GO HERE
  void plant(){
    cPos = new PVector(mouseX,mouseY);
    cVel = new PVector(0,-1);
    cLife = 1000 - deathCount;
    cSize = cLife/25;
    alive = true;
    cChoice = 0;
    cPause = 0;
  }
  void update(){
    if (alive){
      fill(cColor);
      noStroke();
      ellipse(cPos.x, cPos.y, cSize,cSize);
      /*
      cVel.x += (random(-.01,.01));
      cVel.y += (random(-.01,.01));
      */
      cPos.add(cVel);
      cLife -= 1;
      cSize = cLife/25;
      cPause--;
      if (cPause <= 0){
      cChoice = round(random(300));
      }
    }
    if (cLife < 0){
      alive = false;
    }
  }
  void turn(){
    //Switch cVel.x and cVel.y, then possibly
    float t = cVel.x;
    cVel.x = cVel.y;
    cVel.y = t;
    if (round(random(0,1))==1){
      cVel.mult(1);
      cPause = 20;
      cChoice = 0;
      
    }
  }
  void spiral(){
    
  }
  
  void stemSave(){
    stemPosX = cPos.x;
    stemPosY = cPos.y;
    stemVelX = cVel.y;
    stemVelY = cVel.x;
    stemLife = cLife;
    stemColor = cColor;
    stemFruit = fColor;
    cChoice = 0;
    cPause = 20;
  }
  void stem(){
       cPos = new PVector(stemPosX,stemPosY);
    cVel = new PVector(stemVelX,stemVelY);
    if (round(random(0,1))==1){
      cVel.mult(1);
    }
    cColor = stemColor;
    fColor = stemFruit;
    cLife = stemLife*.9;
    cSize = cLife/25;
    alive = true;
    cChoice = 0;
    cPause = 20;
  }
  void fruit(){
    
    for (int f =0; f<random(-2,5);f++){
      float fPosX = cPos.x+random(-30,30);
      float fPosY = cPos.y+random(-30,30);
      /*strokeWeight(cSize);
      stroke(cColor-cLife/5,750-cLife/3,750-cLife/3);
      line(cPos.x,cPos.y,fPosX,+fPosY);*/
      stroke(0);
      
      fill(fColor,800,800);
      ellipse(stemPosX,stemPosY,cSize*4,cSize*4);
    }
    cPause = 20;
  }
}

void setup(){
  size(800,800);
  noStroke();
  colorMode(HSB, 1000);
  background(111,111,811);
  
  //initialize cracks array
  cracks = new Crack[numCracks];
  
  for(int i = 0;i<cracks.length; i++){
    cracks[i] = new Crack(mouseX,mouseY,i);
  }
}

void draw(){
  for (int j=0; j<numCracks; j++){
    cracks[j].update();
    if (cracks[j].cChoice == 1){
      if(cracks[j].cLife < 600){
         cracks[j].turn();
       }
    }
    if (cracks[j].cChoice == 2||cracks[j].cChoice == 3){
      if(cracks[j].cLife < 800){
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

void mousePressed(){
  cracks[k].plant();
  k++;
  if (k>=numCracks){
    k=0;
  }
}