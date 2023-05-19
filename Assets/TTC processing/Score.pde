//Code from Kevin Kroon 500855487
class Score
{
  float windowCleanScore;
  
  Score(float x) {
    scoreCount = x;
    windowCleanScore = 0;
  }

  void display() {
    fill(#ffffff); //red color
    textSize(28);
    image(scoreBackground, 60, 100, 288, 64);
    textAlign(LEFT);
    text("Score:" + round(scoreCount), 80, 145);
  }

  void add(Player player) {
    if (highestScore <= abs(player.position.y) && player.position.y < 0) {
      highestScore = abs(player.position.y);
    }
    windowCleanScore *= comboScoreModifier;
    addedScore += windowCleanScore;
    scoreCount = highestScore * Config.SCORE_SPEED + addedScore;
    
    if (windowCleanScore > 0) windowCleanScore = 0;
  }
}
