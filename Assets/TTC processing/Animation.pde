//Made By Robin Schellingerhout
class Animation {
  PImage[] images;
  int imageCount;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + nf(i, 3) + ".png";
      images[i] = loadImage(filename);
    }
  }
}
