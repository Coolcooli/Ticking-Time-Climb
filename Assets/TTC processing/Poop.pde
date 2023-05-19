class Poop extends Sprite {  
  PVector velocity;
  boolean active = true;
  
  Poop(PVector position, float w, float h, PVector velocity) {
    super(position, w, h);
    this.velocity = velocity;
    
    tag = "poop";
    
    sprite = poopImg;
  }

  void update() {
    //reset poop to out of screen
    if (active) {
      this.position.set(-100,0);
      this.velocity.add(0, 0);   
    }
    //poop is above player and gets gravity added
    if (!active) {
      this.velocity.add(0,Config.GRAVITY / 2);
      this.position.add(this.velocity);
    }
  }
}
