import gifAnimation.*;
import java.util.*;
PImage entryBG,BGimg, net;
Gif ball;
float ballX =50, ballY = 0;
float ballVx= 0, ballVy = 10;
Gif Player1, Player2, p1Jump,p2Jump,killBall1,killBall2,winPose,losePose;
float player1X = 0, player1Y = 700,player1V=0;
float player2X =1600,player2Y=700,player2V =0;
int p1Score = 0, p2Score = 0;
int up1 = 0, down1 = 0, left1 = 0, right1 = 0;
int up2 = 0, down2 = 0, left2 = 0 , right2 = 0;
int power1 = 15, power2 = 15;
int die = 0;
boolean ballKill = false;
boolean gameEnd = false, p1Win = false, p2Win = false;
int whoballhit = 0;
boolean entry = false;


void setup()
{
    size(1800,900);
    BGimg = loadImage("images/background.jpg");
    entryBG = loadImage("images/ok_entry_background.jpg");
    net = loadImage("images/net.PNG");
    ball = new Gif(this, "images/pokeball.gif");
    killBall1 = new Gif(this, "images/thunder-ball-unscreen.gif");
    killBall2 = new Gif(this,"images/thunder-ball-unscreen.gif");
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
}

void draw()
{
    if(entry == false)
    {
        background(entryBG);
        fill(255,0,0); textSize(75); text("Final Project of",500,300);
        fill(255,0,0); textSize(50); text("Design-of-Embedded-Microprocessor-Systems",400,450);
        fill(0,0,255); textSize(50); text("Press P to Start Game",500,750);  
    }
  else
  {
    background(BGimg);
    image(net,900,550,40,350);
    if(ballKill == true){
      if(whoballhit == 1)
      {
         image(killBall1,ballX,ballY,200,150);
      }
      else if (whoballhit == 2)
      {
         image(killBall2,ballX,ballY,200,150);
      }
    }
    else{image(ball,ballX,ballY,200,150);}
    
    
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
    
    // draw player 1 and player2
    if(player1Y != 700){image(p1Jump,player1X,player1Y,200,200);} // do jump operation
    else{ image(Player1,player1X,player1Y,200,200);}
    if(player2Y != 700){image(p2Jump,player2X,player2Y,200,200);} // do jump operation
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
    
    // deal with ball condition
    
    
    // ball animation
        
    if(ballY > 800)
    {
       update();
    }
    
    // Game over
    
    if(gameEnd == true)
    {
      if(p1Win == true)
      {
        image(winPose,player1X,player1Y,200,200);
        image(losePose,player2X,player2Y,200,200); 
      }
      else
      {
         image(winPose,player2X,player2Y,200,200); 
         image(losePose,player1X,player1Y,200,200); 
      }
 
    }
    
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
  }
    
}

void keyPressed()
{
  if(keyCode == UP){if(player2Y == 700){player2V = -30;}}  
  if(keyCode == RIGHT){right2 = 1;}
  if(keyCode == DOWN){down2 = 1;}
  if(keyCode == LEFT){left2 = 1;}
  if(keyCode == 'L'){ power2 = 30;}
  if(keyCode == 'W'){if(player1Y == 700){player1V = -30;}}
  if(keyCode == 'D'){right1 = 1;}
  if(keyCode == 'S'){down1 = 1;}
  if(keyCode == 'A'){left1 = 1;}
  if(keyCode == 'B'){ power1 = 30;}
  if(keyCode == 'P'){entry = true;}
}
void keyReleased()
{
  if(keyCode == UP){}  
  if(keyCode == RIGHT){right2 = 0;}
  if(keyCode == DOWN){down2 = 0;}
  if(keyCode == LEFT){left2 = 0;}
  if(keyCode == 'L'){ power2 = 15;}
  if(keyCode == 'W'){}
  if(keyCode == 'D'){right1 = 0;}
  if(keyCode == 'S'){down1 = 0;}
  if(keyCode == 'A'){left1 = 0;}
  if(keyCode == 'B'){power1 = 15;}
  if(keyCode == 'P'){}
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
      gameEnd = true;
      if(p1Score == 15)
      {
         p1Win = true; 
      }
      else
      {
         p2Win = true; 
      }
   }
   
   ballX = 50; ballY = 0;
   ballVx= 0; ballVy = 10;
   player1X = 0; player1Y = 700;player1V=0;
   player2X = 1600; player2Y = 700;player2V=0;
}
