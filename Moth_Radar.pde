//  You always need to import the serial library in addition to the VSync library
import processing.serial.*;
import vsync.*;

//  We create a new ValueReceiver to receive values from the arduino
ValueReceiver receiver;

//  These are the variables we want to sync from the Arduino to this sketch
public int H;
public int S;

int scaling_factor = 20;
String height_units = "mm";
String speed_units = "km/hr";

int spacing = 50;
int offset = 50;

int framerate = 30;

int xcoord = 0;
float bwidth = 0.0;

void setup() 
{
  size(800, 800);
  frameRate(framerate);
  
  Serial serial = new Serial(this, "/dev/ttyACM0", 115200);
  //  Ininialize the ValueReceiver with this (to hook it to your sketch)
  //  and the serial interface you want to use.
  receiver = new ValueReceiver(this, serial);

  // Tell the ValueReceiver what variable you want to synchronize from the arduino to this sketch.
  receiver.observe("H");
  receiver.observe("S");

  textSize(32);
}

void draw() 
{
  background(0,0,0);
 
  for(int i=0; i<15; i++){
    fill(168,255,0,10);
    stroke(168,255,0,50);
    strokeWeight(1);
    ellipse(width/2,(height/2)-offset,spacing+i*spacing,spacing+i*spacing);
  }
  
  /*
  if (S<0){
    fill(255,0,0);
  }
  else{
    fill(0,255,0);
  }
  */
  
  xcoord = (width/2)-S*scaling_factor;
  bwidth = abs(S*scaling_factor)*0.1;
  fill(168,255,0);
  triangle(width/2,(height/2)-offset,xcoord,(height/2)-offset-bwidth,xcoord,(height/2)-offset+bwidth);
  
  fill(168,255,0);
  text("Height : "+str(H)+height_units, 50, height-100);
  text("Speed  : "+str(S)+speed_units, 50, height-50); 
}