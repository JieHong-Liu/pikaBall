bool buttonRightUp = true;
bool buttonJumpUp = true;
bool buttonLeftUp = true;
bool buttonKillUp = true;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(7, INPUT);
  digitalWrite(7, HIGH);
  pinMode(6, INPUT);
  digitalWrite(6, HIGH);
  pinMode(5, INPUT);
  digitalWrite(5, HIGH);
  pinMode(4, INPUT);
  digitalWrite(4, HIGH);
  pinMode(13, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  
  if(digitalRead(7) != HIGH && buttonLeftUp == true)
  {
    Serial.write(40); // LEFT;
    buttonLeftUp = false;
  }
  else if (digitalRead(7) == HIGH && buttonLeftUp == false)
  {
      buttonLeftUp = true;  // left release signal. 
      Serial.write(45);
  }
  else if (digitalRead(7) != HIGH && buttonLeftUp == false)
  {
      Serial.write(40); // LEFT;
  }


  if(digitalRead(6) != HIGH && buttonJumpUp == true)
  {
    Serial.write(50); // JUMP;
    buttonJumpUp = false;
  }
  else if (digitalRead(6) == HIGH && buttonJumpUp == false)
  {
      buttonJumpUp = true;  // jump release signal. 
      Serial.write(55);
  }
  else if (digitalRead(6) != HIGH && buttonJumpUp == false)
  {
    Serial.write(50); // JUMP;
  }



  if(digitalRead(5) != HIGH && buttonRightUp == true)
  {
    Serial.write(60); // RIGHT;
     buttonRightUp = false;
  }
  else if (digitalRead(5) == HIGH && buttonRightUp == false)
  {
      buttonRightUp = true;  // RIGHT release signal. 
      Serial.write(65);
  }
  else if (digitalRead(5) != HIGH && buttonRightUp == false)
  {
    Serial.write(60); // RIGHT;
  }


  if(digitalRead(4) != HIGH && buttonKillUp == true)
  {
    Serial.write(70); // KILL;
     buttonKillUp = false;
  }
  else if (digitalRead(4) == HIGH && buttonKillUp == false)
  {
      buttonKillUp = true;  // KILL release signal. 
      Serial.write(75);
  }
  else if (digitalRead(4) != HIGH && buttonKillUp == false)
  {
    Serial.write(70); // RIGHT;
  }
  delay(100);
}
