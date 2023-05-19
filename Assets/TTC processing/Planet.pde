//Made by Lars Nienhuis 500882270

class Planet {

  Explosion explosion;
  Timer explosionTimer;

  PVector position;
  PVector velocity;
  float planetSize;
  int planet;
  boolean collide = false;

  Planet(PVector position, PVector velocity, float w, int planet) {
    this.position = position;
    this.velocity = velocity;
    this.planetSize = w;
    this.planet = planet;

    explosion = new Explosion((new PVector(position.x - planetSize/2, position.y - planetSize/2)), w*2, w*2);

    velocity.x /= 2;
    velocity.y /= 2;

    explosionTimer = new Timer(0);
  }

  void update() {
    if (collide) {
      explosionTimer.init();
      explosionTimer.update();

      if (explosionTimer.time >= (explosion.animationSpeed * 5)) {
        collide = false;
        explosion.currentAnimation = null;
        explosionTimer.end();
      }
    }

    checkExplosionAnimation();

    if (position.x + planetSize < 0 || position.x > width || position.y + planetSize < 0 || position.y > height) {
      reset();
    }

    position.add(velocity);
  }

  void display() {
    noStroke();
    image(planetImgs[planet], position.x, position.y, planetSize, planetSize);

    if (collide) {
      explosion.display();
    }
  }

  void reset() {
    explosion.setLocation(position);

    position = new PVector(random(width), random(height));
    velocity = new PVector(random(-2, 2), random(-2, 2));
    planetSize = random(40, 120);
    planet = int(random(7));

    velocity.x /= 2;
    velocity.y /= 2;

    explosion.getNewSize(planetSize*2);
  }

  void checkExplosionAnimation() {
    if (explosion.frame >= 5 && collide) {
      collide = false;
    }
  }
}
