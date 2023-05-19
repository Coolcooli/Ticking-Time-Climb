//Made By Robin Schellingerhout
class AnimatedSprite extends Transform {
  HashMap <String, Animation> animations = new HashMap<String, Animation>();
  Animation currentAnimation;
  String animationState;
  float animationSpeed;
  boolean animate = true;
  Timer delay = new Timer(0);
  color tintColor = color(255, 255, 255);
  int frame;

  AnimatedSprite(PVector position, float w, float h) {
    super(position, w, h);
    delay.init();
  }

  void setActiveAnimation(String animation) {
    currentAnimation = animations.get(animation);
    delay.reset();

    frame = 0;
  }

  void addAnimation(String imagePrefix, int count, String name) {
    animations.put(name, new Animation(imagePrefix, count));
  }

  void addAnimation(Animation animation, String name) {
    animations.put(name, animation );
  }

  void display(Camera camera) {
    tint(tintColor);
    // goes to the next frame when the timer is past the animation speed
    if (delay.time >= animationSpeed && animate) {
      frame = (frame+1) % currentAnimation.imageCount;
      delay.reset();
    }
    // camera position subtracted so we can use a Camera.
    image(currentAnimation.images[frame], position.x - camera.position.x, position.y - camera.position.y, w, h);
    tint(255, 255, 255);

    delay.update();
  }
  
    void display() {
    tint(tintColor);
    // goes to the next frame when the timer is past the animation speed
    if (delay.time >= animationSpeed && animate) {
      frame = (frame+1) % currentAnimation.imageCount;
      delay.reset();
    }
    // camera position subtracted so we can use a Camera.
    image(currentAnimation.images[frame], position.x, position.y, w, h);
    tint(255, 255, 255);

    delay.update();
  }
}
