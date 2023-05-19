//Code from Kevin Kroon 500855487
class Bird extends AnimatedSprite {
  Poop poop;
  float speed;
  PVector target;
  PVector velocity;
  boolean pooped = false;
  float angle; //45
  float angleVelocity; //0.1

  Bird(PVector position, float w, float h, float angle, float angleVelocity) {
    super(position, w, h);
    this.angle = angle;
    this.angleVelocity = angleVelocity;
    speed = 4;
    velocity = new PVector(speed, 0);

    poop = new Poop(position.copy(), 50, 50, new PVector(0, 3));
    tag = "bird";

    addAnimation("Building/Bird", 7, "Bird");
    setActiveAnimation("Bird");
    animationSpeed = .15f;
  }

  void update() {
    movement();
    pooping();
    poop.update();
  }

  void display(Camera camera) {
    if (camera.position.y < -1700) {
      super.display(camera);
      poop.display(camera);
    }
  }

  void setTarget(PVector target) {
    this.target = target;
  }

  void movement() {
    float amp = 2;
    float birdLike = amp * cos(angle);
    angle += angleVelocity;    
    this.position.add(velocity.x, birdLike);
  }

  void pooping() {
    if (this.position.x > width) {
      //poop.velocity.set(0,0);
      poop.position.set(position);
      pooped = false;
      poop.active = true;
    }
    if (pooped) 
      return;
    float targetDistance = target.x - position.x;
    if (targetDistance <= 4 && targetDistance >= -4) {
      poop.position.set(position);
      pooped = true;
      poop.active = false;
    }
  }
}
