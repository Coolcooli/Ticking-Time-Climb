//Made By Lars Nienhuis 500882270  Hugues

class Background extends Sprite {
  HighBackground highBg;
  PGraphics buildingImage;

  BackgroundBuilding[] buildings = new BackgroundBuilding[Config.BUILDINGAMOUNT];
  int[] buildingPos = new int[Config.BUILDINGAMOUNT];
  Cloud[] clouds = new Cloud[Config.CLOUDSAMOUNT];
  Cloud[] fog = new Cloud[Config.FOGAMOUNT];

  int fogSize;

  PVector position2; //Declaring variables
  float lastPlayerY;
  float playerY;

  boolean night;

  Background(PVector position, float w, float h, int night) {
    super(position, w, h); //Use super to forward the vector and 2 floats to this class
    position2 = new PVector(0, 0); //Setting the position for the second background

    highBg = new HighBackground(position2);

    for (int i = 0; i < Config.BUILDINGAMOUNT; i++) {     //This makes it that the buildings will be random selected between the 2 versions below
      if (random(1) > 0.5) {
        buildings[i] = new BackgroundBuilding(windowToneVone, windowToneVtwo, (int)random(width), (int)random(6, 10), i);
      } else {
        buildings[i] = new BackgroundBuilding(windowTtwoVone, windowTtwoVtwo, (int)random(width), (int)random(6, 13), i);
      }
    }

    buildingImage = createGraphics(width, height);
    buildingImage.beginDraw();
    if (night == 1) {
      buildingImage.background(69, 132, 237);
      for (int i = 0; i < Config.CLOUDSAMOUNT; i++) {
        clouds[i] = new Cloud(random(width), random(0, 200), 50, 50, 255, 255);
        clouds[i].display(buildingImage);
      }
    } else if (night == 2) {
     this.night = true; 
    }

    for (int i = 0; i < Config.BUILDINGAMOUNT; i++) {
      buildings[i].display(buildingImage);
    }

    if ( random(1) > 0.6) {   //Here I determine if there will be fog in this instance
      fogSize = (int)random(150, 450); //Randomizes the size of the fog
      fog[0] = new Cloud(0, height-40, fogSize, fogSize, 175, 30);
      fog[0].display(buildingImage);
      for (int i = 1; i < Config.FOGAMOUNT; i++) {
        fog[i] = new Cloud(fog[i-1].cloudX + 150, fog[i-1].cloudY, fogSize, fogSize, 175, 30);
        fog[i].display(buildingImage);
      }
    }
  }

  void update(Player player) { 
    if (!night) return;
    playerY = player.position.y;
    position.add(0, -(player.position.y - lastPlayerY) * Config.BACKGROUND_SPEED);  //Move the background based on the distance travelled each frame
    position2.add(0, -(player.position.y - lastPlayerY) * Config.BACKGROUND_SPEED); 
    lastPlayerY = playerY;
    
    highBg.update();
  }
  
  void update() { 
    if (!night) return;
    highBg.update();
  }

  void display() {
    if (night) {
      highBg.display();
    }
    image(buildingImage, position.x, position.y);
  }
}
