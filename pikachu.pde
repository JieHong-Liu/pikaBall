import gifAnimation.*;
PImage BGimg, net;
Gif ball;
float ballX =50, ballY = 0;
float ballVx= 0, ballVy = 10;
Gif Player1, Player2, p1Jump,p2Jump;
float player1X = 0, player1Y = 700,player1V=0;
float player2X =1600,player2Y=700,player2V =0;
int up1 = 0, down1 = 0, left1 = 0, right1 = 0;
int up2 = 0, down2 = 0, left2 = 0 , right2 = 0;
int die = 0;
void setup()
{
    die = 0;
    size(1800,900);
    BGimg = loadImage("images/background.jpg");
    net = loadImage("images/net.PNG");
    ball = new Gif(this, "images/pokeball.gif");
    ball.loop();
    Player1 = new Gif(this, "images/pikawalk1-unscreen.gif");
    Player2 = new Gif(this, "images/pikawalk2-unscreen.gif");
    p1Jump = new Gif(this, "images/pikajump1-unscreen.gif");
    p2Jump = new Gif(this, "images/pikajump2-unscreen.gif");
    // let the gif loop
    Player1.loop();
    Player2.loop();
    p1Jump.loop();
    p2Jump.loop();
}

void draw()
{
    background(BGimg);
    image(net,920,550,40,350);
    image(ball,ballX,ballY,200,150);
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
    if(ballX > (920-150) && ballX < 960) // touch the net
    {
        if(ballY > 450 && ballY <= 550)
        {
           ballVy = -ballVy; // let the y be the negative direction.
           ballVx = -ballVx;  
        }
        else if (ballY > 550)
        {
           ballVy = ballVy;
           ballVx = -ballVx;  
        }
        else
        {
           ballVx = ballVx; 
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
    
    if(ballY > 800)
    {
      //update();
    }
    
    if(dist(player1X,player1Y,ballX,ballY) < 150)
    {
       PVector dir = new PVector(ballX-player1X, ballY-player1Y);
       dir.normalize();
       dir.mult(15);
       ballVx = dir.x;
       ballVy = dir.y;
    }
    
    if(dist(player2X,player2Y,ballX,ballY) < 150)
    {
       PVector dir = new PVector(ballX-player2X, ballY-player2Y);
       dir.normalize();
       dir.mult(15);
       ballVx = dir.x;
       ballVy = dir.y;
    }
}

void keyPressed()
{
  if(keyCode == UP){if(player2Y == 700){player2V = -30;}}  
  if(keyCode == RIGHT){right2 = 1;}
  if(keyCode == DOWN){down2 = 1;}
  if(keyCode == LEFT){left2 = 1;}
  if(keyCode == 'W'){if(player1Y == 700){player1V = -30;}}
  if(keyCode == 'D'){right1 = 1;}
  if(keyCode == 'S'){down1 = 1;}
  if(keyCode == 'A'){left1 = 1;}
}
void keyReleased()
{
  if(keyCode == UP){}  
  if(keyCode == RIGHT){right2 = 0;}
  if(keyCode == DOWN){down2 = 0;}
  if(keyCode == LEFT){left2 = 0;}
  if(keyCode == 'W'){}
  if(keyCode == 'D'){right1 = 0;}
  if(keyCode == 'S'){down1 = 0;}
  if(keyCode == 'A'){left1 = 0;}
}

void update()
{
   ballX = 50; ballY = 0;
   ballVx= 0; ballVy = 10;
   player1X = 0; player1Y = 700;player1V=0;
   player2X = 1600; player2Y = 700;player2V=0;
}
