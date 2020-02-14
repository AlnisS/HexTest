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

ArrayList<Chunk> chunks;

void setup() {
  size(1100, 650, P3D);

  chunks = new ArrayList<Chunk>();

  chunks.add(new Chunk(-2, -2, color(255, 255, 63)));
  chunks.add(new Chunk(-2, -1, color(63, 63, 255)));
  chunks.add(new Chunk(-2, 0, color(63, 255, 63)));
  chunks.add(new Chunk(-2, 1, color(255, 63, 63)));

  chunks.add(new Chunk(-1, 1, color(255, 255, 63)));
  chunks.add(new Chunk(-1, -2, color(63, 63, 255)));
  chunks.add(new Chunk(-1, -1, color(63, 255, 63)));
  chunks.add(new Chunk(-1, 0, color(255, 63, 63)));

  chunks.add(new Chunk( 0, 0, color(255, 255, 63)));
  chunks.add(new Chunk( 0, 1, color(63, 63, 255)));
  chunks.add(new Chunk( 0, -2, color(63, 255, 63)));
  chunks.add(new Chunk( 0, -1, color(255, 63, 63)));

  chunks.add(new Chunk( 1, -1, color(255, 255, 63)));
  chunks.add(new Chunk( 1, 0, color(63, 63, 255)));
  chunks.add(new Chunk( 1, 1, color(63, 255, 63)));
  chunks.add(new Chunk( 1, -2, color(255, 63, 63)));
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

  scale(scale);
  translate(xPos, yPos);
  for (Chunk chunk : chunks)
    chunk.update();
  for (Chunk chunk : chunks)
    chunk.show();

  pushMatrix();
  strokeWeight(1 / scale / .03);
  scale(.03);
  stroke(255, 0, 0);
  fill(255, 0, 0);
  line(0, 0, 0, 190, 0, 0);
  text("+x", 200, 0, 0);
  rotateZ(PI / 2);
  stroke(0, 255, 0);
  fill(0, 255, 0);
  line(0, 0, 0, 190, 0, 0);
  text("+y", 200, 0, 0);
  rotateY(-PI / 2);
  rotateX(PI);
  fill(0, 0, 255);
  stroke(0, 0, 255);
  line(0, 0, 0, 190, 0, 0);
  text("+z", 200, 0, 0);
  popMatrix();
}

void mouseWheel(MouseEvent event) {
  targRotation += event.getCount() * PI / 3;
  targRotation = round(targRotation / PI * 3) * PI / 3;
}
