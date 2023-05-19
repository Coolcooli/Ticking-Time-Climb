//Made By Lars Nienhuis 500882270
class PlayerCleanState extends PlayerBaseState {

  Timer cleanTimer;
  boolean hasCleaned = false;

  PlayerCleanState(Player currentContext, PlayerStateFactory playerStateFactory) {
    super(currentContext, playerStateFactory);
    isRootState = true;
    cleanTimer = new Timer(0);
    cleanTimer.init();
  }

  void enterState() {
    context.setActiveAnimation("clean" + context.directionText); //Set the animation to the cleaning animation
    context.animationState = "clean";
  }

  void updateState() {
    context.velocity = new PVector(0, 0);
    checkSwitchState();
    cleanTimer.update();
  }

  void exitState() {
    context.setActiveAnimation("idle" + context.directionText); //If you exit this state the animation becomes idle
    context.animationState = "idle";
    if (hasCleaned) {
      context.stamina += 40;
      if (context.stamina > 100) context.stamina = 100;
    }
    hasCleaned = false;
  }

  void checkSwitchState() {
    if (cleanTimer.time > Config.CLEAN_TIME) {
      cleanTimer.end();
      hasCleaned = true;
      switchState(factory.grounded()); //If the timer is over the clean time it exits this state
    }
    if (keysPressed[LEFT] || keysPressed[RIGHT]) {
      switchState(factory.grounded());
    }
    if (keysPressed['Z'] != keysPrevious['Z'] && keysPressed['Z']) {
      switchState(factory.jump());
    }
  }

  void initializeSubstate() {
  }
}
