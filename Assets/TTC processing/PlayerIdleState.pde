//Made by Robin Schellingerhout
class PlayerIdleState extends PlayerBaseState {
  
  Timer staminaTimer = new Timer(0);

  PlayerIdleState(Player currentContext, PlayerStateFactory playerStateFactory) {
    super(currentContext, playerStateFactory);
  }

  void enterState() {
    context.setActiveAnimation("idle" + context.directionText);
    context.animationState = "idle";
    context.velocity = new PVector(0, 0);
  }
  
  void updateState() {
    checkSwitchState();
    replenishStamina();
  }
  
  void exitState() {
    staminaTimer.end();
  }
  
  void checkSwitchState() {
    if ((keysPressed[LEFT] || keysPressed[RIGHT]) && !(keysPressed[LEFT] && keysPressed[RIGHT])) {
      switchState(factory.run());
    }
  }
  
  void initializeSubstate() {
  }

  void replenishStamina() {
    if (staminaTimer.time <= 0) staminaTimer.init();
    staminaTimer.update();

    if (staminaTimer.time > 1 && context.stamina < Config.MAX_STAMINA) {
      context.stamina += 0.5;
    }
  }
}
