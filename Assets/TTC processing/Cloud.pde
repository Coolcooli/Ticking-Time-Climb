class Cloud {

  float cloudX, cloudY, cloudW, cloudH;
  color cloudColor;
  int opacity;
  
  Cloud(float x, float y, float w, float h, color c, int o) {
    this.cloudX = x;
    this.cloudY = y;
    this.cloudW = w;
    this.cloudH = h;
    this.cloudColor = c;
    this.opacity = o;
    
  }

  void display(PGraphics buildingImage) {
    buildingImage.noStroke();
    buildingImage.fill(cloudColor, opacity);
    buildingImage.ellipse (cloudX, cloudY+45, cloudW+40, cloudH+30);
    buildingImage.ellipse (cloudX+20, cloudY+55, cloudW+40, cloudH+30);
    buildingImage.ellipse (cloudX+70, cloudY+45, cloudW+40, cloudH+30);
    buildingImage.ellipse (cloudX+50, cloudY+55, cloudW+40, cloudH+30);
    buildingImage.ellipse (cloudX+60, cloudY+35, cloudW+40, cloudH+30);
    buildingImage.ellipse (cloudX+20, cloudY+35, cloudW+40, cloudH+30);
    buildingImage.ellipse (cloudX+40, cloudY+30, cloudW+40, cloudH+30);
  }
}
