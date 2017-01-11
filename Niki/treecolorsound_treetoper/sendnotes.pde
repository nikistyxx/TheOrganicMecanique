
void sendNotes(int speakerNumber) {  
  int[] channel = new int[4];
  int pitch = 64+int(random(0,10));
  int velocity = 127;
  int number = 0;
  //int speakerNumber= int(random(0,127));
  

  for (int i=0; i < channel.length; i ++){
  
  myBus.sendControllerChange(channel[0], number, speakerNumber); // Send a controllerChange
  delay(20);    

  myBus.sendNoteOn(channel[0], pitch, velocity); // Send a Midi noteOn
  delay(20);
  myBus.sendNoteOff(channel[0], pitch, velocity); // Send a Midi nodeOff
  
  }
 
  

  
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}