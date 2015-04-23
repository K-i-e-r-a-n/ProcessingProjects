float x,y,z, angle;
void setup() {
  size(200,200,P3D);
  background(0);
  lights();
  noFill();
  ortho();
  stroke(255);
  x = width/2;
  y = height/2;
  z = -100;
  angle = 0.0;
}

void draw() {
  pushMatrix();
  translate(x,y,z);
  background(0);
  rotateZ(angle/3);
  rotateX(angle*2);
  rotateY(-angle);
  box(100);
  popMatrix();
  angle += 0.01;
}


