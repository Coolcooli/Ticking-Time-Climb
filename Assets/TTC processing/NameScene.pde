//Made by Lars Nienhuis 500882270

class NameScene implements IScene {

  Background background;
  
  ArrayList<LetterPicker> letters = new ArrayList<LetterPicker>();

  boolean enteringName; //Declare all variables
  int position;
  int letterCounter;

  void startScene() {
    enteringName = true;
    if (letters.size() == 0) letters.add(new LetterPicker(new PVector(Config.NAMESCENE_LETTER_X, Config.NAMESCENE_LETTER_Y))); //Add the first letter in the beginning of this scene
    position = 1;
    letters.get(0).isActive = true;
    background = new Background(new PVector(0, 0), width, height, 2);
    titleTheme.loop();
    titleTheme.setGain(-20);
  }

  void updateScene() {
    background.update();
    for (LetterPicker l : letters) {
      l.update(); //Update all letters
    }
    MoveThroughLetters();
    removeLetter();
    insertName();
  }

  void drawScene() {
    background.display();
    for (LetterPicker l : letters) {
      l.display(); //Display all letters
    }
    drawInsert(); //Draw the insert text
  }

  void MoveThroughLetters() { //Use the arrows to move through the buttons
    if (keysPressed[RIGHT] != keysPrevious[RIGHT] && keysPressed[RIGHT]) {
      if (position >= 8) position = 0;
      if (position < 8) {
        position++;
        if (position > letters.size()) 
        letters.add(new LetterPicker(new PVector(Config.NAMESCENE_LETTER_X + (Config.NAMESCENE_DIST_BETWEEN_LETTERS * letters.size()), Config.NAMESCENE_LETTER_Y))); //Add a new letter if the statement is true
      }
    }

    if (keysPressed[LEFT] != keysPrevious[LEFT] && keysPressed[LEFT]) {
      position--;
      if (position < 1) {
        if (letters.size() >= 8) {
          position = 8;
        } else {
          position = letters.size();
        }
      }
    }
  }

  void removeLetter() {
    if (keysPressed['S'] != keysPrevious['S'] && keysPressed['S'] && letters.size() > 1) { //If you press 'S' it removes the last letter
      letters.remove(letters.size()-1);
    }
    for (int i = 0; i < letters.size(); i++) {
      letters.get(i).isActive = false;
    }
    try {
      letters.get(position-1).isActive = true; //Set the letter before it to active
    } 
    catch (Exception e) {
      position--; //If the try fails remove 1 from position and set that to true
      letters.get(position-1).isActive = true;
    }
  }

  void insertName() {
    if (keysPressed['X'] != keysPrevious['X'] && keysPressed['X']) {
      for (int i = 0; i < letters.size()-1; i++) {
        if (i == 0) name = str(letters.get(0).letter);
        name += letters.get(i+1).letter; //Insert the letters into the string 'name'
      }
    }

    if (keysPressed['X'] != keysPrevious['X'] && keysPressed['X'] && name != null) {
      database.addUser(); //Add the current user to the database
      switchScene(Config.MAINMENUSCENE);
    }
  }

  void drawInsert() {
    fill(255);
    textSize(25);
    textAlign(RIGHT);
    text("Use the arrows to enter your name", Config.SUBMIT_HIGHSCORE_X, Config.LETTER_Y); //Draw some text to explain how to use this scene
    text("Press 'X' to remove the last letter", Config.SUBMIT_HIGHSCORE_X, Config.LETTER_Y + 70);
    text("Press 'A' to submit your name", Config.NAME_SUBMIT_X, Config.NAME_SUBMIT_Y);

    textSize(Config.INSERT_HIGHSCORE_SIZE);
    textAlign(LEFT);
    fill(255);
    text("name:", letters.get(0).position.x - 250, letters.get(0).position.y);
    text("Choose your", letters.get(0).position.x - Config.CHOOSE_NAME_X_OFFSET, letters.get(0).position.y - Config.CHOOSE_NAME_Y_OFFSET); //Draw the name text
  }
}
