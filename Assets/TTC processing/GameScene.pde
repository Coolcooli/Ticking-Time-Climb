//Made By Lars Nienhuis 500882270 & Robin Schellingerhout & Kevin Kroon

class GameScene implements IScene {
  //Declare all objects
  Player player;
  BuildingManager buildingManager;
  Score score;
  ComboSystem comboSystem;
  Background background;
  Camera camera;
  Bird bird;
  LowerBuilding lowerBuilding;
  Timer deathTimer;
  Timer cleanTimer;
  Timer camTimer;
  ParticleSystem[] fireLine;
  AdaptiveAudio adaptiveAudio;
  BeatDetect beat;
  BeatListener beatListener;

  float shakeIntensity;
  float distToFire;

  boolean startBuildingFire = false;
  int deathScreen;
  boolean fallDeath;

  float distAbovePlayer = 1000;

  boolean tileCleaned = false;
  int addedPointsColor;

  boolean startSounds;
  boolean soundHaveStarted;
  boolean startFire = false;

  void startScene() {  
    placeInArray = 0; //Set all values in the beginning of the gamescene
    scoreCount = 0;
    highestScore = 0;
    addedScore = 0;
    comboScoreModifier = 1;    
    deathScreen = 0;
    addedPointsColor = 0;

    fallDeath = false;
    score = new Score(0);
    comboSystem = new ComboSystem(0);
    player = new Player(new PVector(width / 2, 1050), 75, 88);
    buildingManager = new BuildingManager(new PVector(Config.BUILDING_X, height / 2 + 5 / 2 * Config.WINDOW_H), Config.AMOUNT_OF_WINDOW_COLUMNS, Config.WINDOW_W, Config.WINDOW_H, player);
    buildingManager.init();
    camera = new Camera();
    background = new Background(new PVector(0, 0), width, height, ceil(random(2)));     
    lowerBuilding = new LowerBuilding(new PVector(Config.BUILDING_X, Config.BUILDING_Y), Config.LOWER_BUILDING_W, Config.LOWER_BUILDING_H);
    deathTimer = new Timer(0);
    cleanTimer = new Timer(0);
    camTimer= new Timer(0);
    bird = new Bird(new PVector(0, player.position.y - distAbovePlayer), 108, 102, 45, 0.1);
    bird.setTarget(player.position);
    fireLine = new ParticleSystem[27];
    adaptiveAudio = new AdaptiveAudio();

    //beat expects buffers that are the same length as the song's buffer size
    //and that captures the samples at the song's sampe rate
    beat = new BeatDetect(TTCMainTheme.bufferSize(), TTCMainTheme.sampleRate());
    beat.setSensitivity(350);
    beatListener = new BeatListener(beat, TTCMainTheme);
    startSounds = false;
    soundHaveStarted = false;
    player.stamina = Config.MAX_STAMINA;
    background.lastPlayerY = player.position.y;
    TTCMainTheme.loop(); //Start the main sound
    TTCMainTheme.setGain(-15);
    titleTheme.close();

    camera.setTarget(player);
    try {
      database.deathMarkerTable =  myConnection.runQuery(database.deathMarkerQuery); //Get all values for the deathmarkers
    } 
    catch (Exception e) {
    }
  }

  void updateScene()
  {
    pauseOptionCheck();
    updateAudio();

    if (paused) 
      return;

    startPhase();
    lowerBuilding.update(camera);
    buildingManager.update(camera);
    player.update();
    comboSystem.update();
    camera.update();
    checkBuildingCollision();
    resolveGroundCollision();
    camTimer.update();
    background.update(player);
    score.add(player);
    database.playerPosition.set(player.position);
    resetCleanTimer();
    if (!startFire)
      return;

    initFireLine();
    buildingManager.letFireFollow();
    bird.update();
    spawnBird();
    updateFireLine();
    checkBeat();
    updateAdaptiveAudio();
  }

  void drawScene() {
    if (!paused) { //Draw everything if the game is not paused
      background.display();
      lowerBuilding.display(camera);
      buildingManager.display(camera);
      player.display(camera);
      displayFireLine();
      bird.display(camera);
      bonusScore();
      try {
        deathMarkers(database.deathMarkerTable);
      } 
      catch (Exception e) {
        dataBaseError = true;
      }
      score.display();
      comboSystem.display();
      getFallDamage();
    }
  }

  void startPhase() {
    if (scoreCount >= 12 && !startFire) {
      camTimer.counting = true;
      camera.camSpeed = .02f;
      camera.setTarget(lowerBuilding);
      initFire();
    }
    animateToPlayer();
  }

  void initFire() {
    if (camTimer.time < 2)
      return;

    buildingManager.initFire();
    lowerBuilding.initParticleSystem();
    camTimer.reset();
    startFire = true;
    camera.camSpeed = .005f;
    camera.setTarget(player);
  }

  void animateToPlayer() {
    if (camTimer.time > 3 && startFire) {
      camera.camSpeed = .08f;
    }
  }

  void checkBuildingCollision() { //Check collisions for all tiles
    for (BuildingFloor floor : buildingManager.building) {
      for (int iRow = 0; iRow < floor.tiles.length; iRow++) {
        checkCollision(floor.tiles[iRow]);
        if (floor.tiles[iRow].hasPlatform) {
          checkCollision(floor.tiles[iRow].platform);
        }
      }
    }
    checkCollision(bird); //Check collisions for bird, poop and the lowerbuilding
    checkCollision(bird.poop);
    checkCollision(lowerBuilding);
  }

  void checkCollision(Transform collider) { //Check the player position with all the colliders
    if (player.position.y + player.h >= collider.position.y - 10 && 
      player.position.y + player.h <= collider.position.y + collider.h + 20 && 
      player.position.x + player.w - 20 >= collider.position.x && 
      player.position.x + 20 <= collider.position.x + collider.w) {
      switch(collider.tag) {
      case "platform" : 
        if (!keysPressed[DOWN] && player.velocity.y >= 0) {
          player.resolvePlatformCollision(collider);
        }
        break;
      }
    }
    if (player.position.y + player.h > collider.position.y && 
      player.position.y <= collider.position.y + collider.h && 
      player.position.x + player.w - 20 >= collider.position.x && 
      player.position.x + 20 <= collider.position.x + collider.w) {
      switch(collider.tag) {
      case "nastyTile" : 
        if (player.velocity.x > 0 || player.velocity.y > 1 && tileCleaned) tileCleaned = false;
        if ((keysPressed['A']!= keysPrevious['A'] && keysPressed['A']) || (keysPressed['S']!= keysPrevious['S'] && keysPressed['S'])
          && player.canClean && player.velocity.y <= 1 && player.velocity.y >= 0) {
          waterHose.play();
          windowsCleaned++;
          player.canClean = false;
          cleanTimer.init();
        }
        cleanTimer.update();
        if (cleanTimer.time > Config.CLEAN_TIME) {
          NastyTile tile = (NastyTile)collider; 
          score.windowCleanScore = 5;
          tile.getCleaned();
          cleanTimer.end();
          tileCleaned = true;

          comboScoreCount++;
          comboSystem.comboTimer.reset();
        }
        break; 
      case "fireTile" : 
        player.die();
        break;
      case "lowerBuilding" : 
        switchScene(Config.GAMEOVERSCENE); 
        break; 
      case "elevatorShaft" : 
        ElevatorShaft tile = (ElevatorShaft)collider; 
        checkCollision(tile.elevator);
        break;
      case "bird":
        player.velocity.add(bird.velocity.x * 2, 0);
        break;
      case "poop":
        player.allowCollision = false;
        player.showPoopParticle = true;
        bird.poop.position.set(-100, bird.position.y);
        bird.poop.active = false ;
        bird.pooped = false;
        break;
      }
    }
    if (player.position.y + player.h >= collider.position.y - 20 && 
      player.position.y + player.h <= collider.position.y + 40 &&
      player.position.x + player.w >= collider.position.x &&
      player.position.x <= collider.position.x + collider.w) {
      switch(collider.tag) {
      case "elevator" :
        player.velocity.y = 0;
        player.position.y = collider.position.y - player.h;
        player.isGrounded = true;
        break;
      }
    } else if (player.position.y <= collider.position.y + collider.h &&
      player.position.y >= collider.position.y + collider.h - 20 &&
      player.position.x + player.w >= collider.position.x &&
      player.position.x <= collider.position.x + collider.w) {
      switch(collider.tag) {
      case "elevator" :
        player.position.y = collider.position.y + collider.h;
        player.velocity.y = -0.5;
        break;
      }
    }
    if (player.position.y + player.h <= collider.position.y + collider.h - Config.PLATFORM_H/2 + 20 &&
      player.position.y + player.h >= collider.position.y + collider.h/2 &&
      player.position.x + player.w >= collider.position.x &&
      player.position.x <= collider.position.x + collider.w) {
      switch(collider.tag) {
      case "elevator" :
        Elevator elevator = (Elevator)collider;
        elevator.startMove();
        if (player.velocity.y > 0) {
          player.isGrounded = true;
          player.position.y = collider.position.y + collider.h - Config.PLATFORM_H/2 - player.h;
        }
        break;
      }
    }
  }

  void initScreenShake() {
    distToFire = (buildingManager.currentFloorToSetFire * - Config.WINDOW_H) + Config.LOWEST_PLAYER_Y - player.position.y;

    if (distToFire < Config.SHAKE_DISTANCE) { //If the player is close to the fire shake the screen
      shakeIntensity = map(distToFire, Config.PLAYER_ON_FIRE, Config.SHAKE_DISTANCE, Config.SCREENSHAKE_MAX, Config.SCREENSHAKE_MIN);
    }
  }

  void pauseOptionCheck() {
    if (keysPressed['C']) { //Press 'C' to pause the game
      placeInArray = 0;
      paused = !paused;
    }
  }

  void resolveGroundCollision() {
    if (player.position.y + player.h >= Config.BUILDING_Y + lowerBuildingImg.height) { //If the player falls off the building onto the ground let the player die
      player.die();
    }
  }

  void getFallDamage() {
    if ((player.position.x > buildingManager.building.get(0).tiles[8].position.x + Config.WINDOW_W && player.velocity.y > 50) || (player.position.x + player.w < buildingManager.building.get(0).tiles[0].position.x && player.velocity.y > 50)) {
      fallDeath = true; //If the players velocity is high and the player is outside of the building the player dies
    }
    if (!fallDeath) 
      return;

    if (deathScreen < 255) {
      deathScreen += 20;
      if (deathScreen == 260) falling.play(); //Start a falling sound
    } else if (deathScreen >= 255) {
      deathScreen = 255;
    }
    if (deathTimer.time <= 0) {
      deathTimer.init();
    }
    if (deathScreen >= 255) {
      player.velocity.set(0, 0); //If the screen is fully black set the velocity to 0
    }
    if (deathTimer.time > 2) {
      deathTimer.end(); //If the timer has finished switch to the game scene and play this sound
      boneBreak.play();
      falling.setGain(-100);
      switchScene(Config.GAMEOVERSCENE);
    }
    deathTimer.update();
    noStroke();
    fill(0, deathScreen);
    rect(0, 0, width, height); //Draw a rect to cover up the screen
  }

  void spawnBird() {
    float playerAboveBird = bird.position.y - 1000; //how far above the bird does the player have to be before it moves
    float birdOffSet = player.position.y - 1000; //by how far does the bird get moved above the player's current position
    if (bird.position.x > width && player.position.y <= playerAboveBird) {
      bird.position.set(0, birdOffSet);
      bird.setTarget(player.position);
    }
  }

  void initFireLine() {
    if (fireLine[fireLine.length-1] == null) {
      for (int i = 0; i < fireLine.length; i++) {
        fireLine[i] = new ParticleSystem();
        fireLine[i].initialize(new PVector(Config.BUILDING_X + (i * Config.WINDOW_W/3), height + 125), Config.BULLET_SIZE, 2, 2, 10, 0); //Initialize the fireline
      }
    }
  }

  void updateFireLine() {
    if (fireLine[fireLine.length-1] == null) return;
    for (int i = 0; i < fireLine.length; i++) {
      float fireHeight = map(adaptiveAudio.alarmVolume, 0.5, 0.05, height, height + 175);
      fireLine[i].reset(new PVector(Config.BUILDING_X + (i * Config.WINDOW_W/3), fireHeight));
      fireLine[i].update(); //Update the fireline
    }
  }

  void displayFireLine() {
    if (fireLine[fireLine.length-1] == null) return;
    for (int i = 0; i < fireLine.length; i++) {
      fireLine[i].display(); //Display the fireline
    }
  }

  void bonusScore() {
    if (tileCleaned) {
      addedPointsColor = 255;
    }
    if (addedPointsColor > 0) {
      textSize(30);
      fill(addedPointsColor, 0, 0, addedPointsColor);
      text("+"+ 5 * comboScoreModifier +" Points", player.position.x + player.w/2, player.position.y - camera.position.y);
      textSize(20);
      text("Stamina up", player.position.x + player.w/2, player.position.y - camera.position.y - 30);
    }
    if (addedPointsColor > 0) addedPointsColor -= 5;
  }

  void resetCleanTimer() {
    if (keysPressed[LEFT] || keysPressed[RIGHT] && cleanTimer.time > 0) {
      cleanTimer.end();
      tileCleaned = false; //Make sure the player can clean if he has moved
    }
  }

  void updateAudio() {
    if (!soundHaveStarted && startFire) {
      soundHaveStarted = true;
      fireAlarm.loop(); //Start all sounds in the beginning of the game
      fireSound.loop();
      //  fireAlarm.setGain(-30);
      // fireSound.setGain(-30);
      startSounds = false;
    }
    if (paused && soundHaveStarted) {
      fireAlarm.pause(); //Pause the sounds if the game is paused
      fireSound.pause();
      soundHaveStarted = false;
    }
  }

  void updateAdaptiveAudio() {
    //Update the adaptive audio to the distance from the player to the fire
    if (startFire) adaptiveAudio.update(player.position.y, player.h, buildingManager.building.get(buildingManager.currentFloorToSetFire).tiles[0].position.y);
  }

  //marker on location of playery with a display of name and score
  void deathMarkers(Table table) {
    for (TableRow row : table.rows()) {
      float Ypos = round(float(row.getString(0)));
      String name = row.getString(1);
      int score = round(float(row.getString(2)));
      fill(#00FF00);
      fill(#000000);
      textAlign(CENTER);
      textFont(pixelFont);
      image(gravestone, 100, Ypos - camera.position.y, gravestone.width * 0.4, gravestone.height * 0.4);
      textSize(20);
      text(name, 100 + (gravestone.width * 0.4)/2, Ypos - camera.position.y + 60);
      textSize(24);
      text("score", 100 + (gravestone.height * 0.4)/2, Ypos - camera.position.y + 100);  
      textSize(28);
      text(score, 100 + (gravestone.height * 0.4)/2, Ypos - camera.position.y + 140);
    }
  }

  void checkBeat() {
    if (beat.isKick()) {
      buildingManager.amountOfBeats++;
    }
  }
}
