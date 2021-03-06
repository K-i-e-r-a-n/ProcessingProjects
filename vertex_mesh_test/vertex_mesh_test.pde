import java.util.*;
import ddf.minim.*;
import ddf.minim.analysis.*;


Minim minim;
AudioInput in;
FFT fft;

Random rnd;
int time = 0;
float data[][];
float xPosition;
float yPosition;
int lastMousePosX;
int lastMousePosY;
float depth_spacing;
float width_spacing;
float amplitude;
int n_of_bands;
int hist_len;
int start;
int data_index;
int data_next;
void setup()
{
  size(1600, 900, P3D);

  n_of_bands = 50;
  hist_len = 100; 
  depth_spacing = 100;
  width_spacing = 75;
  amplitude = 10;

  minim = new Minim(this);
  in = minim.getLineIn();
  fft = new FFT(in.bufferSize(), in.sampleRate()); 
  fft.logAverages(22, 5);

  data = new float[hist_len][n_of_bands];
  rnd = new Random();
  start = 0;

  xPosition = 0;
  yPosition = 0;
  lastMousePosX = 0;
  lastMousePosY = 0;
}

void draw()
{ 
  if (mousePressed == true)  
  {
    xPosition += mouseX - lastMousePosX;
    yPosition += mouseY - lastMousePosY;
  }

  fft.forward(in.mix);
  for (int j = 0; j < n_of_bands; j++)
  {
    data[start][j] = -fft.getBand(j)*amplitude;
  }   
  
  translate(width/2, height/2, -50);
  rotateY(xPosition/100);
  rotateX(yPosition/100);
  background(0);
  stroke(255);
  noFill();
  pushMatrix();
  translate(-n_of_bands*width_spacing/2, 1000, -750);
  
  for (int i = 0; i < (data.length - 1); i++) 
  {
    data_index = ((start - i) + hist_len)%hist_len;
    data_next = ((start - i - 1) + hist_len)%hist_len;
    for (int j = 0; j < (data[i].length - 1); j++)
    {
      fill(100, 0, 0, 255 - 255 * i/data.length);
      stroke(255);
      if ((i%2 == 0) ^ (j%2 == 0))
      {
        beginShape(TRIANGLES);
        //stroke(255, 0, 0);
        vertex(j*width_spacing, data[data_index][j]*10, -i*depth_spacing);
        vertex(j*width_spacing, data[data_next][j]*10, -(i+1)*depth_spacing);
        vertex((j+1)*width_spacing, data[data_next][j+1]*10, -(i+1)*depth_spacing);
        vertex(j*width_spacing, data[data_index][j]*10, -i*depth_spacing);
        vertex((j+1)*width_spacing, data[data_index][j+1]*10, -(i)*depth_spacing);
        vertex((j+1)*width_spacing, data[data_next][j+1]*10, -(i+1)*depth_spacing);
        endShape();
      } else
      {
        beginShape(TRIANGLES);
        //stroke(0, 0, 255);
        vertex(j*width_spacing, data[data_index][j]*10, -i*depth_spacing);
        vertex(j*width_spacing, data[data_next][j]*10, -(i+1)*depth_spacing);
        vertex((j+1)*width_spacing, data[data_index][j+1]*10, -(i)*depth_spacing);
        vertex((j)*width_spacing, data[data_next][j]*10, -(i+1)*depth_spacing);
        vertex((j+1)*width_spacing, data[data_index][j+1]*10, -(i)*depth_spacing);
        vertex((j+1)*width_spacing, data[data_next][j+1]*10, -(i+1)*depth_spacing);
        endShape();
      }
    }
  }
  
  popMatrix();

  //shiftArray(data);
  start = ((start + 1) + hist_len)%hist_len;
  lastMousePosX = mouseX;
  lastMousePosY = mouseY;
}

void shiftArray(float[][] array)
{
  for (int i = hist_len - 1; i > 0; i--)
  {
    for (int j = 0; j < data[i].length; j++)
    {
      data[i][j] = data[i-1][j];
    }
  }
}

