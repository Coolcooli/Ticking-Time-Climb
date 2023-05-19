//Declare all images and sounds

PImage exitImg;
PImage highScoreBackgroundImg;
PImage platformImg;
PImage windowImg;
PImage lowerBuildingImg;
PImage sidewalkImg;
PImage elevatorImg;
PImage elevatorShaftImg;
PImage poopImg;
PImage insideImg;
PImage[] planetImgs = new PImage[7];
PImage gravestone;
//controls instructions
PImage playerIdle;
PImage controller;
PImage BlueButton;
PImage GreenButton;
PImage RedButton;
PImage YellowButton;
PImage scoreBackground, comboBackground;
PImage windowToneVone, windowToneVtwo;
PImage windowTtwoVone, windowTtwoVtwo;
int slidesFrames = 6;
int slidesIndex = 0;
PImage[] playerRunSlides = new PImage[slidesFrames];
PImage[] playerCleanSlides = new PImage[slidesFrames];

Animation staticWindow, staticElevator, staticNastyWindow;
Animation nastyWindowClean, windowShatter;

Animation buttonAnim;

HashMap<Integer, PImage[]> BACKGROUNDS = new HashMap<Integer, PImage[]>();

AudioPlayer falling;
AudioPlayer boneBreak;
AudioPlayer landing;
AudioPlayer waterHose;
AudioPlayer TTCMainTheme;
AudioPlayer titleTheme;
AudioPlayer fireSound;
AudioPlayer fireAlarm;

PFont pixelFont;

public void loadAssets() { //Load all needed assets
  titleTheme = minim.loadFile("SoundFX/titleTheme.wav");
  for (int i = 1; i <= planetImgs.length; i++) {
    planetImgs[i-1] = loadImage("Background/Planet00" + i + ".png");
  }

  for (int i = 0; i < slidesFrames; i ++ ) {
    playerRunSlides[i] = loadImage("Player/Gunner_Blue_Run_right-export00" + i + ".png");
    playerCleanSlides[i] = loadImage("Player/Gunner_Blue_Clean_Right-export00" + i + ".png");
  }

  scoreBackground = loadImage("Misc/ScoreBackground.png");
  comboBackground = loadImage("Misc/ComboBackground.png");

  poopImg = loadImage("Building/BirdPoop.png");

  insideImg = loadImage("Building/FloorBackground-export.png");

  PImage[] b1 = new PImage[1];
  b1[0] = loadImage("Building/FloorBackground-export01-000.png");
  BACKGROUNDS.put(1, b1);

  PImage[] b2 = new PImage[2];
  b2[0] = loadImage("Building/FloorBackground-export02-000.png");
  b2[1] = loadImage("Building/FloorBackground-export02-001.png");
  BACKGROUNDS.put(2, b2);

  PImage[] b3 = new PImage[1];
  b3[0] = loadImage("Building/FloorBackground-export03-000.png");
  BACKGROUNDS.put(3, b3);

  PImage[] b4 = new PImage[1];
  b4[0] = loadImage("Building/FloorBackground-export04-000.png");
  BACKGROUNDS.put(4, b4);

  PImage[] b5 = new PImage[1];
  b5[0] = loadImage("Building/FloorBackground-export05-000.png");
  BACKGROUNDS.put(5, b5);

  staticWindow = new Animation("Building/Window-export", 1);
  staticElevator = new Animation("Building/ElevatorShaft-export", 1);
  staticNastyWindow = new Animation("Building/Window-nasty-export", 1);
  nastyWindowClean = new Animation("Building/WindowClean-export", 20);
  windowShatter = new Animation("Building/Window-shatter-export", 8);

  buttonAnim = new Animation("Misc/Button-export", 2);

  exitImg = loadImage("Misc/Exit.png");
  highScoreBackgroundImg = loadImage("Background/HighScoreBackground.png");

  platformImg = loadImage("Building/Platform-export.png");

  lowerBuildingImg = loadImage("Building/Entrance-export.png");
  sidewalkImg = loadImage("Building/Sidewalk.png");
  elevatorImg = loadImage("Building/Elevator-export.png");

  gravestone = loadImage("Misc/gravestone.png");

  playerIdle = loadImage("Player/Gunner_Blue_Idle_Left-export003.png");
  controller = loadImage("Misc/controller.PNG");
  BlueButton = loadImage("Misc/BlueButton.png");
  GreenButton = loadImage("Misc/GreenButton.png");
  RedButton = loadImage("Misc/RedButton.png");
  YellowButton = loadImage("Misc/YellowButton.png");

  windowToneVone = loadImage("Background/window-001.png");
  windowToneVtwo = loadImage("Background/window-002.png");
  windowTtwoVone = loadImage("Background/window-003.png");
  windowTtwoVtwo = loadImage("Background/window-004.png");

  TTCMainTheme = minim.loadFile("SoundFX/TTCMainTheme.wav");
  falling = minim.loadFile("SoundFX/Falling.wav");
  falling.setGain(-20);
  boneBreak = minim.loadFile("SoundFX/BreakBone.wav");
  landing = minim.loadFile("SoundFX/Landing.wav"); 
  landing.setGain(-30);
  waterHose = minim.loadFile("SoundFX/WaterHose.wav");  
  waterHose.setGain(-30);
  fireAlarm = minim.loadFile("SoundFX/FireAlarm.wav");
  fireSound = minim.loadFile("SoundFX/Fire.wav");

  pixelFont = createFont("Misc/PixelFont.TTF", 50);
  textFont(pixelFont);
}
