import processing.serial.*;
Serial serial;

import gifAnimation.*;
import java.util.*;
PImage entryBG,BGimg, net,mount,sky,mnt_gnd,gnd,left_bound,right_bound,gndSea,cloud;
Gif ball;
float ballX =50, ballY = 0;
float ballVx= 0, ballVy = 10;
Gif Player1, Player2, p1Jump,p2Jump,killBall1,killBall2,winPose,losePose,p1HitBall,p2HitBall;
float player1X = 0, player1Y = 700,player1V=0;
float player2X =1600,player2Y=700,player2V =0;
int p1Score = 0, p2Score = 0;
int up1 = 0, down1 = 0, left1 = 0, right1 = 0,hit1 = 0;
int up2 = 0, down2 = 0, left2 = 0 , right2 = 0, hit2= 0;
int power1 = 15, power2 = 15;
int die = 0;
boolean ballKill = false;
boolean p1Win = false, p2Win = false;
int whoballhit = 0;

Cloud[] clouds;


public enum State
{
    ENTRY, GAMING, END;
}
private State gameStatus = State.ENTRY; 

void setup()
{
    serial = new Serial(this,"COM3",9600);
    size(1800,900);
    BGimg = loadImage("images/gameBG.jpg");
    entryBG = loadImage("images/entry_background.jpg");
    mount = loadImage("images/ok_mount.jpg");
    mnt_gnd = loadImage("images/ok_mnt_gnd.jpg");
    gndSea = loadImage("images/gndSea.jpg");
    left_bound = loadImage("images/left_bound.jpg");
    right_bound = loadImage("images/right_bound.jpg");
    sky = loadImage("images/ok_sky.jpg");
    net = loadImage("images/net.PNG");
    gnd = loadImage("images/ok_gnd.jpg");
    cloud = loadImage("images/cloud.png");

    ball = new Gif(this, "images/pokeball.gif");
    //ball = new Gif (this,"images/pin.gif");
    killBall1 = new Gif(this, "images/thunder-ball-unscreen.gif");
    killBall2 = new Gif(this,"images/thunder-ball-unscreen.gif");
    p1HitBall = new Gif(this,"images/pikahit1-unscreen.gif");
    p2HitBall = new Gif(this,"images/pikahit2-unscreen.gif");
    Player1 = new Gif(this, "images/pikawalk1-unscreen.gif");
    Player2 = new Gif(this, "images/pikawalk2-unscreen.gif");
    p1Jump = new Gif(this, "images/pikajump1-unscreen.gif");
    p2Jump = new Gif(this, "images/pikajump2-unscreen.gif");
    winPose = new Gif(this,"images/pikaWin.gif");
    losePose = new Gif(this,"images/pikaLose.gif");
    // let the gif loop
    ball.loop();
    Player1.loop();
    Player2.loop();
    p1Jump.loop();
    p2Jump.loop();
    killBall1.loop();
    killBall2.loop();
    winPose.loop();
    losePose.loop();
    p1HitBall.loop();
    p2HitBall.loop();
    
    clouds = new Cloud[5];
    for(int i = 0; i < 5; i ++)
    {
        clouds[i] =  new Cloud(random(0,1800),random(0,450)); 
    }
}

void draw()
{
  
  switch(gameStatus)
  {
      case ENTRY:
      {
         background(entryBG);
         fill(255,255,255); textSize(75); text("Final Project of",200,300);
         fill(255,255,255); textSize(50); text("Design-of-Embedded-Microprocessor-Systems",200,450);
         fill(0,0,255); textSize(50); text("Press P to Start Game",500,750);
         initialParameter();
         break;
      }
      case GAMING:
      {
          background(BGimg);
          for(int i = 0 ; i< 5; i++)
          {
             clouds[i].update(); 
          }
          if(ballKill == true)
          {
              if(whoballhit == 1)
              {   
                 image(killBall1,ballX,ballY,200,150);
              }
              else if (whoballhit == 2)
              {
                 image(killBall2,ballX,ballY,200,150);
              }
          }
          else  
          {
              image(ball,ballX,ballY,200,150);
          }
          ballX += ballVx;
          ballY += ballVy;
          if(ballY < 0 || ballY > 800)
          {
             ballVy = -1 * ballVy; 
          }
          if(ballX < 0)
          {
             ballX = 0;
             ballVx = -1 * ballVx; 
          }
          else if (ballX > 1700)
          {
             ballX = 1700;
             ballVx = -1 * ballVx;
          }
          
          // deal with the net
          if(ballX>900-100 && ballX < 900)
          {
             if(ballY > 450)
             {
                ballVx = -ballVx; 
             }
             else if (ballY > 400)
             {
                ballVy = -ballVy; 
             }
            
          }
          
         buttonCtrl();

          // draw player 1 and player2
          if(hit1 == 1){image(p1HitBall,player1X,player1Y,200,200);}
          else if(player1Y != 700){image(p1Jump,player1X,player1Y,200,200);} // do jump operation
          else{ image(Player1,player1X,player1Y,200,200);}
      
          if(hit2 == 1){image(p2HitBall,player2X,player2Y,200,200);}
          else if(player2Y != 700){image(p2Jump,player2X,player2Y,200,200);} // do jump operation
          else{ image(Player2,player2X,player2Y,200,200);}    
          
          // control players
              
          // players jump
          if(player1V != 0 && player1Y <= 700) 
          {
              player1Y = player1Y + player1V;
              player1V = player1V + 0.98; // g = 9.8
          } 
          
          if(player2V != 0 && player2Y <= 700) 
          {
              player2Y = player2Y + player2V;
              player2V = player2V + 0.98; // g = 9.8
          }
          
          // players move
          if(right1 == 1)
          {
             player1X += 10; 
          }
          if(left1 == 1)
          {
             player1X -= 10; 
          }
          if(right2 == 1)
          {
             player2X += 10; 
          }
          if(left2 == 1)
          {
             player2X -= 10; 
          }
               
          
          // deal with border condition
          if(player1Y >= 700) {player1Y = 700;} //   jump correction
          if(player2Y >= 700) {player2Y = 700;} //   jump correction
          if(player1X <= 0) {player1X = 0;}
          else if(player1X >= 720) {player1X = 720;}
          if(player2X <= 960) {player2X = 960;}
          else if(player2X >= 1600) {player2X = 1600;}

          // record score
          fill(255,0,0); textSize(100);text(p1Score,100,150);
          fill(255,0,0); textSize(100);text(p2Score,1600,150);
          
          if(dist(player1X,player1Y,ballX,ballY) < 150)
          {
             PVector dir = new PVector(ballX-player1X, ballY-player1Y);
             dir.normalize();
             dir.mult(power1);
             ballVx = dir.x;
             ballVy = dir.y;
             if(power1 != 15) {ballKill = true; whoballhit = 1;}
             else{ballKill =false; whoballhit = 0; }
          }
          
          if(dist(player2X,player2Y,ballX,ballY) < 150)
          {
             PVector dir = new PVector(ballX-player2X, ballY-player2Y);
             dir.normalize();
             dir.mult(power2);
             ballVx = dir.x;
             ballVy = dir.y;
             if(power2 != 15) {ballKill = true; whoballhit = 2;}
             else{ballKill =false; whoballhit = 0; }  
          }

          // deal with ball condition              
          if(ballY > 800)
          {
             update();
          }
   
          break;
      }
      case END:
      {
        
        // final screen
        background(BGimg);
        fill(255,0,0); textSize(100);text(p1Score,100,150);  
        fill(255,0,0); textSize(100);text(p2Score,1600,150);
          
        // Game over
        if(p1Score == 3)
        {
           p1Win = true; 
        }
        else
        {
           p2Win = true; 
        }
      
        if(p1Win == true)
        {
            fill(255,0,0); textSize(100);text("P1 WIN!!!",700,250);
            image(winPose,player1X,player1Y,200,200);
            image(losePose,player2X,player2Y,200,200); 
        }
        else
        {
            fill(255,0,0); textSize(100);text("P2 WIN!!!",700,250);
            image(winPose,player2X,player2Y,200,200); 
            image(losePose,player1X,player1Y,200,200); 
        }
        fill(255,255,255); textSize(30); text("Press E to back to Start MENU",700,400);
        break; 
      }
      default:
          break;
  }
    
}

void keyPressed()
{
  if(keyCode == UP){if(player2Y == 700){player2V = -30;}}  
  if(keyCode == RIGHT){right2 = 1;}
  if(keyCode == DOWN){down2 = 1;}
  if(keyCode == LEFT){left2 = 1;}
  if(keyCode == 'L'){ hit2 = 1; power2 = 30;}
  if(keyCode == 'W'){if(player1Y == 700){player1V = -30;}}
  if(keyCode == 'D'){right1 = 1;}
  if(keyCode == 'S'){down1 = 1;}
  if(keyCode == 'A'){left1 = 1;}
  if(keyCode == 'B'){ hit1 = 1; power1 = 30;}
  if(keyCode == 'P')
  {
      if(gameStatus == State.ENTRY)
      {
          gameStatus = State.GAMING;
      }  
  }
  if(keyCode == 'E')
  {
      if(gameStatus == State.END)
      {
          gameStatus = State.ENTRY;
      }  
  }
}
void keyReleased()
{
  if(keyCode == UP){}  
  if(keyCode == RIGHT){right2 = 0;}
  if(keyCode == DOWN){down2 = 0;}
  if(keyCode == LEFT){left2 = 0;}
  if(keyCode == 'L'){hit2= 0; power2 = 15;}
  if(keyCode == 'W'){}
  if(keyCode == 'D'){right1 = 0;}
  if(keyCode == 'S'){down1 = 0;}
  if(keyCode == 'A'){left1 = 0;}
  if(keyCode == 'B'){hit1 = 0;power1 = 15;}
  if(keyCode == 'P'){}
  if(keyCode == 'E'){}
}

void update()
{
   ballKill = false;
   if(ballX < 900)
   {
      p2Score ++;
   }
   else
   {
      p1Score ++; 
   }
   
   if(p1Score == 3 || p2Score == 3)
   {
      gameStatus = State.END;
      return;
   }
   
   // setting player and ball to its right position.
   ballX = 50; ballY = 0;
   ballVx= 0; ballVy = 10;
   player1X = 0; player1Y = 700;player1V=0;
   player2X = 1600; player2Y = 700;player2V=0;
}

void initialParameter()
{
    ballX =50;ballY = 0;
    ballVx= 0; ballVy = 10;
    player1X = 0; player1Y = 700;player1V=0;
    player2X = 1600;player2Y=700;player2V =0;
    p1Score = 0; p2Score = 0;
}

void drawBackGround()
{
    for(int i = 0 ; i< 1800; i+=50)
    {
       for(int j = 0 ; j < 550 ; j+=50)
       {
          image(sky,i,j); 
       }
    }
    image(mount,0,550);
    
    for(int i = 0 ; i < 1800; i+=50)
    {
       image(mnt_gnd,i,750); 
    }
    
    image(left_bound,0,800);
    image(right_bound,1700,800);
    for(int i = 100 ; i < 1700; i+=100) // draw line and ground 
    {
       image(gnd,i,800); 
    }
    for(int i = 0 ; i < 1800; i+=100)
    {
       image(gndSea,i,850); 
    }
    image(net,900,550,40,275);
}


class Cloud
{
    float x,y;
    // constructor
    Cloud(float x1,float y1 )
    {
        x = x1;
        y = y1;
    }
    void update()
    {
        float speed = 10;
        x = x + speed;
        if(x >= 1800) x = 0;
        image(cloud,x,y);     
    }
  
}

void buttonCtrl()
{
  if(serial.available() > 0)
  {
      int serialData = serial.read();
      if(serialData == 60) // right signal
      {
         right1 = 1;
      }
      else if (serialData == 65)
      {
         right1 = 0; 
      }
      
      if (serialData == 40)
      {
         left1 = 1;
      }
      else if (serialData == 45)
      {
         left1 = 0; 
      }
      
      if (serialData == 50)
      {
         if(player1Y == 700){player1V = -30;}
      }
      
      if(serialData == 70)
      {
         hit1 = 1; power1 = 30; 
      }
      else if (serialData == 75)
      {
         hit1 = 0;power1 = 15;
      }

  }
 
}
