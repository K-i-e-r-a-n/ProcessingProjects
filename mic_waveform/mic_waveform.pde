import ddf.minim.*;
 
Minim minim;
AudioInput in;
int x;

 
void setup()
{
  size(512, 512, P3D);
 
  minim = new Minim(this);
 
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  x = 0;
  stroke(255);
}
 
void draw()
{
  
  background(0);
  
  text("Buffer size: " + in.bufferSize() + ".", 5, 30);

  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line( i, height/2 + in.left.get(i)*height, i+1, height/2 + in.left.get(i+1)*height );
  }
  //for(int i = 0; i < in.bufferSize() - 1; i++)
  //{
  //  line( i, height/2 - 50 + in.right.get(i)*height/2, i+1, height/2 - 50 + in.right.get(i+1)*height/2 );
  //}
  String monitoringState = in.isMonitoring() ? "enabled" : "disabled";
  text( "Input monitoring is currently " + monitoringState + ".", 5, 15 );
}
 
void keyPressed()
{
  if ( key == 'm' || key == 'M' )
  {
    if ( in.isMonitoring() )
    {
      in.disableMonitoring();
    }
    else
    {
      in.enableMonitoring();
    }
  }
}
