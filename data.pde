class Chunk {
  int cx, cy;
  color c;
  Tile[][] tiles;
  Chunk(int cx, int cy, color c) {
    this.cx = cx;
    this.cy = cy;
    this.c = c;
    tiles = new Tile[8][8];
    for (int x = 0; x < 8; x++)
      for (int y = 0; y < 8; y++)
        tiles[x][y] = new Tile(cx * 8 + x, cy * 8 + y);
    regenerateTerrain();
  }
  void update() {
    regenerateTerrain();
  }
  void show() {
    for (Tile[] tiles : this.tiles)
      for (Tile tile : tiles)
        tile.show();
  }
  void regenerateTerrain() {
    for (Tile[] tiles : this.tiles)
      for (Tile tile : tiles)
        tile.updateTerrain(c);
  }
}

class Tile {
  int hx, hy;
  float z;
  color c;
  Tile(int hx, int hy) {
    this(hx, hy, 0, color(255));
  }
  Tile(int hx, int hy, float z, color c) {
    this.hx = hx;
    this.hy = hy;
    this.z = z;
    this.c = c;
  }
  void show() {
    pushMatrix();
    fill(0);
    stroke(c);
    strokeWeight(HEX_STROKE_THICKNESS / scale);
    translate(hx * 2 + hy % 2, hy * 2 * sin(PI / 3), z);
    PVector hp = new PVector(HEX_RENDER_SIZE, 0);

    //simple culling of out of view tiles (not fully accurate)
    //PVector sp = new PVector(screenX(0, 0, 0), screenY(0, 0, 0));
    //if (sp.x < 0 || sp.x > width || sp.y < 0 || sp.y > height) {
    //  popMatrix();
    //  return;
    //}

    pushMatrix();
    for (int i = 0; i < 6; i++) {
      pushMatrix();
      translate(hp.x, hp.y, -2);
      rotateX(PI / 2);
      rectMode(CENTER);
      rotateY(PI / 2);
      rect(0, 0, 2 * 0.57735026919 * HEX_RENDER_SIZE, 4);
      popMatrix();
      rotateZ(PI / 3);
    }
    popMatrix();
    rotateZ(PI / 6);
    scale(HEX_RENDER_SIZE);
    polygon(0, 0, 1.15470053838, 6);
    popMatrix();
  }
  void updateTerrain(color c) {
    this.z = 5 * noise(hx / 5., hy / 5., millis() * .0001);
    this.c = blendColor(c, color(55 + 200 * noise(hx / 5., hy / 5., millis() * .0001)), MULTIPLY);
  }
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
