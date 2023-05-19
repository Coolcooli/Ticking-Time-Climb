//Made By Lars Nienhuis 500882270 && Robin Schellingerhout

class Sprite extends Transform {
  color tintColor = color(255,255,255);
  PImage sprite;

  Sprite(PVector position, float w, float h) {
    super(position, w, h);
  }

  void display(Camera camera) {
    tint(tintColor); //Set the tintcolor for the sprite
    image(sprite, position.x - camera.position.x, position.y - camera.position.y, w, h); //Draw an image with the given sprite, location, and size
    tint(255, 255, 255); //Set the tintcolor to clear
  }
}
