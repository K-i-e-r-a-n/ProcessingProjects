import java.util.Random;
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
int len_past_bands;

void setup()
{
  size(1280, 720, P3D);
  
  n_of_bands = 50;
  len_past_bands = 100; 
  depth_spacing = 100;
  width_spacing = 75;
  amplitude = 5;
  
  minim = new Minim(this);
  in = minim.getLineIn();
  fft = new FFT(in.bufferSize(), in.sampleRate()); 
  fft.linAverages(n_of_bands);
 
  
  data = new float[len_past_bands][n_of_bands];
  rnd = new Random();
  
  xPosition = 0;
  yPosition = 0;
  lastMousePosX = 0;
  lastMousePosY = 0;
  //for (int i = 0; i < data.length; i++)
  //{
  //  for (int j = 0; j < data[i].length; j++)
  //  {
  //    data[i][j] = rnd.nextFloat()*amplitude;
  // }   
  //}
}

void draw()
{ 
  //time = time%1;
  if(mousePressed == true)  
  {
    xPosition += mouseX - lastMousePosX;
    yPosition += mouseY - lastMousePosY;
  }
  
  fft.forward(in.mix);
  translate(width/2, height/2, -50);
  rotateY(xPosition/100);
  rotateX(yPosition/100);
  background(0);
  stroke(255);
  noFill();
  pushMatrix();
  translate(-n_of_bands*width_spacing/2, 1000, -len_past_bands*depth_spacing/16);
  for (int i = 0; i < (data.length - 1); i++) 
  {
    for (int j = 0; j < (data[i].length - 1); j++)
    {
      fill(100,0,0,255 - 255 * i/data.length);
      stroke(255);
      if ((i%2 == 0) ^ (j%2 == 0))
      {
        beginShape(TRIANGLES);
        //stroke(255, 0, 0);
        vertex(j*width_spacing, data[i][j]*10, -i*depth_spacing);
        vertex(j*width_spacing, data[i+1][j]*10, -(i+1)*depth_spacing);
        vertex((j+1)*width_spacing, data[i+1][j+1]*10, -(i+1)*depth_spacing);
        vertex(j*width_spacing, data[i][j]*10, -i*depth_spacing);
        vertex((j+1)*width_spacing, data[i][j+1]*10, -(i)*depth_spacing);
        vertex((j+1)*width_spacing, data[i+1][j+1]*10, -(i+1)*depth_spacing);
        endShape();
      }
      else
      {
        beginShape(TRIANGLES);
        //stroke(0, 0, 255);
        vertex(j*width_spacing, data[i][j]*10, -i*depth_spacing);
        vertex(j*width_spacing, data[i+1][j]*10, -(i+1)*depth_spacing);
        vertex((j+1)*width_spacing, data[i][j+1]*10, -(i)*depth_spacing);
        vertex((j)*width_spacing, data[i+1][j]*10, -(i+1)*depth_spacing);
        vertex((j+1)*width_spacing, data[i][j+1]*10, -(i)*depth_spacing);
        vertex((j+1)*width_spacing, data[i+1][j+1]*10, -(i+1)*depth_spacing);
        endShape();
      }
    }
  }
  popMatrix();
  
  if (time ==0){
  shiftArray(data);
  for (int j = 0; j < n_of_bands; j++)
    {
      data[0][j] = -fft.getBand(j)*amplitude;
    }   
  }
  lastMousePosX = mouseX;
  lastMousePosY = mouseY;
  //time++;
}

void shiftArray(float[][] array)
{
  for (int i = len_past_bands - 1; i > 0; i--)
  {
    for (int j = 0; j < data[i].length; j++)
    {
      data[i][j] = data[i-1][j];
    }
  }
}


