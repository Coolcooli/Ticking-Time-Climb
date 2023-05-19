//Made by Lars Nienhuis 500882270 && Robin Schellingerhout

class Elevator extends Sprite {

  float w, h;
  PVector destination;

  boolean isMoving = false;

  Elevator(PVector position, float w, float h, PVector destination) {
    super(position, w, h);
    this.destination = destination;

    tag = "elevator"; //Give the object a tag for collision
    sprite = elevatorImg; //Insert the right sprite
  }

  void startMove() {
    if(!isMoving) {
      elevatorsUsed++;
    }
    isMoving = true;
  }

  void update() {
    if (isMoving) {
      if (position.y > destination.y) {
        position.y += Config.ELEVATOR_MOVEMENT_SPEED; //let the elevator move to a certain place if isMoving is true
      }
    }
  }
}
