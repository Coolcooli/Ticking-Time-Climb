class Transform {
  PVector position;
  PVector origin;
  float h;
  float w;
  String tag;

  Transform(PVector position, float w, float h) {
    this.position = position;
    this.origin = position;
    this.h = h;
    this.w = w;
  }
}
