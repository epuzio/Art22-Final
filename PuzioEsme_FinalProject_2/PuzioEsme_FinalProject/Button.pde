class Button {
  int x;
  int y;
  int texty;
  int width;
  int height;
  color bColor;
  String txt;
  float oscillate = -sin(float(frameCount)/13)*5;
  Button(int x, int y, int w, int h, color c, String txt) {
    this.x = x;
    this.y = y;
    texty = y +20;
    width = w;
    height = h;
    bColor = c;
    this.txt = txt;
  }

  void drawButton() {
    noStroke();
    rectMode(CENTER);
    fill(bColor); //rectangle of color behind general button
    rect(x, y, width+20 + oscillate, height+20 - oscillate, 50);
    
    //if the mouse hovers over the button
    if (mouseX >= x-width/2 && mouseX <= x+width/2 &&
      mouseY >= y-height/2 && mouseY <= y+height/2) {
      fill(255, 150);
      rect(x, y, width+20 + oscillate, height+20 - oscillate, 50); //outer rectangle 
      fill(255, 200);
      rect(x, y, width - oscillate, height + oscillate, 40); //inner rectangle
    } else {
      fill(255, 180);
      rect(x, y, width+20 + oscillate, height+20 - oscillate, 50); //outer rectangle
      fill(255);
      rect(x, y, width - oscillate, height + oscillate, 40); //inner rectanlge
    }

    fill(bColor);
    textSize(50);
    textAlign(CENTER);
    text(txt, x, texty);
  }

  boolean clicked() {
    if (mouseX >= x-width/2 && mouseX <= x+width/2 &&
      mouseY >= y-height/2 && mouseY <= y+height/2) {
      if (mousePressed) {
        return true;
      }
    }
    return false;
  }
}
