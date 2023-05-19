//Made by Robin Schellingerhout
class PlayerStateFactory {
  Player context;

  PlayerStateFactory(Player currentContext) {
    context = currentContext;
  }

  PlayerBaseState idle() {
    return new PlayerIdleState(context, this);
  }
  PlayerBaseState run() {
    return new PlayerRunState(context, this);
  }
  PlayerBaseState jump() {
    return new PlayerJumpState(context, this);
  }
  PlayerBaseState grounded() {
    return new PlayerGroundedState(context, this);
  }
  PlayerBaseState clean() {
    return new PlayerCleanState(context, this);
  }
  PlayerBaseState die() {
    return new PlayerDieState(context, this);
  }
}
