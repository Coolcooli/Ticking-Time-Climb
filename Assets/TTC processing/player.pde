//Made By Lars Nienhuis 500882270 && Robin Schellingerhout
class Player extends AnimatedSprite {
  ParticleSystem landParticle;
  ParticleSystem gunParticle;
  ParticleSystem poopParticle;

  PVector velocity; //declare the starting position and the movement speed of the player
  boolean isGrounded; //declare a boolean to check if the player is on a platform
  boolean lastIsGrounded;
  int previousDirection;
  String directionText;
  float stamina;
  boolean allowCollision = true;
  boolean canClean = true;
  boolean playLandingSound = true;
  boolean drawStaminaError = false;
  Timer collisionTimer = new Timer(0);
  PlayerBaseState currentState;
  PlayerStateFactory states;
  boolean dead = false;
  boolean allowMovement = true;

  Timer landParticleTimer = new Timer(0);
  boolean showLandParticle = false;  
  PVector landParticleLocation;
  int landAlpha;
  
  Timer poopParticleTimer = new Timer(0);
  boolean showPoopParticle = false;
  PVector poopPosition;

  Player(PVector position, float w, float h) {
    super(position, w, h); //use super to forward the vector and 2 floats to this class

    //setting the vectors to their starting positions and speed
    velocity = new PVector(0, 0);

    tag = "player";

    addAnimation("Player/Gunner_Blue_Idle_Right-export", 4, "idleRight"); //Insert all of the animations
    addAnimation("Player/Gunner_Blue_Idle_Left-export", 4, "idleLeft");
    addAnimation("Player/Gunner_Blue_Jump_Right-export", 2, "jumpRight");
    addAnimation("Player/Gunner_Blue_Jump_Left-export", 2, "jumpLeft");
    addAnimation("Player/Gunner_Blue_Run_right-export", 6, "runRight");
    addAnimation("Player/Gunner_Blue_Run_left-export", 6, "runLeft");
    addAnimation("Player/Gunner_Blue_Clean_Left-export", 6, "cleanLeft");
    addAnimation("Player/Gunner_Blue_Clean_Right-export", 6, "cleanRight");
    addAnimation("Player/Gunner_Blue_Sweat_Left-export", 4, "sweatLeft");
    addAnimation("Player/Gunner_Blue_Sweat_Right-export", 4, "sweatRight");
    addAnimation("Player/Gunner_Blue_Death-Left-export", 8, "deathLeft");
    addAnimation("Player/Gunner_Blue_Death-Right-export", 8, "deathRight");
    setActiveAnimation("idleRight");
    animationSpeed = 0.2f;

    directionText = "Right"; //Set the first animation
    animationState = "idle";

    states = new PlayerStateFactory(this);
    currentState = states.grounded(); //Set the first state
    currentState.enterState();

    landParticle = new ParticleSystem();
    landParticle.initialize(new PVector(position.x + w/2, position.y + h), Config.BULLET_SIZE/2.5, 3, 3, .5, 0); //Initialize a landing particle
    gunParticle = new ParticleSystem();
    gunParticle.initialize(new PVector(position.x + w/2, position.y + h/2), Config.BULLET_SIZE/2.5, .5, .5, 0, 2); //Initialize a waterparticle for the gun
    landParticleLocation = position;
    landAlpha = 255;
    poopPosition = new PVector(position.x + w/2, position.y);
    poopParticle = new ParticleSystem();
    poopParticle.initialize(poopPosition, Config.BULLET_SIZE/1.5, 3, 3, 3, 3);
  }

  void update() {
    currentState.updateStates(); //Update all functions
    resolveWallCollision();
    letSoundPlay();
    checkStamina();
    letPlayerSweat();
    letPlayerClean();
    updateLandParticle();
    updatePoopParticle();
    
    position.add(velocity); //Always add the velocity to the player


    if (!allowCollision) {
      collisionTimer.init();
      collisionTimer.update();
      if (collisionTimer.time > .2) {
        collisionTimer.end();
        allowCollision = true;
      }
    }
    lastIsGrounded = isGrounded;
    isGrounded = false;
  }

  void display(Camera camera) {
    displayLandParticle(camera);
    displayPoopParticle(camera);
    super.display(camera); //display the player and landparticle
    displayStamina(camera);
  }

  void resolvePlatformCollision(Transform collider) {  //If the player has collision with a platform the boolean isGrounded becomes true and the position is set ontop of the platform
    if (allowCollision) {
      if (playLandingSound) landing.play();
      isGrounded = true;
      position.set(position.x, collider.position.y - h);
      playLandingSound = false;
    }
  }

  void resolveWallCollision() { //Make sure the player can't move out of the map
    if (position.x <= 0) {
      velocity.set(0, velocity.y);
      position.x = 0;
    }
    if (position.x >= width - w) {
      velocity.set(0, velocity.y);
      position.x = width - w;
    }
  }

  void die() {
    if (!dead) {
      dead = true;
      currentState = states.die();
      currentState.enterState();
      allowMovement = false;
    }
  }

  void letSoundPlay() {
    if (!isGrounded) {
      playLandingSound = true; //Play the landing sound if the player lands
    }
  }

  void checkStamina() {
    if (keysPressed['Z'] != keysPrevious['Z'] && keysPressed['Z'] && stamina < Config.STAMINA_JUMP_COST && isGrounded) {
      drawStaminaError = true; //Draw the stamina error
    }
    if (stamina >= 5) {
      drawStaminaError = false;
    }
  }

  void letPlayerSweat() {
    if (drawStaminaError && keysPressed['Z'] != keysPrevious['Z'] && keysPressed['Z']) {
      setActiveAnimation("sweat" + directionText); //Set the animation to the sweating animation
      animationState = "sweat";
    } 
    if (!drawStaminaError && animationState == "sweat") {
      setActiveAnimation("idle" + directionText);
      animationState = "idle";
    }
  }

  void letPlayerClean() {
    if (abs(velocity.x) > 0) {
      canClean = true;
    }
  }

  void updateLandParticle() {
    if (lastIsGrounded != isGrounded && isGrounded && stamina >= 5) {
      showLandParticle = true;
      landParticleLocation = position.copy();
      landParticle.resetNow(new PVector(landParticleLocation.x + w/2, landParticleLocation.y + h), .2);
      if (directionText == "Right") gunParticle.resetNow(new PVector(landParticleLocation.x + w, landParticleLocation.y + h/2 - 8), .05);
      if (directionText == "Left") gunParticle.resetNow(new PVector(landParticleLocation.x - 5, landParticleLocation.y + h/2 - 8), .05); //Update the particles at the right place
    }

    if (showLandParticle) { //Update the landparticletimer
      landParticleTimer.init();
      landParticleTimer.update();
      landAlpha -= 10;
    }

    landParticle.update();
    gunParticle.update();

    if (landParticleTimer.time > .2) {
      landParticleTimer.end(); //If the timer has finished stop showing the particles
      showLandParticle = false;
      landAlpha = 255;
    }
  }

  void displayLandParticle(Camera camera) {
    if (showLandParticle) {
      landParticle.display(camera, #C9C9C9, 0.2, landAlpha);
      gunParticle.display(camera, color(0, 0, 255), .05, 255);
    }
  }
  
  void displayStamina(Camera camera) {
    float r = remap(stamina, 60, 100, 222, 87);
    float g = remap(stamina, 60, 100, 112, 222);
    float b = remap(stamina, 60, 100, 87, 127);
    float a = remap(stamina, 80, 100, 255, 0);

    noStroke();
    fill(r, g, b, a);
    rect(position.x + 80 - camera.position.x, position.y + h - camera.position.y, 10, remap(stamina, 0, 100, 0, -60)); //Draw the stamina bar
  }

  void updatePoopParticle() {
    if (!showPoopParticle) return;

    poopParticleTimer.init();
    poopParticleTimer.update();

    poopPosition.set(new PVector(position.x + w/2, position.y));
    poopParticle.reset(poopPosition);
    poopParticle.update();

    if (poopParticleTimer.time > .3) {
      showPoopParticle = false;
      poopParticleTimer.reset();
    }
  }

  void displayPoopParticle(Camera camera) {
    if (!showPoopParticle) return;

    poopParticle.display(camera, color(255), .5, 255);
  }
}
