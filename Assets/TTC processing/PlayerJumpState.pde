//Made by Robin Schellingerhout
class PlayerJumpState extends PlayerBaseState {

  PlayerJumpState(Player currentContext, PlayerStateFactory playerStateFactory) {
    super(currentContext, playerStateFactory);
    isRootState = true;
    initializeSubstate();
  }

  void enterState() {
    if (keysPressed['Z'] && context.stamina >= Config.STAMINA_JUMP_COST) {
      context.setActiveAnimation("jump" + context.directionText);
      context.animationState = "jump";
      handleJump();
      context.stamina -= Config.STAMINA_JUMP_COST;
      
      jumps++;
    }
    context.isGrounded = false;
  }
  void updateState() {
    checkSwitchState();
    handleGravity();
    handleMovement(0.5);
    context.velocity.set(lerp(context.velocity.x, 0, 0.05f), context.velocity.y);
  }
  void exitState() {
    context.setActiveAnimation("idle" + context.directionText);
    context.animationState = "idle";
  }
  void checkSwitchState() {
    if (context.isGrounded) {
      switchState(factory.grounded());
    }
  }
  void initializeSubstate() {
  }

  void handleJump() {
    context.velocity.add(0, Config.JUMPSPEED);
  }

  void handleGravity() {
    context.velocity.add(0, Config.GRAVITY);
  }
}
