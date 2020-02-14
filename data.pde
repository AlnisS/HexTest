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
    noFill();
    stroke(c);
    strokeWeight(HEX_STROKE_THICKNESS / scale);
    translate(hx * 2 + hy % 2, hy * 2 * sin(PI / 3), z);
    PVector hp = new PVector(HEX_RENDER_SIZE, -HEX_RENDER_SIZE * HEX_SIDE_LENGTH);
    for (int i = 0; i < 6; i++)
      line(hp.x, hp.y, hp.rotate(PI / 3).x, hp.y);
    popMatrix();
  }
  void updateTerrain(color c) {
    this.z = 5 * noise(hx / 5., hy / 5., millis() * .0001);
    this.c = blendColor(c, color(55 + 200 * noise(hx / 5., hy / 5., millis() * .0001)), MULTIPLY);
  }
}
