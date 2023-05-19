//Made By Robin Schellingerhout
class BuildingFloor extends Sprite {
  ArrayList<PImage> backgrounds = new ArrayList<PImage>();
  ArrayList<int[]> backgroundNumbers = new ArrayList<int[]>();
  Tile[] tiles;
  int floorWidth;
  int backgroundValue;
  float tileWidth;

  BuildingFloor(PVector position, int w, int h, int tileWidth) {
    super(position, w * tileWidth, h);

    this.floorWidth = w;
    this.backgroundValue = w;
    this.tileWidth = tileWidth;
    tiles = new Tile[w];
    sprite = insideImg;
    tintColor = color(random(0, 255), random(0, 155), random(0, 255)); 

    generateBackground();
  }

  void generateBackground() {
    // every floor has a value for the amount of windows. this generates a array with numbers until they sum to this value. then we use this numbers to get the right size background.
    while (backgroundValue > 0) {
      int[] a = new int[2];
      a[0] = (int)random(2, 5);
      if (backgroundValue < 5) {
        a[0] = backgroundValue;
      } else if (a[0] > backgroundValue) {
        a[0] = (int)random(2, 5);
      }
      if (BACKGROUNDS.get(a[0]).length - 1 > 0) {
        a[1] = 1;
      } else {
        a[1] = 0;
      }
      backgroundValue -= a[0];
      backgroundNumbers.add(a);
    }
  }

  void update() {
    for (int iRow = 0; iRow < floorWidth; iRow++) {
      tiles[iRow].update();
    }
  }

  void display(Camera camera) {
    super.display(camera);
    
    //shows the background of the floor
    int x = 0;
    for (int iRow = 0; iRow < backgroundNumbers.size(); iRow++) {
      image(BACKGROUNDS.get(backgroundNumbers.get(iRow)[0])[backgroundNumbers.get(iRow)[1]], position.x - camera.position.x + (x * tileWidth), position.y - camera.position.y, tileWidth * backgroundNumbers.get(iRow)[0], h);
      x += backgroundNumbers.get(iRow)[0];
    }
    //shows the windows
    for (int iRow = 0; iRow < floorWidth; iRow++) {
      tiles[iRow].display(camera);
    }
  }
}
