//Made by Lars Nienhuis 500882270

class HighScoreScene implements IScene {
  Button[] buttons = new Button[Config.AMOUNT_OF_HIGH_BUTTONS]; 
  
  void startScene() {
    placeInArray = 0;
    buttons[0] = new Button("", new PVector(Config.BUTTON_X_HIGH, Config.BUTTON_Y_HIGH), Config.BUTTON_W, Config.BUTTON_H); //Insert a new button
    buttons[placeInArray].isActive = true;    
    database.highscore = myConnection.runQuery(database.getHighscores);
  }
  
  void updateScene() {
    if (keysPressed['X'] != keysPrevious['X'] && keysPressed['X']) { //If 'X' is pressed you excecute the command
      switchScene(Config.MAINMENUSCENE);
      state = !state;
    }
  }

  void drawScene() { //Call all of the functions
    drawBackground();
    drawButtons();
    drawScores();    
    try {
      drawHighscores(database.highscore);
    } 
    catch (Exception e) {
      resolveDatabaseError();
      dataBaseError = true;
    }
  }

  void drawButtons() {
    noStroke();
    for (Button button : buttons) //Update and draw all buttons
    {
      button.update();
    }
    image(exitImg, Config.BUTTON_X_HIGH + Config.BUTTON_W/2 - exitImg.width/2, Config.BUTTON_Y_HIGH + Config.BUTTON_H/2 - exitImg.height/2); //Draw an exit picture
  }

  void drawHighscores(Table highscore) {
    if (!dataBaseError) {
      for (int i = 0; i < highscore.getRowCount(); i++) {
        TableRow row = highscore.getRow(i);
        for (int j = 0; j < row.getColumnCount(); j++) {
          fill(0);
          textSize(Config.HIGHSCORE_TEXT_SIZE);
          text(row.getString(j), Config.COLUMN_X + Config.PLACE_BETWEEN_COLUMNS * (j + 1), Config.RANK_Y + Config.PLACE_BETWEEN_ROWS * i); //Draw all of the highscores
        }
      }
    }
  }

  void resolveDatabaseError() {
    if (dataBaseError) {
      textSize(Config.NETWORK_ERROR_TEXT_SIZE);
      fill(255, 0, 0);
      text("Network Error", width/2, height/2); //If dataBaseError is true draw this text
    }
  }

  void drawBackground() {
    image(highScoreBackgroundImg, 0, 0, width, height); //Draw the background
  }

  void drawScores() {
    fill(0, 150, 0, 200);
    stroke(0, 255, 0);
    rect(Config.HIGHSCORE_RECT_BACKGROUND_X, Config.HIGHSCORE_RECT_BACKGROUND_Y, Config.HIGHSCORE_RECT_BACKGROUND_W, Config.HIGHSCORE_RECT_BACKGROUND_H, Config.HIGHSCORE_RECT_BACKGROUND_CURVE); //Draw the big rectangle

    fill(0);
    textSize(Config.HIGHSCORE_TEXT_SIZE);
    text("Rank:", Config.COLUMN_X, Config.HIGHSCORE_COLUMNS_Y);
    text("Name:", Config.COLUMN_X + Config.PLACE_BETWEEN_COLUMNS, Config.HIGHSCORE_COLUMNS_Y);
    text("High Scores:", Config.COLUMN_X + (2 * Config.PLACE_BETWEEN_COLUMNS), Config.HIGHSCORE_COLUMNS_Y); //Draw the name of the columns
    for (int i = 1; i <= 10; i++) {
     text(i, Config.COLUMN_X, Config.HIGHSCORE_COLUMNS_Y + (Config.PLACE_BETWEEN_ROWS * i)); //Draw number 1 to 10

    }
  }
}
