//Made by Robin Schellingerhout
class PlayerRunState extends PlayerBaseState {

  PlayerRunState(Player currentContext, PlayerStateFactory playerStateFactory) {
    super(currentContext, playerStateFactory);
  }

  void enterState() {
    context.setActiveAnimation("run" + context.directionText);
    context.animationState = "run";
  }
  void updateState() {
    if (context.animationState != "run" && context.isGrounded) {
      context.setActiveAnimation("run" + context.directionText);
      context.animationState = "run";
    }
    checkSwitchState();
    handleMovement(1);
  }
  void exitState() {
  }
  void checkSwitchState() {
    if ((!keysPressed[LEFT] && !keysPressed[RIGHT]) || (keysPressed[LEFT] && keysPressed[RIGHT])) {
      switchState(factory.idle());
    }
  }
  void initializeSubstate() {
  }
}
