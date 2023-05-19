//Code from Kevin Kroon 500855487
class NastyTile extends Tile
{
  boolean cleanedTile = false;

  //spawns an image with a nasty thing
  //the TileManager will be able to choose the location
  NastyTile(PVector position, int w, int h, boolean hasPlatform, Tile tileBeneath)//NastyTile Constructor
  {
    super(position, w, h, hasPlatform, tileBeneath); //calls baseclass (Tile) constructor
    addAnimation(staticNastyWindow, "base");
    addAnimation(nastyWindowClean, "cleaned");
    setActiveAnimation("base");
    tag = "nastyTile";
    animationSpeed = 0.1f;
  }
  void update() {
    super.update();
    if(frame >= currentAnimation.images.length - 1 && cleanedTile) {
      animate = false;
    }
  }

  //ifthe player stands infront of a nastyTile
  //and pressed the clean button
  //then the getCleaned function will be able to
  //remove the nastyTile from displaying
  void getCleaned()
  {
    setActiveAnimation("cleaned");
    cleanedTile = true;
  }
}
