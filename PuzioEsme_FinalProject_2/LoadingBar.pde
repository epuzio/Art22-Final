class LoadingBar {
  int x, y, w, h;
  int progress = 0;
  color c;
  float m;
  LoadingBar(int x, int y, int w, int h, color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
  }

  void drawBar(int progress, int round) {
    float editedProgress = (-cos((progress*PI)/round));
    float m = map(editedProgress, -1, 1, 0, h);
    fill(0);
    noStroke();
    rectMode(CORNER);
    rect(x, y, w, h, 100);
    fill(c, 150);
    rect(x, y, w, h, 100);
    fill(c, 255);
    rect(x, y+h-m, w, m, 100);
    ellipseMode(CENTER);
    fill(255);
    ellipse(x+(w/2), y+h-m, w, w);
  }

  void drawBarX(int progress, int round) {
    float editedProgress = (-cos((progress*PI)/round));
    float m = map(editedProgress, -1, 1, 0, h);
    fill(0);
    noStroke();
    rectMode(CORNER);
    rect(x, y, w, h, 100);
    fill(c, 150);
    rect(x, y, w, h, 100);
    fill(c, 255);
    rect(x+h-m, y, w, m, 100);
    ellipseMode(CENTER);
    fill(255);
    ellipse(x+h-m, y+(w/2), w, w);
  }
}
