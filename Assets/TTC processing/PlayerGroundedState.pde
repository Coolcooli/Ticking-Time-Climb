//Made by Robin Schellingerhout
class PlayerGroundedState extends PlayerBaseState {

  PlayerGroundedState(Player currentContext, PlayerStateFactory playerStateFactory) {
    super(currentContext, playerStateFactory);
    isRootState = true;
    initializeSubstate();
  }

  void enterState() {
    context.velocity = new PVector(0, 0);
    context.animationState = "idle";
  }
  void updateState() {
    checkSwitchState();
  }
  void exitState() {
  }
  void checkSwitchState() {
    if ((keysPressed['Z'] != keysPrevious['Z'] && keysPressed['Z'] && context.stamina >= 5) || !context.isGrounded) {
      switchState(factory.jump());
    }
    if ((keysPressed['A']!= keysPrevious['A'] && keysPressed['A']) || (keysPressed['S']!= keysPrevious['S'] && keysPressed['S'])) {
      switchState(factory.clean());
    }
  }
  void initializeSubstate() {
    if (!keysPressed[LEFT] && !keysPressed[RIGHT]) {
      setSubState(factory.idle());
    } else if (keysPressed[LEFT] || keysPressed[RIGHT]) {
      setSubState(factory.run());
    }
  }
}
