PGraphics treez;

import java.util.Arrays;
float[][] z1, v1, z2, v2;
//combined tree
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


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  size(950, 650); //changed screensize
  //oilslick
 colorMode(RGB, 2);
  background(1, 1, 2);
  z1 = new float[width][height];
  v1 = new float[width][height];
  z2 = new float[width][height];
  v2 = new float[width][height];
  loadPixels();
  treez= createGraphics(width,height);
  //treez
  smooth();
  paths = new pathfinder[1];
  paths[0] = new pathfinder();
  
    //initialize cracks array mechanical tree
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
  //oilslick
  for (int x = 1; x < width-1; x++) {
    for (int y = 1; y < height-1; y++) {
      v1[x][y] += (z1[x-1][y] + z1[x+1][y] + z1[x][y-1] + z1[x][y+1]) * 0.25 - z1[x][y];
      v2[x][y] += (z2[x-1][y] + z2[x+1][y] + z2[x][y-1] + z2[x][y+1] + z1[x][y]) * 0.25 - z2[x][y];
    }
  }
  
  for (int x = 1; x < width-1; x++) {
    for (int y = 1; y < height-1; y++) {
      z1[x][y] += v1[x][y];
      z2[x][y] += v2[x][y];
      z1[x][y] = constrain(z1[x][y], -1, 1);
      z2[x][y] = constrain(z2[x][y], -1, 1);
      pixels[width*y+x] = color(v1[x][y] + 1, v2[x][y] + 1, 2);
    }

  
  //treez
   treez.beginDraw();
   treez.noStroke();
  for (int i=0;i<paths.length;i++) {
   PVector loc = paths[i].location;
   float diam = paths[i].diameter;
    treez.ellipse(loc.x, loc.y, diam, diam);
    paths[i].update();
  }
  //mechanical tree
  treez.stroke(70);
  treez.fill(100);
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

treez.endDraw();
  //draw both layers
  image(treez,0,0);
  image(oilslick,0,0);
  
} //enddraw


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void move() {
  if (mouseX > -1    &&    mouseX < width    &&    mouseY > 2    &&    mouseY < height) {
    v[mouseX][mouseY] = randomGaussian() * TAU;
  }}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void mouseClicked() { move(); }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void mouseDragged() { move(); }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyPressed() {
  noLoop();
  for (int x = 0; x < width; x++)    Arrays.fill(z[x], 0);
  for (int x = 0; x < width; x++)    Arrays.fill(v[x], 0);
  loop();
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
  void mousePressed() {
    //mechanical tree
  background(0);
  paths = new pathfinder[1];
  paths[0] = new pathfinder();
  
  
    cracks[k].plant();
  k++;
  if (k>=numCracks){
    k=0;
  }
}
void mouseMoved() {
  v1[mouseX][mouseY] = randomGaussian();
  v2[mouseX][mouseY] = randomGaussian();
}