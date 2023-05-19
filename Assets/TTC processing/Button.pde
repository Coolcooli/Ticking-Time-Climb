//Made By Lars Nienhuis 500882270 && Robin Schellingerhout
class Button {
  String label;
  PVector position;
  float w, h;
  boolean ready;
  boolean isActive;
  int diameter = 25;

  final color RED = color(255, 0, 0);
  final color GREY = color(218);

  Button(String label, PVector position, float w, float h) {
    this.label = label;
    this.position = position;
    this.w = w;
    this.h = h;
    state = false;
    this.ready = true;
  }

  void update() {
    int moveLabel = 0;
    if (isActive) { //Make button color red if active, else make it grey
      buttonColor = RED;
    } else {
      buttonColor = GREY;
    }

    textSize(Config.TEXT_SIZE);
    fill(buttonColor);
    rect(position.x, position.y, w, h, Config.RECT_CURVE); //Draw a button
    fill(0);
    pushMatrix();
    textAlign(CENTER, CENTER);
    if (isActive) { //If button is active draw a circle with a 'A' in it
      text("A", position.x + w/10, position.y + (h / 2));
      noFill();
      stroke(0);
      strokeWeight(2);
      circle(position.x + w/10, position.y + (h / 2), diameter);
      noStroke();
      fill(0);
      moveLabel = Config.MOVE_LABEL; //If the button is active move the text on it to the right to make room for the circle
    }
    text(label, position.x + (w / 2) + moveLabel, position.y + (h / 2)); //Draw button text
    popMatrix();
    
    if (keysPressed['Z'] != keysPrevious['Z'] && keysPressed['Z'] && ready) { //If you press 'Z' on the button it triggers
      ready = false;
      state = !state;
    }
    ready = true;
  }
}
