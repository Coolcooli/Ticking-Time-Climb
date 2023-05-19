//Made by Lars Nienhuis 500882270
class ElevatorShaft extends Tile {
  Elevator elevator;
  int levels;

  ElevatorShaft(PVector position, int w, int h, boolean hasPlatform, Tile tileBeneath) {
    super(position, w, h, hasPlatform, tileBeneath);    
    tintColor = color(255, 255, 255); //Set a clear tintcolor

    if (tileBeneath != null) {
      if (tileBeneath.tag != "elevatorShaft") {
        levels = (int)random(Config.MIN_LEVELS, Config.MAX_LEVELS); //If there is no shaft below it sets a random value to the length of the elevatorshaft
        elevator = new Elevator(this.position.copy(), this.w, this.h, new PVector(position.x, position.y - h*levels+1)); //Insert an elevator if its the first shaft
      } else {
        ElevatorShaft shaft = (ElevatorShaft)tileBeneath; //If there is a shaft below it removes 1 from the total elevatorshafts
        levels = shaft.levels - 1;
        elevator = shaft.elevator;
      }
    }
    addAnimation(staticElevator, "base"); //Set the sprite for elevator
    setActiveAnimation("base");
    tag = "elevatorShaft"; //Enter a tag for collision
  }

  void display(Camera camera) {
    super.display(camera); //Display the shaft

    if (elevator == null)
      return;

    elevator.display(camera); //If there is an elevator draw the elevator
  }

  void update() {
    super.hasPlatform = false; //Make sure there are no platforms in the shaft
    if (elevator == null)
      return;

    elevator.update(); //Display the elvator if not null
  }
}
