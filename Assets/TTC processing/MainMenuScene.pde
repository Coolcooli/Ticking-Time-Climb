//Made By Lars Nienhuis 500882270

class MainMenuScene implements IScene { 
  Button[] buttons = new Button[5]; //Declare an array of buttons
  
  Background background;

  void startScene() {
    placeInArray = 0;
    buttons[0] = new Button("Start", new PVector(width/2 - Config.BUTTON_H, Config.BUTTON_Y_START_MAIN), Config.BUTTON_W, Config.BUTTON_H); //Insert all of the buttons
    buttons[1] = new Button("High Scores", new PVector(width/2 - Config.BUTTON_H, Config.BUTTON_Y_HIGH_MAIN), Config.BUTTON_W, Config.BUTTON_H);
    buttons[2] = new Button("Controls", new PVector(width/2 - Config.BUTTON_H, Config.BUTTON_Y_CONTROLS_MAIN), Config.BUTTON_W, Config.BUTTON_H);
    buttons[3] = new Button("Change Name", new PVector(width/2 - Config.BUTTON_H, Config.BUTTON_Y_CHANGE_NAME_MAIN), Config.BUTTON_W, Config.BUTTON_H);
    buttons[4] = new Button("Quit Game", new PVector(width/2 - Config.BUTTON_H, Config.BUTTON_Y_EXIT_MAIN), Config.BUTTON_W, Config.BUTTON_H);
    buttons[placeInArray].isActive = true;
    
    background = new Background(new PVector(0, 0), width, height, 1);
  }

  void updateScene() {
    if (keysPressed[DOWN] != keysPrevious[DOWN] && keysPressed[DOWN] && placeInArray < buttons.length ) { //Use the up and down arrows to move through the buttons
      buttons[placeInArray].isActive = false;
      placeInArray += 1;

      if (placeInArray > buttons.length - 1) {
        placeInArray = 0; //Loop the buttons
      }
      buttons[placeInArray].isActive = true;
    }
    if (keysPressed[UP] != keysPrevious[UP] && keysPressed[UP] && placeInArray >= 0) {
      buttons[placeInArray].isActive = false;
      placeInArray -= 1;
      if (placeInArray < 0) {
        placeInArray = buttons.length - 1; //Loop the buttons
      }
      buttons[placeInArray].isActive = true;
    }
    if (keysPressed['X'] != keysPrevious['X'] && keysPressed['X']) { //If 'X' is pressed on a specific button it activates
      if (placeInArray == 0) { 
        switchScene(Config.GAMESCENE);
        state = !state;
      }
      if (placeInArray == 1) { 
        switchScene(Config.HIGHSCORESCENE);
        state = !state;
      }
      if (placeInArray == 2) { 
        switchScene("Controls");
        state = !state;
      }
      if (placeInArray == 3) { 
        switchScene(Config.NAMESCENE);
        state = !state;
      }
      if (placeInArray == 4) { 
        exit();
      }
    }
  }

  void drawScene() {
    background.display();
    for (Button button : buttons) //Update and draw all buttons
    {
      button.update();
    }
    drawName();
  }

  void drawName() {
    textSize(100);
    textAlign(CENTER, CENTER);
    fill(0);
    text("Ticking Time Climb", width/2, height/4); //Draw the name of the game
  }
}
