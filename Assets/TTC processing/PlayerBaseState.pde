//By Robin Schellingerhout
abstract class PlayerBaseState {

  boolean isRootState = false;
  Player context;
  PlayerStateFactory factory;

  PlayerBaseState currentSuperState;
  PlayerBaseState currentSubState;

  PlayerBaseState(Player currentContext, PlayerStateFactory playerStateFactory) {
    context = currentContext;
    factory = playerStateFactory;
  }

  abstract void enterState();
  abstract void updateState();
  abstract void exitState();
  abstract void checkSwitchState();
  abstract void initializeSubstate();

  void updateStates() {
    updateState();
    if (currentSubState != null) {
      currentSubState.updateState();
    }
    
    if (!context.allowMovement) return;
    
    if (keysPressed[LEFT] != keysPrevious[LEFT] && keysPressed[LEFT]) { //If the left arrow is pressed the animation changes to the player moving left
      context.directionText = "Left";
      context.setActiveAnimation(context.animationState + context.directionText);
    } else if (keysPressed[RIGHT] != keysPrevious[RIGHT] && keysPressed[RIGHT]) { //If the right arrow is pressed the animation changes to the player moving right
      context.directionText = "Right";
      context.setActiveAnimation(context.animationState + context.directionText);
    }
  }

  void switchState(PlayerBaseState newState) {
    exitState();

    newState.enterState();

    if (isRootState) {
      context.currentState = newState;
    } else if (currentSuperState != null) {
      currentSuperState.setSubState(newState);
    }
  }
  void setSuperState(PlayerBaseState newSuperState) {
    currentSuperState = newSuperState;
  }
  void setSubState(PlayerBaseState newSubState) {
    currentSubState = newSubState;
    newSubState.setSuperState(this);
  }

  void handleMovement(float multiplier) {
    //making sure the player is able to move with the arrows
    if ((abs(context.velocity.x) > Config.TOPSPEED) || (keysPressed[LEFT] && keysPressed[RIGHT]))
      return;

    if (keysPressed[LEFT]) {
      context.velocity.sub(Config.MOVEMENTSPEED * multiplier, 0);
    } else if (keysPressed[RIGHT]) {
      context.velocity.add(Config.MOVEMENTSPEED * multiplier, 0);
    }
  }
}
