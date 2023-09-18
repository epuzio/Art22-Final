class Wave {
  //code referenced from Daniel Shiffman's article Noise Wave: https://processing.org/examples/noisewave.html
  float yJitter = 0.0;
  float xJitter = 0.0;
  int leftx;
  int rightx;
  color c;
  float theta = 0.0;

  Wave(int x, int x2, int h, int d , color c) {
    leftx = x;
    rightx = x2;
    this.c = c;
  }

  void drawWave(int waveHeight){
    fill(c, 70);
    noStroke();
    beginShape();
    
    theta += 0.02;
    xJitter = 0.0;
    
    for (float i = leftx; i <= rightx; i += 10) {
      float y = map(noise(xJitter, yJitter), 0, 1, waveHeight, waveHeight+100);
      vertex(i, y);
      xJitter += 0.05;
    }
    yJitter += 0.01;
    vertex(rightx, height);
    vertex(leftx, height);
    endShape(CLOSE);
  }
}
