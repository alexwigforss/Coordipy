int scX,scY;float rotate = 0;int hw, hh;  //Variables Scores

float radiuq = 1.0;float mod=0.082;float xxx, yyy; //blackHoleSvirl

int numFrames = 8;int fourthFrame;int frame = 0;  //robostuff
PImage[] images = new PImage[numFrames];

int sundist = ballSize/3;
int sdist = sundist;

int pnr = 3;
float[] ppos = new float [pnr];
float[] pspeed = new float [pnr];
float[] psize = new float [pnr];
float rotX = 0.0;

float radius = 10;
PVector[] thorns = new PVector[ 8 ];
float angle = TWO_PI / thorns.length;
boolean stardir = true;

void roboInit()  {
  for (int i = 0; i < numFrames; i++)  {
    String imageName = "50robo" + i + ".png";
    images[i] = loadImage(imageName);
  }
}

void roboDraw()  {
  if (fourthFrame <= 0)  {  frame = (frame+1) % numFrames;  }
  fourthFrame = (fourthFrame + 1) % 4;
  imageMode(CORNER);
  image(images[frame], 0, 0, enemyWidth, enemyHeight);
}

void drawEnemy()  {
  if (!dronemodeX)  {
  translate(enemyLocX, enemyLocY);
  roboDraw();
  translate(-enemyLocX, -enemyLocY);
  
  } else if (dronemodeX)  {
    translate(enemyLocX, enemyLocY);  roboDraw();
    translate(-enemyLocX, -enemyLocY);

    translate(enemyLoc2X, enemyLoc2Y);  roboDraw();
    translate(-enemyLoc2X, -enemyLoc2Y);

    translate(enemyLoc3X, enemyLoc3Y);  roboDraw();
    translate(-enemyLoc3X, -enemyLoc3Y);

    translate(enemyLoc4X, enemyLoc4Y);  roboDraw();
    translate(-enemyLoc4X, -enemyLoc4Y);
  }
}
void enemyUpdate() {
  if (!dronemodeX)  {
  if (!a) {   enemyLocX ++; }   if (enemyLocX > width - enemyWidth)   {a = true;}  if (a) {  enemyLocX --;  }  if (enemyLocX < 1)        {a = false;}
  if (!b) {   enemyLocY ++; }   if (enemyLocY > height - enemyWidth)  {b = true;}  if (b) {  enemyLocY --;  }  if (enemyLocY < 1)        {b = false;}

  }  else  if (dronemodeX){
    
  if (!a) {   enemyLocX ++; }   if (enemyLocX > width - enemyWidth)   {a = true;}  if (a) {  enemyLocX --;  }  if (enemyLocX < 1)  {a = false;}
  if (!b) {   enemyLocY ++; }   if (enemyLocY > height - enemyWidth)  {b = true;}  if (b) {  enemyLocY --;  }  if (enemyLocY < 1)  {b = false;}

  if (!a2) {   enemyLoc2X ++; }   if (enemyLoc2X > width - enemyWidth)   {a2 = true;}  if (a2) {  enemyLoc2X --;  }  if (enemyLoc2X < 1)  {a2 = false;}
  if (!b2) {   enemyLoc2Y ++; }   if (enemyLoc2Y > height - enemyWidth)  {b2 = true;}  if (b2) {  enemyLoc2Y --;  }  if (enemyLoc2Y < 1)  {b2 = false;}

  if (!a3) {   enemyLoc3X ++; }   if (enemyLoc3X > width - enemyWidth)   {a3 = true;}  if (a3) {  enemyLoc3X --;  }  if (enemyLoc3X < 1)  {a3 = false;}
  if (!b3) {   enemyLoc3Y ++; }   if (enemyLoc3Y > height - enemyWidth)  {b3 = true;}  if (b3) {  enemyLoc3Y --;  }  if (enemyLoc3Y < 1)  {b3 = false;}

  if (!a4) {   enemyLoc4X ++; }   if (enemyLoc4X > width - enemyWidth)   {a4 = true;}  if (a4) {  enemyLoc4X --;  }  if (enemyLoc4X < 1)  {a4 = false;}
  if (!b4) {   enemyLoc4Y ++; }   if (enemyLoc4Y > height - enemyWidth)  {b4 = true;}  if (b4) {  enemyLoc4Y --;  }  if (enemyLoc4Y < 1)  {b4 = false;}
  }
}

void XmodeVariables()  {
    enemyLoc2X = enemyLocX + 50;  enemyLoc2Y = enemyLocY;
    enemyLoc3X = enemyLocX;       enemyLoc3Y = enemyLocY + 50;
    enemyLoc4X = enemyLocX + 50;  enemyLoc4Y = enemyLocY + 50;
    a=true; b=true; a2=false; b2=true; a3=true; b3=false; a4=false; b4=false;

}

void XmodeCleanUp()  {
    collDetectB = false; collDetectC = false;
    collDetectD = false; collDetectE = false;
 }

void newEnemyLoc()  {
  if (!dronemodeX)  {
    enemyWidth = 50.0; enemyHeight = 50.0;
    if (youX <= width/2)  {
      enemyLocX = random(width/2.0,(width-50.0));  enemyLocY = random(0.0,(height-50.0));
    }
    else  if (youX >= width/2)  {
      enemyLocX = random(0.0,(width/2-50.0));  enemyLocY = random(0.0,(height-50.0));
    }
  }  else  if(dronemodeX){
    enemyWidth = 25.0; enemyHeight = 25.0;
    if (youX <= width/2)  {
      enemyLocX = random(width/2.0,(width-50.0));  enemyLocY = random(0.0,(height-50.0));
    }
    else  if (youX >= width/2)  {
      enemyLocX = random(0.0,(width/2-50.0));  enemyLocY = random(0.0,(height-50.0));
    }
  }
}

void ballNewPos()  {
  int a = 0; while (a == 0)  {  // Redo till not overlaping
    ballX = int(random(0 , width));  ballY = int(random(0 , height));
    if (ballX % 2 != 0)  {    ballX++;    } if (ballY % 2 != 0)  {    ballY++;    }
    if (ballBall(youghX, youghY, youSize*2, ballX, ballY, ballSize) != true)  {  a=1;  }
  }
}

void ballWalk()  {
  
if (superSeaker)  {  newBallGoal();  }

if (ballX > ballGoalX)  {  ballX = ballX -2;  }
else if (ballX < ballGoalX)  {  ballX = ballX +2;  }
if (ballY > ballGoalY)  {  ballY = ballY -2;  }
else if (ballY < ballGoalY)  {  ballY = ballY +2;  }

if ((ballX == ballGoalX) || (ballY == ballGoalY))  {  
  newBallGoal();
}

float d = dist(ballX,ballY,ballGoalX,ballGoalY); //kanske behövs sen
}

void newBallGoal()  {
  if (seakMode)  {
    ballGoalX = youghX;
    ballGoalY = youghY;

    if (ballGoalX % 2 != 0)  {    ballGoalX++;    }
    if (ballGoalY % 2 != 0)  {    ballGoalY++;    }
  }  else if(!seakMode)  {
    ballGoalX = int(random(ballSize/2, width-ballSize/2));
    ballGoalY = int(random(ballSize/2, height-ballSize/2));
    
    if (ballGoalX % 2 != 0)  {    ballGoalX++;    }
    if (ballGoalY % 2 != 0)  {    ballGoalY++;    }
  }
}
void ballSize()  {
  if (growth)  {
    ballSize ++;
    if (ballSize >= 100)  {  growth = !growth;  }
  }  else if (!growth)  {
    ballSize --;
    if (ballSize <= 50)  {  growth = !growth;  }
  }
}

void bounce()  {
  for (int i=0; i<bouncers; i++)  {
    bounceX[i] = bounceX[i] + bXspeed[i];
    bounceY[i] = bounceY[i] + bYspeed[i];
  
    if ((bounceX[i] > width) || (bounceX[i] < 0)) {
      bXspeed[i] = bXspeed[i] * -1;
    }
    if ((bounceY[i] > height) || (bounceY[i] < 0)) {
      bYspeed[i] = bYspeed[i] * -1;
    }  
  }
}

void holeWalk()  {
  if (delyBol)  {
  if (holeX > holeGoalX)  {  holeX --;  }
  if (holeX < holeGoalX)  {  holeX ++;  }
  if (holeY > holeGoalY)  {  holeY --;  }
  if (holeY < holeGoalY)  {  holeY ++;  }
}
delyBol = !delyBol;
if ((holeX == holeGoalX) && (holeY == holeGoalY))
{  newholeGoal();  }

float d = dist(holeX,holeY,holeGoalX,holeGoalY); //kanske behövs sen
float dist = dist(holeX,holeY,youX,youY); //kanske behövs sen

  if (dist < 40)  {
    youRadius --;
    if (youRadius <= 0)
    { youRadius = 0;
      holeX = int(random(0 /*balholelSize*/, width)); //-holeSize
      holeY = int(random(0 /*holeSize*/, height)); //-holeSize
      newholeGoal();
      lives --;
    }

    holeSize ++;
  }  else  {
    youRadius = 25.0;
  }
}

void newholePos()  {
  int a = 0; while (a == 0)  {  // Redo till not overlaping
    holeX = int(random(0, width));holeY = int(random(0, height));
    if (ballBall(youghX, youghY, youSize*2, holeX, holeY, holeSize) != true)  {  a=1;  }
  }
}

void newholeGoal()  {
  if (seakMode)  {
    holeGoalX = youghX;
    holeGoalY = youghY;

  }  else  {
    holeGoalX = int(random(holeSize/2, width-holeSize/2));
    holeGoalY = int(random(holeSize/2, height-holeSize/2));
  }
}

void holeSize()  {
  if (growth)  {
    holeSize ++;
    if (holeSize >= 150)  {  growth = !growth;  }
  }  else if (!growth)  {
    holeSize --;
    if (holeSize <= 50)  {  growth = !growth;  }
  }
}

void bstar()  {
  ellipseMode(CENTER);noFill();strokeWeight(1);stroke(55, 202, 200);shapeMode(CORNER);
  translate(recLocX+25, recLocY+25);
  ellipse(0,0,50,50);
  pushMatrix();
  for (int i = 0; i < 6; i = i+1) {
    rotate(rotate);
    rotate = rotate + 0.0005;  star();
    rotate = rotate - 0.0010;  star();
    rotate = rotate + 0.0010;
  }
  popMatrix();
  translate(-recLocX-25,-recLocY-25);
}
void star()  {
  bezier(hw/2, 0,  scX, scY,  scX, scY,  0, hh/2);
  bezier(hw/2, 0,  scX, scY,  scX, scY,  hw, hh/2);
  bezier(hw/2, hh,  scX, scY,  scX, scY,  0, hh/2);
  bezier(hw/2, hh,  scX, scY,  scX, scY,  hw, hh/2);

  bezier(0, 0,  scX, scY,  scX, scY,  0, hh);
  bezier(hw, 0,  scX, scY,  scX, scY,  0, 0);
  bezier(hw, hh,  scX, scY,  scX, scY,  hw, 0);
  bezier(hw, hh,  scX, scY,  scX, scY,  0, hw);
}

void psysSetup()  {
  for (int i = 0; i < pnr; i++) {
    ppos[i] = 0;
    pspeed[i] = random(2.0, map(i,0,pnr,10.0,0.5));
    psize[i] = random(2.0, map(i,0,pnr,5.0,20.0));
  }
}

void bounceNewPos()  {
  for (int i=0; i<bouncers; i++)  {
    bXspeed[i] = 2;    bYspeed[i] = 1;
  }

  for (int i=0; i<bouncers; i++)  {
    int a = 0; while (a == 0)  {  // Redo till not overlaping
      bounceX[i] = int(random(0 , width));  bounceY[i] = int(random(0 , height));
      if (ballBall(youghX, youghY, youSize*2, bounceX[i], bounceY[i], bounceSize) != true)  {  a=1;  }
    }
  }
}

void bounceAddPos()  {
  for (int i=bouncers-1; i<bouncers; i++)  {
    bXspeed[i] = 2;    bYspeed[i] = 1;
  }

  for (int i=bouncers-1; i<bouncers; i++)  {
    int a = 0; while (a == 0)  {  // Redo till not overlaping
      bounceX[i] = int(random(0 , width));  bounceY[i] = int(random(0 , height));
      if (ballBall(youghX, youghY, youSize*2, bounceX[i], bounceY[i], bounceSize) != true)  {  a=1;  }
    }
  }
}

void bounceCheck()  {
  for (int i=0; i<bouncers; i++)  {
      if (ballBall(youghX, youghY, youSize, bounceX[i], bounceY[i], bounceSize) == true) {
        bXspeed[i] = bXspeed[i] * -1;  bYspeed[i] = bYspeed[i] * -1;
      int a = 0; while (a == 0)  {  // Redo till not overlaping
      bounceX[i] = int(random(0 , width));  bounceY[i] = int(random(0 , height));
      if (ballBall(youghX, youghY, youSize*2, bounceX[i], bounceY[i], bounceSize) != true)  {  a=1;  }
    }
        die();
      }
      for (int u=1; u<bouncers-i; u++)  {
        if (ballBall(bounceX[i], bounceY[i], bounceSize, bounceX[u], bounceY[u], bounceSize) == true) {
          bXspeed[i] = bXspeed[i] * -1;  bYspeed[i] = bYspeed[i] * -1;
          bXspeed[u] = bXspeed[u] * -1;  bYspeed[u] = bYspeed[u] * -1;
      }
    }
  }
}

void drawBouncer()  {
  for (int i=0; i<bouncers; i++)  {
    translate(bounceX[i], bounceY[i]);
    starmath();  
    makestar();
    pushMatrix();
    stroke(0);scale(2.0);strokeWeight(1);fill(0,100,150);
    if (i==0)  {fill(200,100,200);}
    ellipse(0,0,bounceSize/2,bounceSize/2);
    scale(0.5);
    fill(0,200,100);
    rotate(rotX);
    drawplanets();
    rotate(-rotX);
    popMatrix();
    mathplanets();
    translate(-bounceX[i], -bounceY[i]);
    rotX = (rotX - 0.005) % TWO_PI;
  }
}

void drawWalker()  {
  translate(ballX, ballY);
  starmath();  
  makestar();
  pushMatrix();
  rotate(rotX);stroke(0);scale(2.0);strokeWeight(1);fill(50,200,50);
  ellipse(0,0,ballSize/2,ballSize/2);
  drawstar();
  rotate(-rotX);scale(0.5);
  //drawplanets();
  popMatrix();
  mathplanets();
  rotX = (rotX - 0.1) % TWO_PI;
  translate(-ballX, -ballY);
}

void drawplanets() {
  noFill();
  for (int dp  = 0; dp < pnr; dp++) {
    translate(sin(radians(ppos[dp]))*sundist, cos(radians(ppos[dp]))*sundist);
    drawstar();
    translate(-sin(radians(ppos[dp]))*abs(sundist), -cos(radians(ppos[dp]))*abs(sundist));
    sdist = sdist + sundist;
  }
  sdist = sundist;
}

void mathplanets() {
  for (int i  = 0; i < pnr; i++) {
    ppos[i] = ppos[i] - pspeed[i];  
    if (ppos[i] > 360) {    
      ppos[i]=0;
    }
  }
}

void makestar() {
  for ( int i = 0; i < thorns.length; i++ ) {
    float x, y;
    if ( i % 2 == 0 ) {
      x = cos( angle * i ) * 10;  y = sin( angle * i ) * 10;
    } 
    else {
      x = cos( angle * i ) * radius;  y = sin( angle * i ) * radius;
    }
    thorns[i] = new PVector( x, y );
  }
}

void starmath()  {
  if (stardir == true) {  radius = radius +1;
  if (radius >= 20) {stardir = false;}
  } else if (stardir == false)  {  radius = radius -1;
  if (radius <= 2) {stardir = true;}
  }
  thorns = new PVector[ 8 ];
}

void drawstar() {
  beginShape();
  for (int i = 0; i < thorns.length; i++) {
    vertex( thorns[i].x, thorns[i].y );
    vertex( -thorns[i].x, -thorns[i].y );
  }
  endShape(CLOSE);
}

void dathingy()  {
  mod = map(holeSize,0,120,0.0,0.083);
  radiuq = 1.0;
  pushMatrix();
  translate(holeX,holeY);
  rotate(rotX);
  fill(255);
  stroke(255);
  for (int deg = 0; deg < 360*2; deg += 1) {
    float angle = radians(deg*2);
    float x = 0 + (sin(angle+mod) * radiuq);
    float y = 0 + (cos(angle+mod) * radiuq);
    if (deg >= 1)  {  line(xxx,yyy,x,y);  }

    radiuq = radiuq + mod;
    xxx = x; yyy = y;
  }
  translate(-holeX,-holeY);
  popMatrix();
}

void drawFlash()  {
  if (!zapOrientation)  {
    fill(255);
    rect(zapLocX, zapLocUY, zapWidth, zapHeight);
    rect(zapLocX, zapLocDY, zapWidth, zapHeight);
  }
  else if (zapOrientation)  {
    fill(255);
    rect(vZapLocLX, vZapLocY, vzapWidth, vzapHeight);
    rect(vZapLocMX, vZapLocY, vzapWidth, vzapHeight);
    rect(vZapLocRX, vZapLocY, vzapWidth, vzapHeight);
  }
}
