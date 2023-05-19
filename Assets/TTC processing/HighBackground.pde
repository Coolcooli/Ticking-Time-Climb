//Made by Lars Nienhuis 500882270

class HighBackground {

  Star[] stars = new Star[200];
  Planet[] planets = new Planet[20];

  HighBackground(PVector position) {
    for (int i = 0; i < stars.length; i++) {
      stars[i] = new Star(new PVector(random(width), random(height)));

      if (i < planets.length) {
        planets[i] = new Planet(new PVector(random(50, width - 50), random(position.y + 50, position.y + height - 50)), new PVector(random(-2, 2), random(-2, 2)), random(40, 120), int(random(7)));
      }
    }
  }

  void update() {
    for (int i = 0; i < planets.length; i++) {
      for (int j = 0; j < planets.length; j++) {
        if (checkPlanetCollision(planets[i].position, planets[i].planetSize, planets[j].position, planets[j].planetSize) && i != j) {
          planets[i].collide = true;
          planets[j].collide = true;
          planets[i].reset();
          planets[j].reset();
        }
      }
      planets[i].update();
    }

    for (Star s : stars) {
      s.update();
    }
  }

  void display() {
    background(0);
    for (Star s : stars) {
      s.display();
    }
    for (Planet p : planets) {
      p.display();
    }
  }

  boolean checkPlanetCollision(PVector position1, float planetSize1, PVector position2, float planetSize2) {
    return (dist(position1.x + planetSize1/2, position1.y + planetSize1/2, position2.x + planetSize2/2, position2.y + planetSize2/2) <= (planetSize1/2 + planetSize2/2));
  }
}
