float scale = 30;
float targScale = 30;
float xPos = 0;
float yPos = 0;
float rotation = 0;
float targRotation = 0;
float viewX;
float viewY;
float viewXVel;
float viewYVel;
float viewZ = 30;
float targViewZ = 30;
float viewRot = .3;
float targViewRot = .3;

void setup() {
  size(1100, 650, P3D);
}

void draw() {
  rotation = lerp(rotation, targRotation, .2);
  viewZ    = lerp(viewZ, targViewZ, .2);
  viewRot  = lerp(viewRot, targViewRot, .2);
  scale    = lerp(scale, targScale, .2);
  if (mousePressed) {
    viewXVel = mouseX - pmouseX;
    viewYVel = mouseY - pmouseY;
  }
  viewX += viewXVel * cos(-rotation) - viewYVel * sin(-rotation);
  viewY += viewXVel * sin(-rotation) + viewYVel * cos(-rotation);
  viewXVel *= .9;
  viewYVel *= .9;

  translate(width / 2, height / 2);
  noiseSeed(0);  // same value for easier testing
  background(0);
  rotateX(PI * viewRot);

  rotateZ(rotation);
  translate(viewX, viewY);
  translate(0, 0, viewZ);
  if (keyPressed) {
    targViewZ = -100;
    targViewRot = .15;
    targScale = 20;
  } else {
    targViewZ = 30;
    targViewRot = .3;
    targScale = 30;
  }

  chunk(-2, -2, color(255, 255,  63));
  chunk(-2, -1, color(63,   63, 255));
  chunk(-2,  0, color(63,  255,  63));
  chunk(-2,  1, color(255,  63,  63));

  chunk(-1,  1, color(255, 255,  63));
  chunk(-1, -2, color(63,   63, 255));
  chunk(-1, -1, color(63,  255,  63));
  chunk(-1,  0, color(255,  63,  63));

  chunk( 0,  0, color(255, 255,  63));
  chunk( 0,  1, color(63,   63, 255));
  chunk( 0, -2, color(63,  255,  63));
  chunk( 0, -1, color(255,  63,  63));

  chunk( 1, -1, color(255, 255,  63));
  chunk( 1,  0, color(63,   63, 255));
  chunk( 1,  1, color(63,  255,  63));
  chunk( 1, -2, color(255,  63,  63));
}

void chunk(int cx, int cy, color c) {
  for (int x = 0; x < 8; x++) {
    for (int y = 0; y < 8; y++) {
      stroke(blendColor(c, color(55 + 200 * noise(x / 5., y / 5., millis() * .0001)), MULTIPLY));
      hexagon(x + cx * 8, y + cy * 8);
    }
  }
}

void hexagon(int hexX, int hexY) {
  noFill();
  pushMatrix();
  scale(scale);
  translate(xPos, yPos);
  strokeWeight(1.5 / scale);
  translate(hexX * 2, 0);
  translate(0, hexY * 2 * sin(PI * 1. / 3.));
  translate(0, 0, 5 * noise(hexX / 5., hexY / 5., millis() * .0001));
  if (hexY % 2 == 0)
    translate(1, 0);
  PVector hexPoint = new PVector(1 * .8, -tan(PI / 6) * .8);
  for (int i = 0; i < 6; i++)
    line(hexPoint.x, hexPoint.y, hexPoint.rotate(PI / 3).x, hexPoint.y);
  popMatrix();
}

void mouseWheel(MouseEvent event) {
  targRotation += event.getCount() * PI / 3;
  targRotation = round(targRotation / PI * 3) * PI / 3;
}
