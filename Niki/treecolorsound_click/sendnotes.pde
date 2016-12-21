
void sendNotes() {  
  int channel = int(random(0, 4));
  int pitch = 64+int(random(0, 10));
  int velocity = 127;
  int number = 0;
  int speakerNumber= int(random(0, 127));


  //for (int i=0; i < channels.length; i ++){

  myBus.sendControllerChange(channel, number, speakerNumber); // Send a controllerChange
  delay(20);    

  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  delay(20);
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}