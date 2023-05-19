//Made By Lars Nienhuis 500882270

class PauseMenu implements IScene {
  Button[] buttons = new Button[Config.AMOUNT_OF_PAUSE_BUTTONS]; //Make an array of buttons

  void startScene() {
    placeInArray = 0;
    buttons[0] = new Button("Resume", new PVector(Config.RESUME_X, Config.RESUME_Y), Config.BUTTON_W_PAUSE, Config.BUTTON_H_PAUSE); //Insert all buttons
    buttons[1] = new Button("Retry", new PVector(Config.RETRY_X, Config.RETRY_Y), Config.BUTTON_W_PAUSE, Config.BUTTON_H_PAUSE);
    buttons[2] = new Button("Main Menu", new PVector(Config.QUIT_X, Config.QUIT_Y), Config.BUTTON_W_PAUSE, Config.BUTTON_H_PAUSE);
    buttons[placeInArray].isActive = true;
  }

  void updateScene() {
    if (paused) {
      if (keysPressed[DOWN] != keysPrevious[DOWN] && keysPressed[DOWN]) { //Move through the buttons when paused
        buttons[placeInArray].isActive = false;
        placeInArray += 1;

        if (placeInArray > buttons.length - 1) {
          placeInArray = 0;
        }
        buttons[placeInArray].isActive = true;
      }
      if (keysPressed[UP] != keysPrevious[UP] && keysPressed[UP]) {
        buttons[placeInArray].isActive = false;
        placeInArray -= 1;
        if (placeInArray < 0) {
          placeInArray = buttons.length - 1;
        }
        buttons[placeInArray].isActive = true;
      }
      if (placeInArray == 0) {
        buttons[0].isActive = true;
      }
    }
    if (keysPressed['X'] && paused) { //If 'Z' is pressed on a certain button it becomes active
      if (placeInArray == 0) { 
        paused = !paused;
        state = !state;
        buttons[0].isActive = false;
      }
      if (placeInArray == 1) { 
        switchScene(Config.GAMESCENE);
        placeInArray = 0;
        paused = !paused;
        state = !state;
        buttons[1].isActive = false;
        background(0);
      }
      if (placeInArray == 2) { 
        switchScene(Config.MAINMENUSCENE);
        placeInArray = 0;
        paused = !paused;
        state = !state;
        buttons[2].isActive = false;
      }
    }
  }

  void drawScene() {
    for (Button button : buttons) //Update and draw all buttons
    {
      button.update();
    }
  }
}
