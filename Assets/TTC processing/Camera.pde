//Made By Lars Nienhuis 500882270 && Robin Schellingerhout

class Camera {
  float screenShakeX;
  float screenShakeY;
  float intensity;
  float duration;
  boolean shake;

  PVector position;

  Transform target;

  float camSpeed = .1;

  Camera() {
    position = new PVector(width/2, height/2);
  }

  void update() {
    float pos = ((target.position.y + target.h / 2) - position.y) * camSpeed;

    position = new PVector(width / 2, pos + position.y); 
    position.sub(new PVector(width / 2, height / (2 / camSpeed)));

    shake();
  }

  void setTarget(Transform transform) {
    this.target = transform;
  }

  void shake() {
    if (!shake) return;

    duration--;
    if (duration < 0) {
      duration = 0;
      shake = false;
    }
    screenShakeX = random(-duration * intensity, duration * intensity); //This shakes the screen with a certain intensity and duration
    screenShakeY = random(-duration * intensity, duration * intensity);

    position.add(screenShakeX, screenShakeY); //Adding the screenshake position with the camera position
  }

  void setShake(float intensity, float duration) {
    this.intensity = intensity;
    this.duration = duration;

    this.shake = true;
  }
}
