//period = number of seconds it takes to move from xmin to xmax, timer is what's keeping track of displacement
float downCosDisplacement(int xmin, int xmax, int timer, int period) {
  float progress = (cos((timer*PI)/period));
  float m = map(progress, -1, 1, xmin, xmax);
  return m;
}

float upCosDisplacement(int xmin, int xmax, int timer, int period) {
  float progress = (-cos((timer*PI)/period));
  float m = map(progress, -1, 1, xmin, xmax);
  return m;
}

void displayCircles(int x, int y, int radius) {
  int transparency = 255;
  color[] colors  = {red, orange, yellow, green, blue, purple};
  for (int i = 0; i< colors.length; i++) {
    fill(colors[i], transparency);
    circle(x+(i*50), y, radius);
  }
}

void keyReleased() {
  if (scene == Scene.CBT_GAME1 || scene == Scene.CBT_GAME2) {
    if (key == BACKSPACE) {
      if (masterLine.length() != 0) {
        masterLine = masterLine.substring(0, masterLine.length() -1);
      }
    } else {
      masterLine = masterLine + key;
    }
    if (masterLine.length()%lineCharLength == 0) {
      masterLine += "\n";
      //masterLine = ""+key;
      //lineIterator++;
    }
  }
}

void displayPanicText(){
  
}
