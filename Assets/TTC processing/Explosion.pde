//Made by Lars Nienhuis 500882270

class Explosion extends AnimatedSprite {

  Explosion(PVector position, float w, float h) {
    super(position, w, h);
    this.position = position;

    addAnimation("Background/Explosion", 6, "Explosion");
    animationSpeed = 0.2f;
  }

  void display() {
    if (currentAnimation != null)
      super.display();
  }

  void getNewSize(float size) {
    w = size;
    h = size;
  }

  void setLocation(PVector position2) {
    position = new PVector(position2.x - w/4, position2.y - w/4);
    setActiveAnimation("Explosion");
  }
}
