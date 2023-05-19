//Made by Robin Schellingerhout
class TileFactory {
  TileType type = TileType.base;
  boolean elevator = false;
  float elevatorChance = random(0, 100);
  
  public Tile getTile(PVector position, int w, int h, int difficulty, Tile tileBeneath) {
    float chance = random(0, 100);
    boolean platform = false;
    float platformChance = random(0, 100);

    if (chance <= remap(difficulty, 1, 10, 10, 3)) {
      type = TileType.nasty;
    } else if (chance < remap(difficulty, 1, 10, 15, 28) && difficulty > 0) {
      type = TileType.cracked;
    } else if (chance < remap(difficulty, 1, 10, 16.5, 29) && difficulty > 1) {
      type = TileType.elevatorShaft;
    } else {
      type = TileType.base;
    }

    if (platformChance < remap(difficulty, 1, 10, 50, 20)) {
      platform = true;
    }

    switch (type) {
    case base: 
      return new Tile(position, w, h, platform, tileBeneath);
    case nasty:
      return new NastyTile(position, w, h, true, tileBeneath);
    case cracked:
      return new CrackedTile(position, w, h, platform, tileBeneath);
    case elevatorShaft:
      return new ElevatorShaft(position, w, h, false, tileBeneath);
    default:
      return null;
    }
  }
}

public enum TileType {
  base, 
    nasty, 
    cracked, 
    elevatorShaft
}
