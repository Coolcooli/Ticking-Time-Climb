//Made By Robin Schellingerhout
class BuildingManager {
  PVector position;
  int w;
  int tileWidth;
  int tileHeight;
  int currentDifficulty = 0;
  boolean fire = false;
  int currentFloorToSetFire = 0;
  int currentFloor = 0;
  Timer fireTimer = new Timer(0);
  int checkPlatforms;
  float fireTime;
  BuildingFloor lastFloor;
  Player player;

  int amountOfBeats;

  ArrayList<BuildingFloor> building = new ArrayList<BuildingFloor>();
  TileFactory tileFactory = new TileFactory();

  BuildingManager(PVector position, int w, int tileWidth, int tileHeight, Player player) {
    this.player = player;
    this.position = position;
    this.w = w;
    this.tileWidth = tileWidth;
    this.tileHeight = tileHeight;
    lastFloor = new BuildingFloor(position, w, tileHeight, tileWidth);
    
    amountOfBeats = 0;
  }

  void init() {
    // generates the first floor with all platforms
    BuildingFloor floor = new BuildingFloor(position, w, tileHeight, tileWidth);
    for (int iRow = 0; iRow < w; iRow++) {
      floor.tiles[iRow] = new Tile(new PVector(iRow * tileWidth + position.x, position.y), tileWidth, tileHeight, true, null);
    }
    building.add(floor);

    for (int i = 0; i < 19; i++) {
      building.add(generateFloor());
      currentFloor++;
    }
  }

  BuildingFloor generateFloor() { //Generates floors
    BuildingFloor floor = new BuildingFloor(new PVector(position.x, building.get(currentFloor).position.y - tileHeight), w, tileHeight, tileWidth);
    for (int iRow = 0; iRow < w; iRow++) {
      floor.tiles[iRow] = tileFactory.getTile(new PVector(iRow * tileWidth + floor.position.x, floor.position.y), tileWidth, tileHeight, currentDifficulty, lastFloor.tiles[iRow]);
      if (lastFloor.tiles[iRow] != null) {
        if (lastFloor.tiles[iRow].tag == "elevatorShaft") {
          ElevatorShaft shaft = (ElevatorShaft)lastFloor.tiles[iRow];
          if (shaft.levels > 0) {
            floor.tiles[iRow] = new ElevatorShaft(new PVector(iRow * tileWidth + position.x, building.get(currentFloor).position.y - tileHeight), tileWidth, tileHeight, false, lastFloor.tiles[iRow]);
            floor.tiles[iRow].hasPlatform = false;
          }
        }
      } 
      if (lastFloor.tiles[iRow] != null) {
        floor.tiles[iRow].setTileBeneath(lastFloor.tiles[iRow]);
      }
    }
    checkFloorPlatformsAndResolve(floor);

    for (int iRow = 0; iRow < w; iRow++) {
      lastFloor.tiles[iRow] = floor.tiles[iRow];
    }
    return floor;
  }

  void update(Camera camera) {
    currentDifficulty = int(scoreCount/200);
    fireTime = remap(currentDifficulty, 1, 10, 2, 1.2);
    
    BuildAndRemoveFloor();

    for (int iFloor = 0; iFloor < building.size(); iFloor++) {
      building.get(iFloor).update();
    }

    if (!fire) 
      return;

    if (fireTimer.time > fireTime) {
      setFire();
      camera.setShake(map(building.get(currentFloorToSetFire).tiles[0].position.y - camera.position.y, 0, Config.SHAKE_DISTANCE, Config.SCREENSHAKE_MAX, Config.SCREENSHAKE_MIN), Config.GAMESCENE_SHAKE_DURATION);
      fireTimer.reset();
      
      amountOfBeats = 0;
    }
    fireTimer.update();
  }

  //draw rows of tiles
  void display (Camera camera) {
    for (int iFloor = 0; iFloor < building.size(); iFloor++) {
      building.get(iFloor).display(camera);
    }
  }

  void setFire() {
    for (int iRow = 0; iRow < w; iRow++) {
      building.get(currentFloorToSetFire-1).tiles[iRow].shatter();
      if (random(0, 100) > 30) continue;
      building.get(currentFloorToSetFire).tiles[iRow].shatter();
    }
    currentFloorToSetFire++;
  }

  void initFire() {
    if (!fire) {
      for (int iRow = 0; iRow < w; iRow++) {
        building.get(0).tiles[iRow].shatter();
      }
      fire = true;
      fireTimer.init();
      fireTimer.reset();
      currentFloorToSetFire++;
    }
  }

  void checkFloorPlatformsAndResolve(BuildingFloor floor) {
    for (int iRow = 0; iRow < w; iRow++) {
      if (floor.tiles[iRow].hasPlatform == false) {
        checkPlatforms++;
      }
    }
    if (checkPlatforms >= w) {
      Tile tile = floor.tiles[(int)random(w)];
      tile.initPlatform();
      tile.hasPlatform = true;
      tile = floor.tiles[(int)random(w)];
      tile.initPlatform();
      tile.hasPlatform = true;
    }
    checkPlatforms = 0;
  }

  void BuildAndRemoveFloor() {
    if (abs(player.position.y - building.get(building.size() - 1).tiles[0].position.y) <= Config.WINDOW_H * Config.AMOUNT_OF_WINDOWS_ON_SCREEN) {
      building.add(generateFloor()); //If the player is a certain distance from the top of the building it builds a new flor and removes the last floor
      building.remove(0); 
      currentFloorToSetFire--;
    }
  }

  void letFireFollow() {
    if (abs(player.position.y - building.get(currentFloorToSetFire).tiles[0].position.y) >= Config.WINDOW_H * Config.FOLLOWFIRERANGE && player.position.y < building.get(currentFloorToSetFire).tiles[0].position.y) {
      for (int iRow = 0; iRow < w; iRow++) {
        building.get(currentFloorToSetFire).tiles[iRow].shatter();  //If the player is a certain distance from the fire the fire moves up with you
        fireTimer.reset();
      }
      currentFloorToSetFire++;
    }
  }
}
