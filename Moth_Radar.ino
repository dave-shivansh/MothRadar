#include <VSync.h>

//  Create a new sender here
//  Put the number of variables you want to sync in the pointy brackets
//  Here we just want to sync one value
ValueSender<2> sender;

//  here we store the value we read from analog bin A0
int H;
int S;

unsigned long timer = 0;
int sync_interval = 200;

void setup()
{
  Serial.begin(115200);

  //  Tell the sending syncronizer what variable needs to be kept in sync.
  //  In this case it is just the variable 'analogValue' but if you sync more,
  //  you need to make sure to use the same order on the sending and the receiving side.
  sender.observe(H);
  sender.observe(S);
}

void loop()
{
 S = random(-10,11);
 H = random(25,100);

 if (millis()-timer >= sync_interval){
  sender.sync();
  timer = millis();
 }
 
}




