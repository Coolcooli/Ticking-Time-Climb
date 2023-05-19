//Made By Lars Nienhuis 500882270

class LowerBuilding extends Sprite {

  ParticleSystem[] particleSystemFire; //Declare an array of particlesystems
  PVector[] particleLocation;

  PVector position;
  float w, h;

  LowerBuilding(PVector position, float w, float h) {
    super(position, w, h);
    this.position = position;
    this.w = w;
    this.h = h;

    particleSystemFire = new ParticleSystem[Config.AMOUNT_OF_LOWERBUILDING_PARTICLESYSTEMS]; //Set the length of the system
    particleLocation = new PVector[Config.AMOUNT_OF_LOWERBUILDING_PARTICLESYSTEMS];

    sprite = lowerBuildingImg; //Insert the right sprite

    tag = "lowerBuilding"; //Insert a tag for collision
  }
  void update(Camera camera) { //Update all functions
    updateParticleSystem(camera);
  }

  void display(Camera camera) {
    if (camera.position.y >= -height) { //Only draw if the player is close to the lowerbuilding
      super.display(camera); //Draw the building, sidewalk, and particlesystems
      image(sidewalkImg, 0, position.y + h - camera.position.y, width, Config.SIDEWALK_H); 
      drawParticleSystem(camera);
    }
  }

  void initParticleSystem() { //Initialize all particle systems on a random location in the building
    for (int i = 0; i < particleSystemFire.length; i++) {
      particleSystemFire[i] = new ParticleSystem();
      particleLocation[i] = new PVector(random(position.x, position.x + w), 
        random(position.y, position.y + h));
      particleSystemFire[i].initialize(particleLocation[i], Config.BULLET_SIZE, Config.PARTICLESYSTEM_X_RADIUS, Config.PARTICLESYSTEM_X_RADIUS, Config.LOWERBUILDING_BULLET_Y_RADIUS, 0);
    }
  }

  void updateParticleSystem(Camera camera) { //Update the particlesystem
    if (camera.position.y >= -700) { //Only update lowerbuilding if the player is close
      if (!paused && particleSystemFire[particleSystemFire.length-1] != null) {
        for (int i = 0; i < particleSystemFire.length; i++) {
          particleSystemFire[i].reset(new PVector(random(position.x, position.x + w), 
            random(position.y, position.y + h))
          );
          particleSystemFire[i].update();
        }
      }
    }
  }

  void drawParticleSystem(Camera camera) { //Draw the particlesystem
    if (particleSystemFire[particleSystemFire.length-1] != null) {
      for (int i = 0; i < particleSystemFire.length; i++) {
        particleSystemFire[i].display(camera);
      }
    }
  }
}
