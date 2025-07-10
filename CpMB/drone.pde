void drawEnemy()  {
  if (!dronemodeX)  {
  fill(0,200,0);
  rect(enemyLocX, enemyLocY, enemyWidth, enemyHeight);
  } else if (dronemodeX)  {
    rect(enemyLocX, enemyLocY, enemyWidth, enemyHeight);
    rect(enemyLoc2X, enemyLoc2Y, enemyWidth, enemyHeight);
    rect(enemyLoc3X, enemyLoc3Y, enemyWidth, enemyHeight);
    rect(enemyLoc4X, enemyLoc4Y, enemyWidth, enemyHeight);
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
    enemyLocX = random(0.0,(width-50.0));  enemyLocY = random(0.0,(height-50.0));
    enemyWidth = 50.0; enemyHeight = 50.0;
    }  else  if(dronemodeX){
    enemyLocX = random(0.0,(width-50.0));  enemyLocY = random(0.0,(height-50.0));
    enemyWidth = 25.0; enemyHeight = 25.0;
  }
}

void ballNewPos()  {
  ballX = int(random(0 /*ballSize*/, width)); //-ballSize
  ballY = int(random(0 /*ballSize*/, height)); //-ballSize
}

void ballWalk()  {
  
if (superSeaker)  {  newBallGoal();  }

if (ballX > ballGoalX)  {  ballX --;  }
if (ballX < ballGoalX)  {  ballX ++;  }
if (ballY > ballGoalY)  {  ballY --;  }
if (ballY < ballGoalY)  {  ballY ++;  }

if ((ballX == ballGoalX) && (ballY == ballGoalY))
{  newBallGoal();  }

float d = dist(ballX,ballY,ballGoalX,ballGoalY); //kanske behövs sen
//print(xBdif);print(" ");print(yBdif);print(" ");print(ballX);print(" ");println(ballGoalX);
//print(i1);print(i2);print(i3);print(i4);print(i5);print(i6);print(i7);println(i8);
}

void newBallGoal()  {
  if (seakMode)  {
    ballGoalX = mouseX;
    ballGoalY = mouseY;
    xBdif = abs(ballX - ballGoalX); yBdif = abs(ballY - ballGoalY);
  }  else  {
    ballGoalX = int(random(ballSize/2, width-ballSize/2));
    ballGoalY = int(random(ballSize/2, height-ballSize/2));
    xBdif = abs(ballX - ballGoalX); yBdif = abs(ballY - ballGoalY);
  }
}
void ballSize()  {
  if (growth)  {
    ballSize ++;
    if (ballSize >= 150)  {  growth = !growth;  }
  }  else if (!growth)  {
    ballSize --;
    if (ballSize <= 50)  {  growth = !growth;  }
  }
}

void holeWalk()  {
//delyBol = false;
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

void newholeGoal()  {
  if (seakMode)  {
    holeGoalX = mouseX;
    holeGoalY = mouseY;
    xBdif = abs(holeX - holeGoalX); yBdif = abs(holeY - holeGoalY);

  }  else  {
    holeGoalX = int(random(holeSize/2, width-holeSize/2));
    holeGoalY = int(random(holeSize/2, height-holeSize/2));
    xBdif = abs(holeX - holeGoalX); yBdif = abs(holeY - holeGoalY);
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

