float data[][] = {{1, 3, 2, 3, 4, 7, 4, 3, 2, 1},
                    {6, 3, 2, 4, 4, 7, 4, 3, 2, 1},
                    {4, 4, 2, 8, 6, 3, 4, 7, 1, 6},
                    {7, 7, 3, 5, 7, 3, 2, 3, 2, 4},
                    {3, 5, 3, 4, 2, 5, 1, 1, 9, 3},
                    {2, 5, 1, 3, 9, 4, 7, 9, 1, 5},
                    {4, 1, 5, 0, 7, 4, 1, 3, 9, 1},
                    {1, 4, 3, 1, 6, 7, 3, 2, 1, 8},
                    {2, 7, 2, 2, 6, 8, 3, 3, 9, 1},
                    {3, 9, 9, 2, 3, 7, 3, 7, 1, 2}};
float xPosition;
float yPosition;
int lastMousePosX;
int lastMousePosY;
int r;

void setup()
{
  size(1280, 720, P3D);
  xPosition = 0;
  yPosition = 0;
  lastMousePosX = 0;
  lastMousePosY = 0;
  r = 500;
}

void draw()
{ 
  if(mousePressed == true)  
  {
    xPosition += mouseX - lastMousePosX;
    yPosition += mouseY - lastMousePosY;
  }
  translate(width/2, height/2, -50);
  rotateY(xPosition/100);
  rotateX(yPosition/100);
  background(0);
  stroke(255);
  noFill();
  pushMatrix();
  translate(-data.length*40, 0, data.length*40);
  for (int i = 0; i < (data.length - 1); i++) 
  {
    for (int j = 0; j < (data[i].length - 1); j++)
    {
      stroke(255 - 255 * i/data.length);
      if ((i%2 == 0) ^ (j%2 == 0))
      {
        beginShape(TRIANGLES);
        //stroke(255, 0, 0);
        vertex(j*100, data[i][j]*10, -i*100);
        vertex(j*100, data[i+1][j]*10, -(i+1)*100);
        vertex((j+1)*100, data[i+1][j+1]*10, -(i+1)*100);
        vertex(j*100, data[i][j]*10, -i*100);
        vertex((j+1)*100, data[i][j+1]*10, -(i)*100);
        vertex((j+1)*100, data[i+1][j+1]*10, -(i+1)*100);
        endShape();
      }
      else
      {
        beginShape(TRIANGLES);
        //stroke(0, 0, 255);
        vertex(j*100, data[i][j]*10, -i*100);
        vertex(j*100, data[i+1][j]*10, -(i+1)*100);
        vertex((j+1)*100, data[i][j+1]*10, -(i)*100);
        vertex((j)*100, data[i+1][j]*10, -(i+1)*100);
        vertex((j+1)*100, data[i][j+1]*10, -(i)*100);
        vertex((j+1)*100, data[i+1][j+1]*10, -(i+1)*100);
        endShape();
      }
    }
  }
  popMatrix();
  
  lastMousePosX = mouseX;
  lastMousePosY = mouseY;
}


