class AdaptiveAudio {

  float fireVolume;
  float themeVolume;
  float alarmVolume;

  //minimum value
  float fireVolumeMin = -50;
  float themeVolumeMin = -30;
  float alarmVolumeMin = -50;

  //maximum value
  float fireVolumeMax = -10;
  float themeVolumeMax = -15;
  float alarmVolumeMax = -10;

  void update(float playerY, float playerH, float buildingY) {
    float distance = playerY - playerH - buildingY - 18.75;
    distance *= -1;
    println(distance);

    //change gain depending on how close the fire is
    alarmVolume = map(distance, 0, 800, alarmVolumeMax, alarmVolumeMin);
    fireVolume = map(distance, 0, 800, fireVolumeMax, fireVolumeMin);
  //  themeVolume = map(distance, 0, 800, themeVolumeMin, themeVolumeMax);

    //normal volume
    if (distance <= 0) {
      fireVolume = fireVolumeMax;
      alarmVolume = alarmVolumeMax;
    //  themeVolume = themeVolumeMin;
    }

    if (distance >= 800) {
      fireVolume = fireVolumeMin;
      alarmVolume = fireVolumeMin;
     // themeVolume = themeVolumeMax;
    }

    fireSound.setGain(fireVolume);
    fireAlarm.setGain(alarmVolume);
   // TTCMainTheme.setGain(themeVolume);
  }
}
