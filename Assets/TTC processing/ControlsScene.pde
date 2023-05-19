//Code from Kevin Kroon 500855487
class ControlsScene implements IScene {
  Button[] buttons = new Button[Config.AMOUNT_OF_CONTROLS_BUTTONS];
  void startScene() {
    placeInArray = 0;
    buttons[0] = new Button("", new PVector(Config.BUTTON_X_CONTROLS, Config.BUTTON_Y_CONTROLS), Config.BUTTON_W, Config.BUTTON_H); //Insert a new button
    buttons[placeInArray].isActive = true;
  }
  void updateScene() {
    //from mainmenu > controls > mainmenu
    if (keysPressed['X'] != keysPrevious['X'] && keysPressed['X']) { //If 'X' is pressed on a specific button it activates
      switchScene(Config.MAINMENUSCENE);
      state = !state;
    }
    //from mainmenu > controls > playgame
    //als vorige scene de gamescene is dan terug naar de gamescene
    //if (keysPressed['X']) {
    //  switchScene(Config.GAMESCENE);
    //  state = !state;
    //}
  }
  void drawScene() {
    tutorial();
    for (Button button : buttons) //Update all buttons
    {
      button.update();
    }
    image(exitImg, Config.BUTTON_X_CONTROLS + Config.BUTTON_W/2 - exitImg.width/2, Config.BUTTON_Y_CONTROLS + Config.BUTTON_H/2 - exitImg.height/2); //Draw an exit picture
  }

  void tutorial() {    
    fill(#000000);
    rect(0, 0, width, height);
    textAlign(LEFT);
    linesAndRects();
    tutorialImages();
    info();
    staminaUI();
    noFill();
  }


  void linesAndRects() {
    image(controller, width / 4 + 132, 600, controller.width, controller.height);

    fill(#747474);
    rect(27, 625, 438, 247);
    rect(1430, 584, 461, 311);
    rect(421, 99, 1143, 418);
    rect(817, 957, 283, 81);
    stroke(#FFFFFF);
    strokeWeight(12); 
    //left
    line(467, 730, 680, 740); //connect
    line(467, 625, 467, 873); //base
    line(467, 625, 371, 625); //top
    line(467, 873, 371, 873); //bottom
    //right
    line(1223, 715, 1422, 706); //connect
    line(1428, 585, 1428, 894); //base
    line(1429, 581, 1550, 581); //top
    line(1429, 897, 1550, 897); //bottom
    //top
    line(422, 519, 1563, 520); //connect
    line(420, 102, 420, 518); //base
    line(422, 101, 1563, 101); //left
    line(1565, 102, 1564, 519); //right
    //bottom
    line(974, 823, 948, 956); //connect
    line(817, 955, 1100, 955); //base
    line(817, 955, 817, 985); //left
    line(1101, 955, 1101, 985); //right
    noStroke();
  }

  void info() {
    textSize(52);
    fill(#FFFFFF);   
    text("Clean", width/2 + 580, height/2 + 107);
    text("Clean", width/2 + 578, height/2 + 182);
    text("Select", width/2 + 581, height/2 + 257);   
    text("Jump", width/2 + 571, height/2 + 332);

    text("Pause", width/2 - 130, height - 51);

    text("Movement", width/2 + -898, height/2 + 279);

    text("How to Play", width/2 + -239, height/2 + -467);

    textSize(32);
    text("Climb and clean to gain score", width/2 - 524, height/2 - 388);
    text("But watch out for the stamina bar!", width/2 - 523, height/2 - 350);

    text("Jumping costs stamina.", width/2 - 526, height/2 - 191);
    text("Clean tiles or stand still", width/2 - 519, height/2 - 143);
    text("to recharge stamina.", width/2 - 520, height/2 - 89);
  }

  int ticksPerSecond = 4;

  float x;
  float stamina = 100;
  void staminaUI() {
    if (frameCount % (round(frameRate) / ticksPerSecond) == 0) {
      stamina -= 8;
    }
    if (stamina <= 4) {
      stamina = 100;
    }
    float r = remap(stamina, 60, 100, 222, 87);
    float g = remap(stamina, 60, 100, 112, 222);
    float b = remap(stamina, 60, 100, 87, 127);
    float a = remap(stamina, 80, 100, 255, 0);
    stroke(r, g, b, a);
    fill(r, g, b, a);
    rect(width/2 + 60, height/2 - 240, 10, remap(stamina, 0, 100, 0, -60));

    image(playerIdle, width/2 - 80, height/2 - 350, playerIdle.width, playerIdle.height);
    noStroke();
  }

  void tutorialImages() {
    image(BlueButton, width /2 + 491, height/2 + 61, 65, 65);
    image(GreenButton, width /2 + 491, height/2 + 132, 65, 65);
    image(RedButton, width /2 + 491, height/2 + 206, 65, 65);
    image(YellowButton, width /2 + 491, height/2 + 278, 65, 65);

    image(playerRunSlides[slidesIndex], 204, 634);
    image(playerCleanSlides[slidesIndex], 1300, 322);

    if (frameCount % (round(frameRate) / ticksPerSecond) == 0) {
      slidesIndex = (slidesIndex + 1) % slidesFrames;
    }
  }
}
