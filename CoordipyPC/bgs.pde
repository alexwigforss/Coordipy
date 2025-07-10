int mods = 0, i=0;  int opP = 0;  int opN = 200;
int[] wArray = new int[5];    int[] hArray = new int[5];
int[] wghArray = new int[5];  int[] hghArray = new int[5];
int[] wStars = new int [40];  int[] hStars = new int [40];

int gridSize = 40, movX = width/2, movY = height/2;
float q=1.0, z = 0.0, movF = height/2, roler;// float incs = TWO_PI/20.0;
float heightvar, widthvar=width/2;boolean xdir, ydir;

int rad = 60; float xpos1, ypos1, xpos2, ypos2;
float xspeed = 1.5, yspeed = 1.0, xspe3d = 2.0, yspe3d = 1.5;
int xdirection = 1, ydirection = 1, xdirection2 = 1, ydirection2 = 1;

float movlx = 0, neglx; boolean direction = true;
boolean directionq = true;
int PNR = 0;//  int opP = 0;  int opN = 200;
boolean bgdir = true;  float itt = 0.0;

PImage bg;

void drawbg01() {
  noStroke();rectMode(CENTER);
  for (int i = 0; i < 10; i= i+1)  {
    float ang1 = radians(angle1);
    rotate(-ang1);
      fill(map(i,2,10,0,255),alpha);
      if (movdir == true)  {
        rect(mod, 0, map(i,2,10,width,0), map(i,2,10,width,0));
      }  else if (movdir == false)  {
        rect(mod, 0, map(i,2,10,width,0), map(i,2,10,width,0));
      }
          rotate(ang1);
  }
}

void drawbg02() {
  float ang1 = radians(angle1);
  rotate(ang1);
  noStroke();fill(255,alpha/8);
  for (int y = 2; y <= height; y += 80) {
    for (int x = 2; x <= width; x += 80) {
      if ((x % 32) == 0) {
        ellipse(x, y, mod+x, mod+y);
      } 
      else {
        ellipse(y, x, mod+x, mod+y);
      }
    }
  }
  rotate(-ang1);
}

void drawbg03()  {
  q = (q+0.01) % TWO_PI;
  rotate(q);
  stroke(255, alpha);  fill(0,alpha/4);
  rectMode(CENTER);
  for (int x = 0; x <= width; x += gridSize) {
    rect(x,x,movY,movY);
    rect(x/2,x/2,movY/2,movY/2);
  }
if (direction == true)  {
    movY++;
    if (movY>=height)  {  direction=false;  }
  }
    else if(direction == false)  {
    movY--;
    if (movY<=0)  {direction=true;}
  }
  rotate(-q);
}  

void drawbg04()  {
  stroke(255, alpha/2);  noFill();  rectMode(CENTER);
  movF = int(movY);
  q = map(abs(movF),0,height,1.5,2.0);
  if (q>=4)  { q=1.0; }
      pushMatrix();

  for (int x = 0; x <= width; x += gridSize*2) {
    for (int y = 0; y <= height; y += gridSize*2) {
      line(x, y, width/2, map(movY,0,height,height,0));
      line(x, y, width/4, movY);
      line(x, y, width/4*3, movY);

    }
  }
        popMatrix();
if (directionq == true)  {
    movY = movY + 2;
    if (movY>=height)  {  directionq=false;  }
  }
    else if(directionq == false)  {
    movY = movY - 2;
    if (movY<=0)  {directionq=true;}
  }
}

void bg05math()  {
  if (ydir == false)  {widthvar=widthvar+1;  if (widthvar >= width)  {  ydir=!ydir;  }}
  else if (ydir == true)  {widthvar=widthvar-1;  if (widthvar <= 0)  {  ydir=!ydir;  }}
  if (xdir == false)  {heightvar=heightvar+1;  if (heightvar >= height)  {  xdir=!xdir;  }}
  else if (xdir == true)  {heightvar=heightvar-1;  if (heightvar <= 0)  {  xdir=!xdir;  }}
}

void bg05drawer()  {
  rotate(map(roler,0,width,0,TWO_PI));
  fill(0,alpha/4);
  for (float y = 0 ; y < 10; y++)  {
    stroke(255,map(y,0,10,alpha,0));
    ellipse(widthvar,height/2, widthvar-y*40, widthvar-y*40);
    ellipse(map(widthvar,0,width,width,0),height/2, widthvar-y*40, widthvar-y*40);
  }
  for (float y = 0 ; y < 10; y++)  {
    stroke(255,map(y,0,10,alpha,0));
    ellipse(width/2,widthvar, heightvar-y*40, heightvar-y*40);
    ellipse(width/2,map(widthvar,0,height,height,0), heightvar-y*40, heightvar-y*40);
  }
  rotate(-map(roler,0,width,0,TWO_PI));
}

void drawbg06() 
{
  // Update the position of the shape
  xpos1 = xpos1 + ( xspeed * xdirection );  ypos1 = ypos1 + ( yspeed * ydirection );
  xpos2 = xpos2 + ( xspe3d * xdirection2 );  ypos2 = ypos2 + ( yspe3d * ydirection2 );
  
  // Test to see if the shape exceeds the boundaries of the screen
  if (xpos1 > width-rad || xpos1 < rad) {    xdirection *= -1;  }
  if (ypos1 > height-rad || ypos1 < rad) {    ydirection *= -1;  }
  if (xpos2 > width-rad || xpos2 < rad) {    xdirection2 *= -1;  }
  if (ypos2 > height-rad || ypos2 < rad) {    ydirection2 *= -1;  }

  noFill();

  // Draw the shape
  for (int i = 255;i > 0; i = i - 20)  {
    stroke(i,alpha);
    ellipse(xpos1, ypos1, i*3, i*2);
    ellipse(xpos2, ypos2, i*3, i*2);
  }
}

void drawbg07() {
  stroke(255,alpha);  noFill();

  if (direction == true)  {
    for (int i = 0; i < 200; i += 20) {
      bezier(movlx-(i*4.0), 0, 410, 20, 440, 300, neglx-(i*16.0), height+(i/8.0));
      bezier(neglx-(i*4.0), 0, 210,220, 440, 300, movlx-(i*16.0), height+(i/8.0));
    }
  }  else if (direction == false)  {
    for (int i = 0; i < 200; i += 20) {
      bezier(neglx-(i*4.0), 0, 410, 20, 440, 300, movlx-(i*16.0), height+(i/8.0));
      bezier(movlx-(i*4.0), 0, 210,220, 440, 300, neglx-(i*16.0), height+(i/8.0));
    }
  }

  movlx = (movlx + 1) % (width*2);
  neglx = map(movlx,0,width*2,width*2,0);
  if ((movlx <= 0) || (neglx <= 0))  {  direction = !direction;  }
}

void stars()  {  
  if (mods == 0) {  getArray();  }
    strokeWeight(1);
    for (int a = 0;a < 40; a++)  {
      stroke(random(50,alpha*4));
      point(wStars[a],hStars[a]);
  }
  for (int a = 0;a < 5; a++) {
    point(random(0, width),random(0, height));
    strokeWeight(random(0,6));stroke(255,random(0,40));
    point(wArray[a], hArray[a]);
    strokeWeight(random(0,4));stroke(255,random(0,20));
    point(wghArray[a], hghArray[a]);
  }
  strokeWeight(1);
  mods = (mods + 1) % 80;
}

void getstars()  {
  for (int a = 0;a < 40; a++)  {
    wStars[a] = int(random(0,width));
    hStars[a] = int(random(0,width));
  }
}

void getArray() {
  for (int a = 0;a < 5; a++) { 
    wghArray[a] = wArray[a];
    wArray[a] = int(random(0, width));
  }
  for (int a = 0;a < 5; a++) { 
    hghArray[a] = hArray[a];
    hArray[a] = int(random(0, height));
  }
}
