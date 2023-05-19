//Code from Kevin Kroon 500855487
class CrackedTile extends Tile {

  CrackedTile(PVector position, int w, int h, boolean hasPlatform, Tile tileBeneath) {
    super(position, w, h, hasPlatform, tileBeneath);

    addAnimation(windowShatter, "shatter");
    setActiveAnimation("shatter");
    animationSpeed = 2f;

    tag = "crackedTile";
  }

  void display(Camera camera) {
    super.display(camera);
  }

  void update() {
    super.update();
    if (frame >= currentAnimation.images.length - 1) {
      animate = false;
      shatter();
    }
  }
}
