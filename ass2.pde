void setup()
{
  size(800, 800);
  background(#006600);
  frameRate(5);  
}
boolean welcome=true;
int headX=200,headY=400;
int[][] body = new int[11][2]; // 0 is X value, 1 is Y value from the arrays.
int direction,over=0;  
void draw()
{
  background(#006600);
  drawgrid();
  switch(direction){
    case 0:
     snakehead(headX,headY);
     break;
  case 1:
    pushMatrix();
      translate(headX,headY);
      rotate(degrees(0));
      snakehead(0,0);
      popMatrix();
      break;
  case 2:
    pushMatrix();
      translate(headX,headY);
      rotate(PI);
      snakehead(0,0);
      popMatrix();
      break;
  case 3:
    pushMatrix();
      translate(headX,headY);
      rotate((3*PI)/2);
      snakehead(0,0);
      popMatrix();
      break;
  case 4:
    pushMatrix();
      translate(headX,headY);
      rotate(PI/2);
      snakehead(0,0);
      popMatrix();
      break;
  }
  apple(40,30);
  counter();
  apple(appleX,appleY);
   if(headX==appleX && headY==appleY){
    appleX=cellX[int(random(cellX.length-1))]; appleY=cellY[int(random(cellY.length-1))];
    eaten++;
  }
  if(eaten>=1){
    bodyposition();
  }
  if(welcome == true){ // to draw welcome screen 
    welcomescreen();
  }
  if(key == CODED){ //The code to close the welcome screen...
  if(keyCode == SHIFT){
    welcome=false;
  }}
  if(headX<20 || headX>780 || headY<60 || headY>780){
    gameover();
    textSize(20);
    text("-:> Next time, Try Stopping At the Borders.",200,420);
  }
  if(eaten==10){
    win();
  }
  
  switch(direction){
  case 1:
      body[0][0] = headX;
      body[0][1]=headY;
      headX+=40;
      break;
  case 2:
      body[0][0] = headX;
      body[0][1]=headY;
      headX-=40;
      break;
  case 3:
      body[0][0] = headX;
      body[0][1]=headY;
      headY-=40;
      break;
 case 4:
      body[0][0] = headX;
      body[0][1]=headY;
      headY+=40;
      break;
  }
  selfcollision();
}
void keyPressed()
{
  if(eaten>=1){
  if(keyCode==RIGHT && direction!=2)  {
     direction=1;
    }
    if(keyCode==LEFT && direction!=1){
     direction=2;
    }
    if(keyCode==UP && direction!=4){
      direction=3;
    }
    if(keyCode==DOWN && direction!=3){
      direction=4;
    }}
    else   {
      if(keyCode==RIGHT){
     direction=1;
    }
    if(keyCode==LEFT){
     direction=2;
    }
    if(keyCode==UP){
      direction=3;
    }
    if(keyCode==DOWN){
      direction=4;
    }
    }
    if(over==1){
    if(keyCode==SHIFT){
      loop();
     appleX=cellX[int(random(cellX.length-1))]; appleY=cellY[int(random(cellY.length-1))];
      headX=width/2;headY=height/2;
      eaten=0;
      for (int i = body.length - 1; i > 0; i--) {
    body[i][0] = 0;
    body[i][1] = 0;
   }
   over=0;
    }}
}

void selfcollision(){
  for(int i=0;i<=eaten;i++){
  if(headX==body[i][0] && headY==body[i][1]){
    gameover();
    textSize(20);
    text("-:> Next time, Try Not To Hit Yourself.",170,420);
    text("I know You like yourself,  but stop hitting on yourself .",170,450);
    text("So, Try Again, and Go win..",170,480);
  }
  }
}

void bodyposition(){
  if(eaten>=1)
  strokeWeight(1);
  stroke(0);
  fill(#0000ff); 
   for (int i = body.length - 1; i > 0; i--) {
    body[i][0] = body[i - 1][0];
    body[i][1] = body[i - 1][1];
   }
   for(int i=0;i<=eaten;i++)
   {
     circle(body[i][0],body[i][1],50);
   }
   
}

void counter()
{
  fill(0);
  textSize(30);
  text(eaten,70,40);
}
int[] cellX = {40,80,120,160,200,240,280,320,360,400,440,480,520,560,600,640,680,720,760};
int[] cellY = {80,120,160,200,240,280,320,360,400,440,480,520,560,600,640,680,720,760};

int appleX=cellX[int(random(18))],appleY=cellY[int(random(17))],eaten=0;

void apple(int x,int y)
{
  noStroke();
  fill(#ff0000);
  circle(x,y,40);
  stem(x,y);
}
void stem(int x,int y){
  strokeWeight(3);
  stroke(#00ff00);
  line(x,y-5,x,y-25);
}

void snakehead(int x,int y) //The main character of the game, snakes head is drawn using this function..
{
  stroke(0);
  strokeWeight(1);
  fill(#0000ff);
  circle(x,y,65);
  circle(x+5,y-5,8);
  circle(x+5,y+5,8);
  fill(255);
  ellipse(x-15,y-10,20,15);
  ellipse(x-15,y+10,20,15);
  fill(0);
  ellipse(x-12,y-10,14,13);
  ellipse(x-12,y+10,14,13);
    tongue(x,y);
}

void tongue(int X,int Y) // Just to make a different stroke for the tongue of the snake..
{
  stroke(255,0,0);
  strokeWeight(2);
  line(X+20,Y,X+40,Y);
}


void gameover()
{
  noStroke();
  fill(#33cccc);
  rect(160,200,480,400);
  fill(#0a2c2c);
  textSize(50);
  text("Game Over",290,280);
  textSize(30);
  text("Click Shift to play again...",200,380);
  text("Score :"+eaten,200,315);
  over=1;
  noLoop();
}

void win()
{
  noStroke();
  fill(#33cccc);
  rect(160,200,480,320);
  fill(#0a2c2c);
  textSize(35);
  text("Congratulations, YOU WON!!",200,280);
  textSize(30);
  text("Click Shift to play again...",200,380);
  text("Score :"+eaten,200,315);
  over=1;
  noLoop();
}
void welcomescreen() // draws the welcome screen..
{
  noStroke();
  fill(#33cccc);
  rect(160,200,480,400);
  fill(#0a2c2c);
  textSize(20);
  text("Welcome to Snake.io",300,230);
  text(":: How to play ::",170,315);
  text("****************************************************",170,340);
  text("-} Move using the up, down, left, and right arrow keys..",170,365);
  text("-} Don't wanna lose? Avoid hitting yourself and border.",170,420);
  text("-} Wanna win? Eat 10 apples, simple.",170,490);
  text("--} Ready ,\"Shift\", Go.",170,570);
  
}
void drawgrid() // Just calls the function drawcells and puts in the values, also makes the side rectangles to make the border..
{
  noStroke();
  int gridX=20, gridY=60;
  drawcell(gridX, gridY, true);
  drawcell(20,100,false);
  fill(#006600);
  rect(780,60,20,740);
  rect(20,780,760,20);
}
void drawcell(int darkx, int darky, boolean colour) // Makes each and every cell in the grid..
{
  color lightgreen = color(#99ff99);
  color darkgreen = color(#33cc33);
  while (darkx<=width)
  {
    while (darky<=height)
    {
      if(colour==true)
      fill(darkgreen);
      else 
      fill(lightgreen);
      square(darkx, darky, 40);
      darky+=height/10;
    }
    if (darky>780)
    {
      darky=darky-720-40;
    }
    darkx+=width/20;
  }
}
