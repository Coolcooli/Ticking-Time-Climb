//Made by Lars Nienhuis 500882270 && Hugues
class ParticleSystem {
  final int NFIREBULLETS = 50; //Use 50 bullets for each particlesystem
  Particle[] bullets = new Particle[NFIREBULLETS]; //Make an array of bullets

  void initialize(PVector position, float bulletSize, float fireRadiusLeft, float fireRadiusRight, float fireRadiusUp, float fireRadiusDown) { //Initialize all buttons on the given position and with the specific ranges
    for (int i = 0; i < bullets.length; i++) {
      bullets[i] = new Particle(position, bulletSize, bulletSize, fireRadiusLeft, fireRadiusRight, fireRadiusUp, fireRadiusDown);
    }
  }

  void update() { //Update all bullets
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].update();
    }
  }

  void display(Camera camera) { //Draw all bullets moving with the camera
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].display(camera);
    }
  }

  void display(Camera camera, color bulletColor, float bulletAmount, int alpha) { //Draw all bullets moving with the camera, being able to give a bulletcolor, amount, and an alpha value
    for (int i = 0; i < bullets.length * bulletAmount; i++) {
      bullets[i].display(camera, bulletColor, alpha);
    }
  }

  void display() { //Draw all not moving particlesystems
    for (int i = 0; i < bullets.length; i++) {
      bullets[i].display();
    }
  }

  void reset(PVector position) { //Reset the bullet if the lifespan is below 0
    for (int i = 0; i < NFIREBULLETS; i++) {
      if (bullets[i].lifespan < 0) {
        bullets[i].reset(position);
      }
    }
  }

  void resetNow(PVector position, float bulletAmount) { //Reset the bullet if the lifespan is below 0
    for (int i = 0; i < NFIREBULLETS * bulletAmount; i++) {
      bullets[i].reset(position);
    }
  }
}
