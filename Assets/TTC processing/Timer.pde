//made by Hugues

class Timer {

  float time = 0;
  boolean counting = false;

  Timer(float x) { //The constructor for a new timer
    time = x;
  }
  void init() { //This activates the timer
    counting = true;
  }

  void pause() { //This pauses the timer
    counting = false;
  }
  void end() { //This stops the timer
    counting = false;
    time = 0;
  }
  void reset(){
   time = 0; 
  }
  void update() {
    if (counting == true) {
      time += 1 / frameRate;
    }
  }
}
