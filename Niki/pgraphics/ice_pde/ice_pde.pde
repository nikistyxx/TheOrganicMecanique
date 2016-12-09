float[][] z1, v1, z2, v2;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  size(450, 450);
  colorMode(RGB, 2);
  background(1, 1, 2);
  z1 = new float[width][height];
  v1 = new float[width][height];
  z2 = new float[width][height];
  v2 = new float[width][height];
  loadPixels();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
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
  }
  
  updatePixels();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void mouseMoved() {
  v1[mouseX][mouseY] = randomGaussian();
  v2[mouseX][mouseY] = randomGaussian();
}