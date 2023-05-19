//Code from Kevin Kroon 500855487 && Lars Nienhuis 500882270 && Robin Schellingerhout
//NastyTile and CrackedTile have a dependency on this code
class Tile extends AnimatedSprite
{
  boolean hasPlatform;
  Platform platform;

  Tile tileBeneath;
  
  int glassPiecesX = 10;
  int glassPiecesY = 14;
  
  GlassPiece[][] glassPieces = new GlassPiece[glassPiecesX][glassPiecesY];

  ParticleSystem[] fireParticle = new ParticleSystem[3];
  PVector newPosition;
  boolean onFire = false;

  Tile(PVector position, int w, int h, boolean hasPlatform, Tile tileBeneath)
  {
    super(position, w, h);
    this.hasPlatform = hasPlatform;
    this.tileBeneath = tileBeneath;

    tag = "tile";
    addAnimation(staticWindow, "base");
    setActiveAnimation("base");

    for (int iX = 0; iX < glassPiecesX; iX++) {
      for (int iY = 0; iY < glassPiecesY; iY++) {
        glassPieces[iX][iY] = new GlassPiece(new PVector(position.x + (iX * w/glassPiecesX), position.y + (iY * h/glassPiecesY)), w/glassPiecesX, h/glassPiecesY);
      }
    }

    if (hasPlatform) {
      initPlatform();
    }
    initParticleSystem();
  }

  void setTileBeneath(Tile tileBeneath) {
    this.tileBeneath = tileBeneath;
  }

  void initPlatform() {
    platform = new Platform(new PVector(position.x, position.y + h - Config.PLATFORM_H/2), w, Config.PLATFORM_H);
  }

  void initParticleSystem() {
    for (int i = 0; i < fireParticle.length; i++) {
      fireParticle[i] = new ParticleSystem();
      fireParticle[i].initialize(new PVector(position.x+random(w), position.y + random(h)), Config.BULLET_SIZE, Config.PARTICLESYSTEM_X_RADIUS, Config.PARTICLESYSTEM_X_RADIUS, Config.TILE_BULLET_Y_RADIUS, 0);
    }
  }

  void display(Camera camera) //normal tile details
  {
    super.display(camera);

    drawFireParticleSystem(camera);

    if (onFire) {
      for (int iX = 0; iX < glassPiecesX; iX++) {
        for (int iY = 0; iY < glassPiecesY; iY++) {
          glassPieces[iX][iY].display(camera);
        }
      }
    }

    if (platform == null || !hasPlatform)
      return;

    platform.display(camera);
  }

  void update() {
    updateFireParticleSystem();

    if (onFire) {
      for (int iX = 0; iX < glassPiecesX; iX++) {
        for (int iY = 0; iY < glassPiecesY; iY++) {
          glassPieces[iX][iY].update();
        }
      }
    }
  }

  void shatter() {//the tile breaks and becomes red
    tag = "fireTile";
    onFire = true;
  }

  void drawFireParticleSystem(Camera camera) {
    if (onFire) {
      for (int i = 0; i < fireParticle.length; i++) {
        fireParticle[i].display(camera); //Draw the fire particles
      }
    }
  }

  void updateFireParticleSystem() {
    if (!paused && onFire) {
      for (int i = 0; i < fireParticle.length; i++) {
        fireParticle[i].reset(new PVector(position.x + random(w), position.y + random(h)));
        fireParticle[i].update(); //Update the fire particles
      }
    }
  }
}

class GlassPiece extends Transform {
  PVector velocity;

  GlassPiece(PVector position, float w, float h) { 
    super(position, w, h);

    velocity = new PVector(random(-5, 5), random(-5, 5));
  }

  void display(Camera camera) {
    fill(94, 180, 198, 89);
    rect(position.x - camera.position.x, position.y - camera.position.y, w, h);
  }

  void update() {
    velocity.x = lerp(velocity.x, 0, 0.1f);
    velocity.y = constrain(velocity.y, -5, 5);
    velocity.add(new PVector(0, Config.GRAVITY));
    position.add(velocity);
  }
}
