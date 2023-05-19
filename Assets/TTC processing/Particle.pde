//made by Lars Nienhuis 500882270 && Hugues

class Particle extends Transform {

  float bulletX, bulletY, bulletW, bulletH, speedX, speedY;
  float lifespan; //Is used to determine 1 particles duration and makes it more transparent
  float firstSpeedX, firstSpeedY;

  Particle(PVector position, float w, float h, float rangeLeft, float rangeRight, float rangeUp, float rangeDown) {
    super(position, w, h);
    this.bulletX = position.x;
    this.bulletY = position.y;
    this.bulletW = w;
    this.bulletH = h;

    speedX = random(-rangeRight, rangeLeft); //Set the specific ranges to the speeds
    speedY = random(-rangeUp, rangeDown);

    firstSpeedX = speedX; //Set the firstspeed to speed for resetting
    firstSpeedY = speedY;

    lifespan = random(0, Config.MAX_LIFESPAN); //Set the lifespan of the bullet

    tag = "fireParticle"; //Submit a tag for collision
  }

  void display(Camera camera) {
    noStroke();
    float red = map(lifespan, Config.MAX_LIFESPAN, 0, 255, 30); //Change the bullets color so it starts at red / orange and ends at grey
    float green = map(lifespan, Config.MAX_LIFESPAN, 0, 100, 30);
    float blue = map(lifespan, Config.MAX_LIFESPAN, 0, 0, 30);
    float bulletSize = map(lifespan, Config.MAX_LIFESPAN, 0, bulletW, bulletW*4); //Make the bullets bigger the older it is
    fill(red, green, blue, lifespan);
    rect(bulletX - camera.position.x, bulletY - camera.position.y, bulletSize, bulletSize); //Draw the bullet
  }

  void display(Camera camera, color bulletColor, int alpha) { //Add an argument bulletcolor to be able to input a bullet color
    noStroke();
    float bulletSize = map(lifespan, Config.MAX_LIFESPAN, 0, bulletW, bulletW*4); //Make the bullets bigger the older it is
    fill(bulletColor, alpha);
    rect(bulletX - camera.position.x, bulletY - camera.position.y, bulletSize, bulletSize); //Draw the bullet
  }

  void display() { //Make a second display function for the fire on the buttom of the screen. This to make sure it doesn't move with the camera
    noStroke();
    float red = map(lifespan, Config.MAX_LIFESPAN, 0, 255, 30); //Change the bullets color so it starts at red / orange and ends at grey
    float green = map(lifespan, Config.MAX_LIFESPAN, 0, 100, 30);
    float blue = map(lifespan, Config.MAX_LIFESPAN, 0, 0, 30);
    float bulletSize = map(lifespan, Config.MAX_LIFESPAN, 0, bulletW, bulletW*4);//Make the bullets bigger the older it is
    fill(red, green, blue, lifespan);
    rect(bulletX, bulletY, bulletSize, bulletSize);//Draw the bullet
  }

  //Makes the bullet move
  void update() {
    speedX *= Config.BULLET_X_SLOWDOWN; //Always update all bullet variables
    speedY *= Config.BULLET_Y_SLOWDOWN;
    bulletY  += speedY;
    bulletX += speedX;
    lifespan -= Config.LIFESPAN_DECREASE_SPEED;
  }

  void reset(PVector positions) { //Reset the button to a set position and with the standard variables
    bulletX = positions.x;
    bulletY = positions.y;
    lifespan = Config.MAX_LIFESPAN;
    speedX = firstSpeedX;
    speedY = firstSpeedY;
  }
}
