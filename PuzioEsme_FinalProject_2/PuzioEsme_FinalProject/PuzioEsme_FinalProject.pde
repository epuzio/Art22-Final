/*
 * Course: ART 22  - Computer Programming for the Arts
 * Assignment: Finial Project
 * by Esmé Puzio
 * Initiated: 11/20/21
 * Last updated: 12/3/21
 */

import processing.sound.*;
SoundFile audio;
SoundFile panicAudio;

int textsize = 20;

//hardcoded color variables
color waveColor = #143B5D;
color breathingColor = #F54AC2;
color menuTextColor = #14175D;
color red = #F05B4D;
color orange = #F0A14D;
color yellow = #F0EA77;
color green = #76F267;
color blue = #2BBFEA;
color purple = #B672F0;
color[] colors  = {red, orange, yellow, green, blue, purple};

//main screen variables
float handShakeSpeed;
float hand1X = 0;
float hand2X = 0;
int waveHeight = 500;
int waveSize = 100;
//main screen pimages
PImage startBkg;
PImage startMirror;
PImage startReflectedLHand;
PImage startReflectedRHand;
PImage startRHand;
PImage startLHand;
int mirrorWavesHeight;

//breathing minigame variables/pimages
PImage breatheTXT;
PImage breatheLHand;
PImage breatheRHand;
PImage breatheIn;
PImage breatheOut;
int breatheHandDisplacement = 0;
int rounds = 0;
LoadingBar breatheBar = new LoadingBar(50, height-50, 25, 100, blue);
LoadingBar test2 = new LoadingBar(500, 200, 30, 500, #F5C54A);

//progressive muscle relaxation variables/pimages
PImage pmrTXT;
PImage tenseTxt;
PImage releaseTxt;
PImage[] pmrImages = new PImage[6];
String[] tensionBlurb = {"Focus on your forehead. Tense your forehead as tightly as possible.",
  "Focus on your jaw. Tense your jaw as tightly as possible.",
  "Focus on your shoulders. Tense your shoulders as tight as possible by raising them towards your ears.",
  "Focus on your hands. Tense your fists as tight as possible by making two tight fists and pulling them close to your chest.",
  "Focus on your calves. Tense your calves as tight as possible by raising your toes.",
  "Focus on your feet. Tense your feet as tight as posisble by curling in your toes."
};

String[] relaxBlurb = {"Exhale and quickly release the tension in your forehead. Reflect on the difference between your tensed and relaxed forehead.",
  "Exhale and quickly release the tension in your jaw. Reflect on the difference between your tensed and relaxed jaw.",
  "Exhale and quickly release the tension in your shoulders. Reflect on the difference between your tensed and relaxed shoulders.",
  "Exhale and quickly release the tension in your fists. Reflect on the difference between your tensed and relaxed fists.",
  "Exhale and quickly release the tension in your calves. Reflect on the difference between your tensed and relaxed calves.",
  "Exhale and quickly release the tension in your feet. Reflect on the difference between your tensed and relaxed feet."
};

//cbt variables/pimages for screen one
PImage cbtTXT;
int cbtw = 300;
int cbth = 300;
String masterLine = "";
int lineCharLength = 30;
String[] lines = {"", "", "", "", "", "", ""};
int lineIterator = 0;
PImage cbtSpeechBubble;
PImage cbtText;

//cbt variables/pimages for screen two
PImage cbt2txt1;
PImage cbt2txt2;
PImage cbt2txt3;
PImage cbt2txt4;
boolean drawSecondQuestion = false;
boolean drawThirdQuestion = false;
boolean drawFourthQuestion = false;
int lineCharLength2 = 60;
String cbt2Line1 = "";
String cbt2Line2 = "";
String cbt2Line3 = "";
String cbt2Line4 = "";
int lineIterator2 = 0;
int txtDrawing = 1;
int cbtWaterHeight = 30;

//ending screen pimage
PImage endingTxt;

//panic string
String[] panicStringArr = {"Something's wrong.", "I can't breathe.", "I'm choking",
  "Am I dying?", "I'm scared.", "I can't stop shaking.", "I'm going to vomit.", "I can't handle this.", "I'm dizzy.", "I'm so tired.",
  "What's wrong with me?", "I messed up."};

//waves for instruction screens
Wave wave =  new Wave(-400, 1360, waveHeight, waveHeight + waveSize, waveColor);
Wave wave2 = new Wave(-200, 1360, waveHeight + 60, waveHeight +waveSize + 60, waveColor);
Wave wave3 = new Wave(0, 1360, waveHeight + 90, waveHeight + waveSize + 90, waveColor);

//main screen waves
Wave waveMenu =  new Wave(-400, 1360, mirrorWavesHeight, mirrorWavesHeight + 40, waveColor);
Wave waveMenu2 = new Wave(-200, 1360, mirrorWavesHeight + 20, mirrorWavesHeight + 60, waveColor);
Wave waveMenu3 = new Wave(0, 1360, mirrorWavesHeight + 40, mirrorWavesHeight + 80, waveColor);

//scene enum
enum Scene {
  START_MENU, START_SCREEN, PMR_MENU, BREATHE_MENU, CBT_MENU, PANIC, PMR_GAME, BREATHE_GAME, CBT_GAME1, CBT_GAME2, ENDING
}

//scene switch case
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Scene scene = Scene.START_MENU;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//control variables
int timer = 0;
int fps = 24;
int exercisesComplete = 0;
int inhale = 4;
int exhale = 8;

void setup() {
  size(1360, 765);
  frameRate(fps);

  //loading in sound file
  audio = new SoundFile(this, "waveAudio.wav");
  panicAudio = new SoundFile(this, "panicTrigger.wav");
  audio.loop();

  //loading in images + font
  PFont font;

  //images for start screen
  font = createFont("MicrosoftSansSerif", 128);
  textFont(font, 128);
  startBkg = loadImage("Bathroom.png");
  startMirror = loadImage("BathroomBKGLayer.png");
  startReflectedLHand = loadImage("Lhandmirror.png");
  startReflectedRHand = loadImage("Rhandmirror.png");
  startRHand = loadImage("Rhand.png");
  startLHand = loadImage("Lhand.png");

  //images for breathing minigame
  breatheTXT = loadImage("DeepBreathingTxt.png");
  breatheLHand = loadImage("LhandFlip.png");
  breatheRHand = loadImage("Rhandflip.png");
  breatheIn = loadImage("BreatheIn.png");
  breatheOut = loadImage("BreatheOut.png");

  //images for progressive muscle relaxation minigame
  pmrTXT = loadImage("PmrTXT.png");
  tenseTxt = loadImage("Tense.png");
  releaseTxt = loadImage("Release.png");
  pmrImages[0] = loadImage("BrowTension.png");
  pmrImages[1] = loadImage("NeckTension.png");
  pmrImages[2] = loadImage("ShoulderTension.png");
  pmrImages[3] = loadImage("HandTension.png");
  pmrImages[4] = loadImage("LegTension.png");
  pmrImages[5] = loadImage("FeetTension.png");

  //images for cognitive behavioral therapy minigame
  cbtTXT = loadImage("CBTtxt.png");
  cbtSpeechBubble = loadImage("Speech_bubble.png");
  cbtText = loadImage("CBTText.png");
  cbt2txt1 = loadImage("Slide2Q1.png");
  cbt2txt2 = loadImage("Slide2Q2.png");
  cbt2txt3 = loadImage("Slide2Q3.png");
  cbt2txt4 = loadImage("Slide2Q4.png");

  //images for ending screen
  endingTxt = loadImage("End-screen.png");
}

void draw() {
  background(0);
  switch(scene) {
  case START_MENU:
    background(blue);
    wave.drawWave(waveHeight);
    wave2.drawWave(waveHeight);
    wave3.drawWave(waveHeight);

    Button startButton = new Button(1360/2, 565, 200, 80, waveColor, "Start");
    fill(waveColor);
    textSize(30);
    textAlign(CENTER);

    text("This game is meant to replicate the experience of being on the cusp of an anxiety attack. During this game, you will be able to play through three exercises to stem your character’s feelings of panic: diaphragmatic breathing, progressive muscle relaxation, and cognitive behavioral therapy. At any point in time, you can also choose to panic, but choosing this option is entirely up to you, the player, and does not affect the gameplay of the exercises.\n" +
    "Click begin when ready.", 1360/2, 765/2, 1100, 500);

    startButton.drawButton();
    if (startButton.clicked()) {
      timer = 0;
      scene = Scene.START_SCREEN;
    }

    timer++;
    break;

  case START_SCREEN:
    imageMode(CORNER);
    image(startMirror, 0, 0);

    image(startReflectedLHand, hand1X+540, 220);
    image(startReflectedRHand, hand2X + 740, 220);

    if (exercisesComplete == 0) {
      handShakeSpeed = .6;
      mirrorWavesHeight = -20;
    }
    if (exercisesComplete == 1) {
      handShakeSpeed = 1;
      mirrorWavesHeight = 80;
    }
    if (exercisesComplete == 2) {
      handShakeSpeed = 1.3;
      mirrorWavesHeight = 180;
    }
    waveMenu.drawWave(mirrorWavesHeight);
    waveMenu2.drawWave(mirrorWavesHeight);
    waveMenu3.drawWave(mirrorWavesHeight);

    image(startBkg, 0, 0);
    imageMode(CORNER);
    image(startRHand, hand2X+30, 80);
    image(startLHand, hand1X, 80);

    hand1X = hand1X + 6*sin(float(frameCount)/handShakeSpeed);
    hand2X = hand2X - 6*sin(float(frameCount)/handShakeSpeed);

    Button calmButton = new Button(270, 200, 387, 100, #0CADCB, "Calm Down");
    calmButton.drawButton();
    if (calmButton.clicked()) {
      if (exercisesComplete == 0) {
        scene = Scene.BREATHE_MENU;
      }
      if (exercisesComplete == 1) {
        scene = Scene.PMR_MENU;
      }
      if (exercisesComplete == 2) {
        scene = Scene.CBT_MENU;
      }
    }

    Button panicButton = new Button(1080, 200, 387, 100, #CB6C0C, "Panic");
    panicButton.drawButton();
    if (panicButton.clicked()) {
      audio.pause();
      panicAudio.play();
      scene = Scene.PANIC;
    }
    break;

  case PMR_MENU:
    rectMode(CORNER);
    fill(waveColor);
    rect(0, 0, width, height);
    fill(blue, timer*5);
    noStroke();
    rect(0, 0, width, height);
    wave.drawWave(waveHeight);
    wave2.drawWave(waveHeight);
    wave3.drawWave(waveHeight);

    fill(menuTextColor, timer*5);
    textSize(30);
    textAlign(CENTER);
    text("There are two parts to this exercise.\nFirst, for eight seconds, clench the muscle group shown on screen\nas tightly as possible, " +
      "making sure to strain only those muscles. \nNext, exhale and quickly release the muscles. For fifteen seconds, " +
      "reflect on the\ndifference between your tensed muscles and relaxed muscles. This exercise\nwill be repeated six times " +
      "for six different muscle groups.\nClick begin when ready.", width/2, height/2 -140);
    tint(timer*5);
    image(pmrTXT, 0, 0);

    timer++;
    Button nextButton = new Button(width/2, height - 150, 200, 80, menuTextColor, "Begin");
    if (timer >= 24) {
      tint(255);
      image(pmrTXT, 0, 0);
      nextButton.drawButton();
      if (nextButton.clicked()) {
        timer = 0;
        scene = Scene.PMR_GAME;
      }
    }

    break;

  case BREATHE_MENU:
    rectMode(CORNER);
    fill(waveColor);
    rect(0, 0, width, height);
    fill(blue, timer*5);
    noStroke();
    rect(0, 0, width, height);
    wave.drawWave(waveHeight);
    wave2.drawWave(waveHeight);
    wave3.drawWave(waveHeight);

    fill(menuTextColor, timer*5);
    textSize(40);
    textAlign(CENTER);
    text("Breathe in for four seconds and out for eight seconds.\nThis exercise will be repeated six times.\nClick begin when ready.", width/2, height/2 - 100);
    image(breatheTXT, 0, 0);


    Button nextButtonB = new Button(width/2, height - 200, 200, 80, menuTextColor, "Begin");
    if (timer >= 24) {
      nextButtonB.drawButton();
      if (nextButtonB.clicked()) {
        timer = 0;
        scene = Scene.BREATHE_GAME;
      }
    }
    timer++;
    break;

  case CBT_MENU:
    rectMode(CORNER);
    fill(waveColor);
    rect(0, 0, width, height);
    fill(blue, timer*5);
    noStroke();
    rect(0, 0, width, height);
    wave.drawWave(waveHeight);
    wave2.drawWave(waveHeight);
    wave3.drawWave(waveHeight);

    fill(menuTextColor, timer*5);
    textSize(20);
    textAlign(CENTER);
    textSize(40);
    text("There are two parts to this exercise. First, type out\nany thoughts that may be inducing a sense of anxiety.\nNext, answer the four questions shown on screen to\nchallenge your anxiety-inducing thoughts.\nClick begin when ready.", width/2, height/2 - 170);
    image(cbtTXT, 0, 0);
    timer++;

    Button nextButtonC = new Button(width/2, height - 200, 200, 80, menuTextColor, "Begin");
    if (timer >= 24) {
      nextButtonC.drawButton();
      if (nextButtonC.clicked()) {
        timer = 0;
        scene = Scene.CBT_GAME1;
      }
    }
    break;

  case PMR_GAME:
    background(0);
    noStroke();
    inhale = 8;
    exhale = 16;
    imageMode(CORNER);
    image(pmrImages[rounds], 0, 0); //displaying body parts
    imageMode(CENTER);

    //hand breathing in and out logic
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    if (timer <= inhale*fps) {
      fill(colors[rounds], 90);
      rect(675 + downCosDisplacement(225, 240, timer, fps*inhale), 0, 600, height);
      rect(675 + downCosDisplacement(200, 230, timer-(inhale*fps), fps*exhale), 0, 600, height);
      imageMode(CORNER);
      breatheBar.c = colors[rounds];
      breatheBar.drawBar(timer, inhale*fps);
      fill(255);
      textSize(30);
      text(tensionBlurb[rounds], 975, 150, 300, 500);
      image(tenseTxt, 0, 0);
    }

    if (timer > inhale*fps) {
      fill(colors[rounds], 90);
      rect(675 + downCosDisplacement(225, 240, timer, fps*inhale), 0, 600, height);
      rect(675 + downCosDisplacement(200, 230, timer-(inhale*fps), fps*exhale), 0, 600, height);
      imageMode(CORNER);
      breatheBar.c = colors[rounds];
      breatheBar.drawBar(-(timer+(inhale*fps)), exhale*fps);
      fill(255);
      textSize(30);
      text(relaxBlurb[rounds], 975, 150, 300, 500);
      image(releaseTxt, 0, 0);
    }
    displayCircles(1000, height - 50, 25);

    if (timer > (inhale + exhale)*fps) {
      rounds++;
      timer = 0;
    }

    if (rounds == 6) {
      exercisesComplete++;
      rounds = 0;
      scene = Scene.START_SCREEN;
    }
    timer++;
    break;

  case BREATHE_GAME:
    background(0);
    noStroke();
    imageMode(CENTER);
    displayCircles(555, height - 50, 25);

    //hand breathing in and out logic
    fill(255);
    textSize(20);
    textAlign(CENTER);
    if (timer <= inhale*fps) {
      fill(colors[rounds], 100);
      circle(width/2, height/2, upCosDisplacement(230, 380, timer, fps*inhale));
      circle(width/2, height/2, upCosDisplacement(200, 400, timer, fps*inhale));
      image(breatheLHand, downCosDisplacement(200, width/2 - 200, timer, fps*inhale), 280);
      image(breatheRHand, upCosDisplacement(width/2+200, width -200, timer, fps*inhale), 270);
      imageMode(CORNER);
      image(breatheIn, -20, 0);
      breatheBar.c = colors[rounds];
      breatheBar.drawBar(timer, inhale*fps);
    }

    if (timer > inhale*fps) {
      fill(colors[rounds], 100);
      circle(width/2, height/2, downCosDisplacement(230, 380, timer-(inhale*fps), fps*exhale));
      circle(width/2, height/2, downCosDisplacement(200, 400, timer-(inhale*fps), fps*exhale));
      image(breatheLHand, upCosDisplacement(200, width/2 - 200, timer-(inhale*fps), fps*exhale), 280);
      image(breatheRHand, downCosDisplacement(width/2+200, width -200, timer-(inhale*fps), fps*exhale), 270);
      imageMode(CORNER);
      image(breatheOut, -20, 0);
      breatheBar.c = colors[rounds];
      breatheBar.drawBar(-(timer+(inhale*fps)), exhale*fps);
    }


    if (timer > (inhale + exhale)*fps) {
      rounds++;
      timer = 0;
    }

    if (rounds == 6) {
      exercisesComplete++;
      rounds = 0;
      scene = Scene.START_SCREEN;
    }

    timer++;
    break;

  case CBT_GAME2:
    lineCharLength = 35;
    background(0);
    waveMenu.drawWave(cbtWaterHeight);
    waveMenu2.drawWave(cbtWaterHeight);
    waveMenu3.drawWave(cbtWaterHeight);
    fill(255);
    textSize(30);
    textAlign(LEFT);

    fill(255);
    noStroke();
    rectMode(CORNER);
    float oscillate = -sin(float(frameCount)/13)*2;
    rect(550, 55, 500 + oscillate, 100 - oscillate, 20);

    Button done1 = new Button(width - 175, 105, 200, 80, blue, "Next");
    Button done2 = new Button(width - 175, 285, 200, 80, blue, "Next");
    Button done3 = new Button(width - 175, 465, 200, 80, blue, "Next");
    Button done4 = new Button(width - 175, 650, 200, 80, blue, "Done");

    done1.drawButton();
    image(cbt2txt1, 25, 0);

    if (done1.clicked()) {
      drawSecondQuestion = true;
    }
    if (done2.clicked()) {
      drawThirdQuestion = true;
    }
    if (done3.clicked()) {
      drawFourthQuestion = true;
    }


    imageMode(CORNER);
    if (drawSecondQuestion) {
      cbtWaterHeight = 230;
      fill(255);
      rectMode(CORNER);
      rect(550, 235, 500 + oscillate, 100 - oscillate, 20);
      done2.drawButton();
      image(cbt2txt2, 25, 0);
    }
    if (drawThirdQuestion) {
      cbtWaterHeight = 430;
      fill(255);
      rectMode(CORNER);
      rect(550, 415, 500 + oscillate, 100 - oscillate, 20);
      done3.drawButton();
      image(cbt2txt3, 25, 0);
    }
    if (drawFourthQuestion) {
      cbtWaterHeight = 630;
      fill(255);
      rectMode(CORNER);
      rect(550, 600, 500 + oscillate, 100 - oscillate, 20);
      done4.drawButton();
      image(cbt2txt4, 25, 0);
    }
    textAlign(CORNER);
    textSize(30);
    fill(0);
    switch(txtDrawing) {
    case 1:
      cbt2Line1 = masterLine;
      if (done1.clicked()) {
        txtDrawing++;
        masterLine = "";
      }
      break;

    case 2:
      cbt2Line2 = masterLine;
      if (done2.clicked()) {
        txtDrawing++;
        masterLine = "";
      }
      break;
    case 3:
      cbt2Line3 = masterLine;
      if (done3.clicked()) {
        txtDrawing++;
        masterLine = "";
      }
      break;
    case 4:
      cbt2Line4 = masterLine;
      if (done4.clicked()) {
        timer = 0;
        scene = Scene.ENDING;
      }
      break;
    }
    text(cbt2Line1, 570, 90);
    text(cbt2Line2, 570, 270);
    text(cbt2Line3, 570, 450);
    text(cbt2Line4, 570, 630);

    timer++;
    break;

  case CBT_GAME1:
    lineCharLength = 60;
    background(0);
    fill(255);
    textSize(30);
    textAlign(LEFT);
    waveMenu.drawWave(cbtWaterHeight);
    waveMenu2.drawWave(cbtWaterHeight);
    waveMenu3.drawWave(cbtWaterHeight);
    image(cbtSpeechBubble, 0, 0);

    fill(255);
    noStroke();
    rectMode(CENTER);
    float oscillate2 = -sin(float(frameCount)/13)*2;
    rect(535, 470, 960 + oscillate2, 470 - oscillate2, 20);

    Button nextCBTButton1 = new Button(1190, 660, 200, 80, blue, "Next");
    nextCBTButton1.drawButton();
    if (nextCBTButton1.clicked()) {
      timer = 0;
      lineIterator = 0;
      masterLine = "";
      scene = Scene.CBT_GAME2;
    }

    textAlign(CORNER);
    textSize(30);
    lines[lineIterator] = masterLine;
    fill(0);
    for (int i = 0; i < lines.length; i++) {
      text(lines[i], 77, 280 + (i*30));
    }

    timer++;
    break;

  case ENDING:
    imageMode(CORNER);
    image(startMirror, 0, 0);

    image(startReflectedLHand, hand1X+540, 220);
    image(startReflectedRHand, hand2X + 740, 220);

    mirrorWavesHeight = 180+timer;
    waveMenu.drawWave(mirrorWavesHeight);
    waveMenu2.drawWave(mirrorWavesHeight);
    waveMenu3.drawWave(mirrorWavesHeight);
    fill(#1cd5c1, timer*5);
    rectMode(CORNER);
    rect(0, 0, width, height);

    image(startBkg, 0, 0);
    imageMode(CORNER);
    if (timer <= 24) {
      image(startRHand, hand2X+30, 80);
      image(startLHand, hand1X, 80);
    }
    if (timer > 24) {
      image(startRHand, hand2X+30, 80 + ((timer-24)*(timer*.1)));
      image(startLHand, hand1X, 80 + ((timer-24)*(timer*.1)));
    }

    if (timer > 36) {
      fill(#CB9A88, (timer-36)*5);
      rectMode(CORNER);
      rect(0, 0, width, height);
    }

    if (timer > 24*3) {
      image(endingTxt, 0, 0);
    }
    timer++;
    break;

  case PANIC:
    imageMode(CORNER);
    image(startMirror, 0, 0);
    mirrorWavesHeight -= timer;

    image(startReflectedLHand, hand1X+540, 220);
    image(startReflectedRHand, hand2X + 740, 220);
    waveMenu.drawWave(mirrorWavesHeight);
    waveMenu2.drawWave(mirrorWavesHeight);
    waveMenu3.drawWave(mirrorWavesHeight);
    image(startBkg, 0, 0);

    hand1X = hand1X + 10*sin(float(frameCount)/(.1));
    hand2X = hand2X - 10*sin(float(frameCount)/(.1));

    imageMode(CORNER);
    image(startRHand, hand2X+30, 80);
    image(startLHand, hand1X, 80);

    if (timer > 24) {
      fill(waveColor, (timer-24)*5);
      rectMode(CORNER);
      rect(0, 0, width, height);
    }

    if (timer > 12) {
      fill(255, (timer-12)*2);
      textSize((timer-12)*1.3);
      for (int i = 0; i < ((timer/3)-12); i++) {
        int rand = (int)random(0, panicStringArr.length - 1);
        int randx = (int)random(0, width - 200);
        int randy = (int)random(0, height);
        text(panicStringArr[rand], randx, randy);
      }
    }
    if (timer > 140) {
      exit();
    }
    timer++;
    break;
  }
}
