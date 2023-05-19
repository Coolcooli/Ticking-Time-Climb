//Code from Kevin Kroon 500855487
class ComboSystem {
  Timer comboTimer;
  int triggerTime = 10;

  float endAngle = 0;
  float cut = HALF_PI;

  ComboSystem(int input) {
    comboScoreCount = input;

    comboTimer = new Timer(0);
    comboTimer.init();
  }

  void display() {
    fill(#ffffff);
    textSize(28);
    comboCount();
    comboModifier();
  }

  void update() {   
    comboTimer.update();   
    if (comboTimer.time >= triggerTime) {
      comboScoreCount = 0;
      //comboTimer.end();      
      comboTimer.time = 0;
    }
  }

  void comboCount() {
    fill(#639bff);
    stroke(#3f3f74);
    strokeWeight(4);
    rect(60, 200, 256, 32);
    fill(#ffffff);
    textAlign(LEFT);
    text("Combo:" + round(comboScoreCount), 80, 210);
  }

  void comboModifier() {
    radians(360);
    //endAngle = lerp(endAngle, TWO_PI, amt);
    endAngle = remap(comboTimer.time, 0, 10, 0, TWO_PI);
    stroke(#3f3f74);
    strokeWeight(8);
    noFill();
    arc(430, 132, 100, 100, 0, TWO_PI - endAngle);

    image(comboBackground, 400, 100, 64, 64);
    textAlign(LEFT);
    text("X" + round(comboScoreModifier), 405, 145);
    noStroke();

    //times score
    //combo modulo for modifier
    if (comboScoreCount >= 5 && comboScoreCount < 10) {
      comboScoreModifier = 2;
    }
    if (comboScoreCount >= 10 && comboScoreCount < 20) {
      comboScoreModifier = 3;
    }
    if (comboScoreCount >= 20) {
      comboScoreModifier = 4;
    }
    if (comboScoreCount < 5) {
      comboScoreModifier = 1;
    }
  }
}
