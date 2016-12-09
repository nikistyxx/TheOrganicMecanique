PGraphics oilslick;
PGraphics treez;

import java.util.Arrays;
float[][] z, v, a;
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
  colorMode(RGB, 3); //changed brightness
  oilslick = createGraphics(width, height);
  treez = createGraphics(width, height);
  
  //oilslick
  z = new float[width][height];
  v = new float[width][height];
  a = new float[width][height];
  loadPixels();
  background(0);
  
  //treez
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
  //oilslick
  for (int x = 1; x < width-1; x++) {
    for (int y = 1; y < height-1; y++) {
      a[x][y] = (v[x-1][y] + v[x+(-1)][y] + v[x+1][y-1] + v[x][y-1])/4 - v[x][y];
    } //changed x and y values, affects angle of color bleed
  }
  for (int x = 1; x < width-1; x++) {
    for (int y = 1; y < height-1; y++) {
      v[x][y] += a[x][y];
      z[x][y] += v[x][y];
      pixels[width*y+x] = color(sin(z[x][y]) + 1, cos(z[x][y]), 2);
    }
  }
  oilslick.beginDraw();
  oilslick.updatePixels();
  oilslick.endDraw();
  
  //treez
   treez.beginDraw();
   treez.noStroke();
  for (int i=0;i<paths.length;i++) {
   PVector loc = paths[i].location;
    treez.float diam = paths[i].diameter;
    treez.ellipse(loc.x, loc.y, diam, diam);
    treez.paths[i].update();
  }
  
  treez.stroke(70);
  treez.fill(150);

}

void cracksfunction(){
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
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
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