//Made By Lars Nienhuis 500882270

class GameOverScene implements IScene {

  Button[] buttons = new Button[Config.AMOUNT_OF_GAMEOVER_BUTTONS]; //Make an array of buttons
  Timer buttonTimer = new Timer(0); //Declare and initialize a timer

  boolean drawInsertError = false;

  void startScene() {
    buttons[0] = new Button("Try Again", new PVector(Config.RETRY_GAMEOVER_X, Config.RETRY_GAMEOVER_Y), Config.BUTTON_W_GAMEOVER, Config.BUTTON_H_GAMEOVER); //Insert the buttons
    buttons[1] = new Button("Highscores", new PVector(Config.HIGH_GAMEOVER_X, Config.HIGH_GAMEOVER_Y), Config.BUTTON_W_GAMEOVER, Config.BUTTON_H_GAMEOVER);
    buttons[2] = new Button("Main Menu", new PVector(Config.MAIN_GAMEOVER_X, Config.MAIN_GAMEOVER_Y), Config.BUTTON_W_GAMEOVER, Config.BUTTON_H_GAMEOVER);

    fireAlarm.pause(); //pause playing the gamescene sounds
    fireSound.pause();
    TTCMainTheme.setGain(-10); //Reset the themesongs amp

    buttonTimer.init(); //Start counting

    // adds all metrics to the database
    database.addMetrics("jump", jumps);
    database.addMetrics("windowsCleaned", windowsCleaned);
    database.addMetrics("elevatorsUsed", elevatorsUsed);
    insertNewHighscore();

    jumps = 0;
    windowsCleaned = 0;
    elevatorsUsed = 0;
  }
  void updateScene() { //Call all functions
    if (buttonTimer.time > 1.5) { //If the timer is over 1.5 seconds you can begin interacting
      moveThroughButtons();
      selectButton();
    } else {
      buttonTimer.update();
    }
  }

  void drawScene() {
    background(0);

    drawButtons(); //Draw all buttons
    drawGameOverText();
    drawNetworkError();
  }

  void moveThroughButtons() {
    if (keysPressed[RIGHT] != keysPrevious[RIGHT] && keysPressed[RIGHT]) { //If you press the arrows you move through the buttons
      buttons[placeInArray].isActive = false;
      placeInArray += 1;

      if (placeInArray > buttons.length - 1) {
        placeInArray = 0; //Loop the buttons
      }
      buttons[placeInArray].isActive = true;
    }
    if (keysPressed[LEFT] != keysPrevious[LEFT] && keysPressed[LEFT]) {
      buttons[placeInArray].isActive = false;
      placeInArray -= 1;
      if (placeInArray < 0) {
        placeInArray = buttons.length - 1; //Loop the buttons
      }
      buttons[placeInArray].isActive = true;
    }
    if (placeInArray == 0) {
      buttons[0].isActive = true;
    }
  }

  void selectButton() {
    if (keysPressed['X'] != keysPrevious['X'] && keysPressed['X']) { //If you press 'X' while on a button it runs the command that is linked to the button
      if (placeInArray == 0) { 
        switchScene(Config.GAMESCENE);
        state = !state;
        buttons[0].isActive = false;
      }
      if (placeInArray == 1) {
        switchScene(Config.HIGHSCORESCENE);
        placeInArray = 0;
        paused = !paused;
        state = !state;
        buttons[1].isActive = false;
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

  void drawButtons() {
    for (Button button : buttons) { //Update and draw all buttons
      button.update();
    }
  }

  void insertNewHighscore() { 
    try {
      database.enterScore(); //Try to insert the new highscore
    } 
    catch (Exception e) {
      drawInsertError = true; //If the highscore can't be submitted (no connection) this boolean becomes true
    }
  }


  void drawGameOverText() {
    textSize(Config.GAMEOVER_SIZE);
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    text("GAME OVER", Config.GAMEOVER_X, Config.GAMEOVER_Y); //Draw a big GAME OVER text
  }

  void drawNetworkError() {
    if (drawInsertError) {
      fill(255, 0, 0);
      textSize(Config.NAME_INSERT_ERROR_TEXT);
      text("Could not enter the highscore (network error)", width/2, Config.NAME_INSERT_ERROR_Y_1); //If there is a network error this draws
      text("Press 'X' to continue", width/2, Config.NAME_INSERT_ERROR_Y_2);
    }
  }
}
