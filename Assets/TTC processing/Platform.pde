//Made By Lars Nienhuis 500882270 & Daan Schurink

class Platform extends Sprite {

  Platform(PVector position, float w, float h) {
    super(position, w, h); //Use super to forward the vector and 2 floats to this class   
    tag = "platform"; //Insert a tag for collision
    sprite = platformImg; //Insert the right sprite
  }
}
