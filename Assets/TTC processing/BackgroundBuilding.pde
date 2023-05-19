class BackgroundBuilding {

  int nWindowOneX = (int)random(2, 5);
  int nWindowOneY;
  int buildingX;
  PImage imageOne, imageTwo;
  int buildingTint;

  BackgroundBuilding(PImage a, PImage b, int x, int y, int tint) {
    this.buildingX = x;
    this.nWindowOneY = y;
    this.imageOne = a;
    this.imageTwo = b;
    this.buildingTint = tint;
  }

  void display(PGraphics buildingImage) {
    for (int i = 0; i < nWindowOneX + 1; i++) {
      for (int j = 0; j < nWindowOneY + 1; j++) {
        float x = buildingX + (i*imageOne.width);
        float y = height - (j*imageOne.height+nWindowOneY);
        if (random(1) > 0.4) {
          buildingImage.tint(map(buildingTint, 5, Config.BUILDINGAMOUNT, 100, 255));
          buildingImage.image(imageOne, x, y);
        } else {
          buildingImage.tint(map(buildingTint, 5, Config.BUILDINGAMOUNT, 100, 255));
          buildingImage.image(imageTwo, x, y);
        }
        tint(255);
      }
    }
  }
}
