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
  int time;
  
  Crack(float cXtemp, float cYtemp, int cIDtemp){
    cPos = new PVector(width, height);
    cColor = color(100,230,255);
    fColor = random(1000);
    alive = false;
    cID = cIDtemp;
    cChoice = 0;
  }
  
  //METHODS GO HERE
  //creates plant
  void plant(){
<<<<<<< HEAD
    cPos = new PVector(300,height);//this is the initial plant position
=======
    cPos = new PVector(random(width),height);//this is the initial plant position
>>>>>>> origin/master
    cVel = new PVector(0,-1); 
    cLife = 500 - deathCount;
    cSize = cLife/45;
    alive = true;
    cChoice = 0;
    cPause = 0;
    time = millis();
  }
  
  void update(){
    if (alive){

      fill(0);
      ellipse(cPos.x, cPos.y, cSize/4,cSize/4);

      
      //cVel.x += (random(-.01,.01));
      //cVel.y += (random(-.01,.01));
      
      cPos.add(cVel);
      cLife -= .02;
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
    cVel = new PVector(-1*stemVelX,stemVelY);//stemVelX changes the direction of the crack
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

}