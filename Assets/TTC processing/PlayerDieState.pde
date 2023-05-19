//Made By Lars Nienhuis 500882270
class PlayerDieState extends PlayerBaseState {

  PlayerDieState(Player currentContext, PlayerStateFactory playerStateFactory) {
    super(currentContext, playerStateFactory);
    isRootState = true;
  }

  void enterState() {
    context.velocity.set(0, 0);
    context.w = 117;
    context.animationState = "death";
    context.setActiveAnimation("death" + context.directionText); //Set the animation to the die animation
  }

  void updateState() {
    if (context.frame >= context.currentAnimation.images.length - 1) {
      switchScene(Config.GAMEOVERSCENE); 
    }
  }

  void exitState() {
  }

  void checkSwitchState() {
  }

  void initializeSubstate() {
  }
}
