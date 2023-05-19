//Made by Lars Nienhuis 500882270

class LetterPicker {

  PVector position;

  int letterCounter;
  char letter;
  boolean isActive;

  LetterPicker(PVector position) {
    this.position = position;

    letterCounter = Config.LETTER_A; //Set the letter to 'A' in the beginning
    letter = char(letterCounter);
  }

  void update() {
    if (isActive) {
      if (keysPressed[DOWN] != keysPrevious[DOWN] && keysPressed[DOWN]) { //Use the up and down arrows to move through the letters
        letterCounter++;
        if (letterCounter >= 91) { //Loop the letters
          letterCounter = Config.LETTER_A;
        }
      }
      if (keysPressed[UP] != keysPrevious[UP] && keysPressed[UP]) {
        letterCounter--; 
        if (letterCounter < 65) {
          letterCounter = Config.LETTER_Z;
        }
      }
    }
    letter = char(letterCounter);
  }

  void display() {
    // Draw the letter to the screen
    noStroke();
    fill(#0671C1);
    textSize(Config.INSERT_HIGHSCORE_SIZE);
    if (isActive) {
      image(elevatorImg, position.x-4, position.y - elevatorImg.height/4, 48, 80); //Draw a small sized elevator behind the letter
      fill(255);
    }
    text(letter, position.x, position.y);
  }
}
