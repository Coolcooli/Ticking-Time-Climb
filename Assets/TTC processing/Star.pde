//Made by Lars Nienhuis 500882270

class Star {

  PVector position;
  PVector velocity;

  int starSize = 1;

  int fallingStarChance = int(random(100));

  Star(PVector position) {
    this.position = position;

    if (fallingStarChance < 99)
      return;

    position.y = random(-100, -200);
    velocity = new PVector(random(-1, 1), random(2, 5));
  }

  void update() {
    if (fallingStarChance < 99)
      return;
      
      if (position.y > height + starSize || position.x - starSize < 0 || position.x + starSize > width) {
       reset();
      }
      
      position.add(velocity);
  }

  void display() {
    strokeWeight(4);
    stroke(255);
    point(position.x, position.y);
    
    if (fallingStarChance < 99)
    return;
    
    stroke(255, 100);
    line(position.x, position.y, position.x - velocity.x * 3, position.y - velocity.y * 3);
  }
  
  void reset() {
   position.set(random(width), random(-100, -200));
   velocity.set(random(-1, 1), random(5, 8));
  }
}
