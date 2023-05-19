import ddf.minim.*;          //import minim sound library
import ddf.minim.analysis.*;
import samuelal.squelized.*; //import database
import java.util.Properties;

PauseMenu pauseMenu = new PauseMenu();
Database database = new Database();
Properties databaseInfo = new Properties();
SQLConnection myConnection;
Minim minim;


color buttonColor = color(218);
int placeInArray = 0;

boolean paused = false;
boolean state;
boolean dataBaseError = false;

float scoreCount;
int addedScore;
float highestScore;

int jumps;
int elevatorsUsed;
int windowsCleaned;
int maxCombo;
int windowsMissed;

int comboScoreCount;
int comboScoreModifier = 1;

String name;

// Arrays of booleans for Keyboard handling. One boolean for each keyCode
final int KEY_LIMIT = 1024;
boolean[] keysPressed = new boolean[KEY_LIMIT];
boolean[] keysPrevious = new boolean[KEY_LIMIT];

void startGame() {
  database.init();

  scenes.put(Config.MAINMENUSCENE, new MainMenuScene()); //Initializing all scenes
  scenes.put(Config.GAMESCENE, new GameScene());
  scenes.put(Config.HIGHSCORESCENE, new HighScoreScene());
  scenes.put(Config.GAMEOVERSCENE, new GameOverScene());
  scenes.put(Config.PAUSEMENU, new PauseMenu());
  scenes.put(Config.NAMESCENE, new NameScene());
  scenes.put(Config.CONTROLSSCENE, new ControlsScene());

  switchScene(Config.NAMESCENE);
  pauseMenu.startScene();
}

void updateGame() {
  if (!paused) {
    activeScene.updateScene(); //If the game is not paused, update the active scene
  }
  pauseMenu.updateScene();
  for (int iKey = 0; iKey < KEY_LIMIT; iKey++) {
    keysPrevious[iKey] = keysPressed[iKey]; //Set keypressed for the previous frame at the end of the update
  }
}

void drawGame() {
  activeScene.drawScene(); //Draw the active scene

  if (activeScene == scenes.get(Config.GAMESCENE) && paused) {
    pauseMenu.drawScene(); //If the game is paused draw the pause scene
  }
}

//-------------------------------------------------------------- 
//SceneSystem
HashMap<String, IScene> scenes = new HashMap<String, IScene>();//dictonary for all scenes
IScene activeScene;//the active scene

void switchScene(String scene)//switches active scene
{
  activeScene = scenes.get(scene);
  activeScene.startScene();
}

void settings() {
  size(1920, 1080, P2D);
  //fullScreen(P2D); //Turn this on to go fullscreen if the window doesn't allign well. (screen resolution has to be 1920, 1080)

  noSmooth();
}

void setup() {
  minim = new Minim(this);
  surface.setTitle("Ticking Time Climb"); //Set a name for the program
  noCursor();
  loadAssets();
  startGame();
}

void draw() {
  updateGame(); //Update and draw the game
  drawGame();
}

void keyPressed() {
  if (keyCode >= KEY_LIMIT) return; //safety: if keycode exceeds limit, exit function ('return').
  keysPressed[keyCode] = true; // set its boolean to true
}

// checking if the player has released the button
void keyReleased() {
  if (keyCode >= KEY_LIMIT) return;
  keysPressed[keyCode] = false;
}

float invLerp(float a, float b, float v)
{
  return (v - a) / ( b - a);
}

float remap(float v, float iMin, float iMax, float oMin, float oMax)
{
  float t = invLerp(iMin, iMax, v);
  return lerp(oMin, oMax, t);
}
