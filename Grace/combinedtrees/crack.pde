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
    cPos = new PVector(width, height);
    cColor = 100;
    fColor = random(1000);
    alive = false;
    cID = cIDtemp;
    cChoice = 0;
  }
    //METHODS GO HERE
  //creates new branch
  void plant(){
    cPos = new PVector(width,height);
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
      cChoice = round(random(200));
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