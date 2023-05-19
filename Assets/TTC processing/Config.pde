//Declare and insert all static final variables
static class Config {

  //Global Variables
  static final String MAINMENUSCENE = "MainMenu";
  static final String GAMESCENE = "GameScene";
  static final String HIGHSCORESCENE = "HighScore";
  static final String GAMEOVERSCENE = "GameOver";
  static final String PAUSEMENU = "PauseMenu";
  static final String NAMESCENE = "NameScene";
  static final String CONTROLSSCENE = "Controls";

  //Button Variables
  static final int BUTTON_W = 200;
  static final int BUTTON_H = 90;

  static final int MOVE_LABEL = 18;

  //Background Variables
  static final float BACKGROUND_SPEED = .05;
  static final int IMAGE_OFFSET = 20;

  static final int STARSAMOUNT = 300;
  static final int CLOUDSAMOUNT = 30;
  static final int BUILDINGAMOUNT = 20;
  static final int FOGAMOUNT = 40;

  //Button Variables
  static final int RECT_CURVE = 12;
  static final int TEXT_SIZE = 15;

  //Building Manager Variables
  static final int WINDOW_W = 122;
  static final int WINDOW_H = 205;

  //ElevatorShaft Variables
  static final int MIN_LEVELS = 3;
  static final int MAX_LEVELS = 6;

  //FireBullet Variables
  static final int MAX_LIFESPAN = 255;
  static final int LIFESPAN_DECREASE_SPEED = 9;
  static final float BULLET_X_SLOWDOWN = 0.99;
  static final float BULLET_Y_SLOWDOWN = 0.999;

  //HighScore Menu Variables
  static final int AMOUNT_OF_HIGH_BUTTONS = 1;

  static final int BUTTON_X_HIGH = 1200;
  static final int BUTTON_Y_HIGH = 950;

  static final int RANK_X = 400;
  static final int RANK_Y = 200;
  static final int PLACE_BETWEEN_ROWS = 60;

  static final int COLUMN_X = 400;
  static final int PLACE_BETWEEN_COLUMNS = 350;

  static final int HIGHSCORE_TEXT_SIZE = 25;

  static final int NETWORK_ERROR_TEXT_SIZE = 125;

  static final int HIGHSCORE_RECT_BACKGROUND_X = 300;
  static final int HIGHSCORE_RECT_BACKGROUND_Y = 100;
  static final int HIGHSCORE_RECT_BACKGROUND_W = 1100;
  static final int HIGHSCORE_RECT_BACKGROUND_H = 800;
  static final int HIGHSCORE_RECT_BACKGROUND_CURVE = 50;

  static final int HIGHSCORE_COLUMNS_Y = 140;

  //Main Menu Variables
  static final int BUTTON_Y_START_MAIN = 500;
  static final int BUTTON_Y_HIGH_MAIN = 600;
  static final int BUTTON_Y_CONTROLS_MAIN = 700;
  static final int BUTTON_Y_CHANGE_NAME_MAIN = 800;
  static final int BUTTON_Y_EXIT_MAIN = 900;

  //Pause Menu Variables
  static final int AMOUNT_OF_PAUSE_BUTTONS = 3;

  static final int BUTTON_W_PAUSE = 200;
  static final int BUTTON_H_PAUSE = 110;

  static final int RESUME_X = 960 - BUTTON_W_PAUSE / 2;
  static final int RESUME_Y = 300;

  static final int QUIT_X = 960 - BUTTON_W_PAUSE / 2;
  static final int QUIT_Y = 700;

  static final int RETRY_X = 960 - BUTTON_W_PAUSE / 2;
  static final int RETRY_Y = 500;

  //Game Scene Variables
  static final float SCORE_SPEED = 0.01;

  static final int LOWEST_PLAYER_Y = 1105;

  static final float SCREENSHAKE_MAX = 0.2;
  static final float SCREENSHAKE_MIN = 0.001;

  static final int AMOUNT_OF_WINDOWS_ON_SCREEN = 6;

  static final int BUILDING_X = 411;
  static final int BUILDING_Y = 1161;
  static final int BUILDING_W = 1536;
  static final int BUILDING_H = 960;

  static final int LOWER_BUILDING_X = 192;
  static final int LOWER_BUILDING_Y = 1296;
  static final int LOWER_BUILDING_W = 1098;
  static final int LOWER_BUILDING_H = 615;

  static final int SIDEWALK_H = 77;

  static final int AMOUNT_OF_WINDOW_COLUMNS = 9;

  static final int PLAYER_ON_FIRE = -370;

  static final int GAMESCENE_SHAKE_DURATION = 40;

  static final int MOVE_CAMERA_SPEED = -5;

  static final float ELEVATOR_MOVEMENT_SPEED = -1;

  static final float PLATFORM_H = 20.5;

  static final int PARTICLE_SYSTEM_LOCATION = 50;

  static final int SHAKE_DISTANCE = 900;

  static final int SHAKEDISTANCE = 1000;

  static final int TOPSPEED = 10;
  static final float MOVEMENTSPEED = 1f;
  static final int JUMPSPEED = -22;
  static final int GRAVITY = 1;

  static final int BULLET_SIZE = 10;
  static final int PARTICLESYSTEM_X_RADIUS = 2;

  //GameOver Scene Variables
  static final int AMOUNT_OF_GAMEOVER_BUTTONS = 3;

  static final int BUTTON_W_GAMEOVER = 300;
  static final int BUTTON_H_GAMEOVER = 150;

  static final int RETRY_GAMEOVER_X = 300;
  static final int RETRY_GAMEOVER_Y = 450;

  static final int HIGH_GAMEOVER_X = 800;
  static final int HIGH_GAMEOVER_Y = 450;

  static final int MAIN_GAMEOVER_X = 1300;
  static final int MAIN_GAMEOVER_Y = 450;

  static final int GAMEOVER_X = 960;
  static final int GAMEOVER_Y = 200;
  static final int GAMEOVER_SIZE = 150;

  static final int LETTER_Y = 850;

  static final int FOLLOWFIRERANGE = 4;

  static final int LETTER_A = 65;
  static final int LETTER_Z = 90;

  static final int NAME_INSERT_ERROR_TEXT = 80;
  static final int NAME_INSERT_ERROR_Y_1 = 700;
  static final int NAME_INSERT_ERROR_Y_2 = 850;

  static final int INSERT_HIGHSCORE_SIZE = 45;
  static final int GAMEOVER_ARROW_UP_X = 38;
  static final int GAMEOVER_ARROW_UP_Y = 75;
  static final int GAMEOVER_ARROW_DOWN_Y = 35;

  static final int SUBMIT_HIGHSCORE_X = 1900;
  static final int SUBMIT_HIGHSCORE_Y = LETTER_Y - 50;

  static final int INSERT_NAME_X = 130;
  static final int INSERT_NAME_Y = 150;

  static final float NAME_SUBMIT_X = 1900;
  static final int NAME_SUBMIT_Y = LETTER_Y + 140;

  //Controls Variables
  static final int AMOUNT_OF_CONTROLS_BUTTONS = 1;

  static final int BUTTON_X_CONTROLS = 50;
  static final int BUTTON_Y_CONTROLS = 50;

  //Player Variables
  static final int MAX_STAMINA = 100;
  static final int STAMINA_JUMP_COST = 5;

  //Lowerbuilding Variables
  static final int AMOUNT_OF_LOWERBUILDING_PARTICLESYSTEMS = 20;
  static final int LOWERBUILDING_BULLET_Y_RADIUS = 8;

  //Tile Variables
  static final int TILE_BULLET_Y_RADIUS = 10;

  //Clean State Variables
  static final float CLEAN_TIME = 1.2;

  //Namescene variables
  static final int NAMESCENE_LETTER_X = 1000;
  static final int NAMESCENE_LETTER_Y = 250;
  static final int NAMESCENE_DIST_BETWEEN_LETTERS = 50;

  static final int CHOOSE_NAME_X_OFFSET = 250;
  static final int CHOOSE_NAME_Y_OFFSET = 100;
}
