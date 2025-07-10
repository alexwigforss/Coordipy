// Variables
PImage bg; int exC=0;
boolean i1, i2, i3, i4, i5, i6, i7, i8;
boolean xModInit; boolean WriteOnce = false;
boolean dronemodeX=false; boolean a, b, a2, b2, a3, b3, a4, b4 = false;
boolean inHole=false; boolean pause=true; // fixa klart pause yaddayadda

int level = 1; float lives = 10; int points = -1;int pointcue = 0; int time = 0;
float youX;float youY;float youRadius = 30.0;
int youghX, youghY;int youSize = 50;

float recLocX = random(0.0,(width-50.0));float recLocY = random(0.0,(height-50.0));
float recWidth = 50.0;float recHeight = 50.0;

int ballX, ballY, ballGoalX, ballGoalY;           //walker
boolean seakMode = false; boolean superSeaker = false;
int ballSize = 50;
float xBdif, yBdif, xB, yB;

boolean delyBol; boolean suckedIn = false;        //blackhole
int holeX, holeY, holeGoalX, holeGoalY;
int holeSize = 120;boolean growth = true;

float enemyLocX = random(0.0,(width-50.0));float enemyLocY = random(0.0,(height-50.0));
float enemyLoc2X;  float enemyLoc2Y;  float enemyLoc3X;
float enemyLoc3Y;  float enemyLoc4X;  float enemyLoc4Y;
float enemyWidth = 50.0;float enemyHeight = 50.0;

boolean  collDetect = false; boolean collDetectB = false;
boolean collDetectC = false; boolean collDetectD = false;
boolean collDetectE = false; int fr = 30;

void setup() {
  smooth();
  //size(1024, 768);
  size(1024, 728);ellipseMode(CENTER);rectMode(CORNER);
  frameRate(fr);
  textSize(20);  
  bg = loadImage("bg.jpg");
  newEnemyLoc();

    // BALL IN RANDOM POSITION ON SCREEN
  ballX = int(random(0 /*ballSize*/, width)); //-ballSize
  ballY = int(random(0 /*ballSize*/, height)); //-ballSize
  newBallGoal();

  // hole IN RANDOM POSITION ON SCREEN
  holeX = int(random(0 /*balholelSize*/, width)); //-holeSize
  holeY = int(random(0 /*holeSize*/, height)); //-holeSize
  newholeGoal();
  }

void draw() {
  if (lives < 1)  {  gameOver();
  }  else  {    background(255);
    fill(0,0,255);
    rect(recLocX, recLocY, recWidth, recHeight);
    collDetect = isCollidingCircleRectangle(youX, youY, youRadius, recLocX, recLocY, recWidth, recHeight);
    if (collDetect == true) {  // If Hittin Point
      fill(255,0,0);recLocX = random(0.0,(width-50.0));recLocY = random(0.0,(height-50.0));  points ++;
    }  
/***********************************************************************************
*   LEVEL ONE                                                                      *
***********************************************************************************/
  if ((level >= 1) && (level != 2) && (level != 3))  {
      if (!i1)  {
        i1 = true;
      }  
    if ((level >= 4) && (level != 5))  {  ballSize();  }
    ballWalk();
    fill(255);
  
    // Detect Collision ballBall
    if (ballBall(youghX, youghY, youSize, ballX, ballY, ballSize) == true) {
      lives --;
      ballNewPos();
      fill(255);
    }  else {
      fill(0);
    }
      ellipse(ballX, ballY, ballSize, ballSize);

    if (seakMode)  {
      noFill();stroke(0, 200, 0);//strokeWeight(3);
      ellipse(ballX, ballY, ballSize+20, ballSize+20);
      noStroke();
        if (superSeaker)  {
          stroke(0, 200, 0);
          ellipse(ballX, ballY, ballSize+50, ballSize+50);
        }
    }
 }  
/***********************************************************************************
*   LEVEL TWO                                                                      *
***********************************************************************************/
    if ((level >= 2) && (level != 5) && (level != 6))  {
      
      if (!i2)  {
        enemyLocX = ballX;  enemyLocY = ballY;
        enemyWidth = 50.0; enemyHeight = 50.0;
        i2 = true;
      }
      
    if (!dronemodeX)  {
    collDetectB = isCollidingCircleRectangle(youX, youY, youRadius, enemyLocX, enemyLocY, enemyWidth, enemyHeight);
    }

    if (dronemodeX)  {
    collDetectB = isCollidingCircleRectangle(youX, youY, youRadius, enemyLocX,  enemyLocY,  enemyWidth, enemyHeight);
    collDetectC = isCollidingCircleRectangle(youX, youY, youRadius, enemyLoc2X, enemyLoc2Y, enemyWidth, enemyHeight);
    collDetectD = isCollidingCircleRectangle(youX, youY, youRadius, enemyLoc3X, enemyLoc3Y, enemyWidth, enemyHeight);
    collDetectE = isCollidingCircleRectangle(youX, youY, youRadius, enemyLoc4X, enemyLoc4Y, enemyWidth, enemyHeight);
    }
    
    if ((collDetectB == true) && (dronemodeX == false))  {  // If Hitin Drone
        lives --; dronemodeX = true;
        newEnemyLoc();  
        XmodeVariables();
    }
    else if ((collDetectB == true) || (collDetectC == true) || (collDetectD == true) || (collDetectE == true) && (dronemodeX == true))
    {   
        lives --; dronemodeX = false;
        XmodeCleanUp();
        newEnemyLoc();
      }
      fill(0,200,0);
      enemyUpdate();
      drawEnemy();
}
/***********************************************************************************
*   LEVEL THREE                                                                    *
***********************************************************************************/
    if (level >= 3)  {
      if (!i3)  {
        dronemodeX = true;
        newEnemyLoc();  
        XmodeVariables();
        i3 = true;
      }
    }
/***********************************************************************************
*   LEVEL FOUR                                                                     *
***********************************************************************************/
//    if (level >= 4)  {
//      if (!i4)  {
//        seakMode = true;
//      }
//    }
/***********************************************************************************
*   LEVEL FIVE                                                                     *
***********************************************************************************/
    if (level >= 5)  {
      if (!i5)  {
        seakMode = true;
        i5 = true;
      }
    if (level == 5)  {    
    }
  }
/***********************************************************************************
*   LEVEL SIX                                                                      *
***********************************************************************************/
    if (level >= 6)  {
      if (!i6)  {
        i6 = true;
      }
  }
    if ((level == 6) || (level == 10)) {
      holeWalk();
  
      // Detect Collision youhole
      if (youhole(youghX, youghY, youSize, holeX, holeY, holeSize) == true) {
      //  fill(0);

      // If Detected
      inHole = true;
      if (holeX > youX)  {  youX ++;  }  if (holeX < youX)  {  youX --;  }
      if (holeY > youY)  {  youY ++;  }  if (holeY < youY)  {  youY --;  }
      if (youSize <= 1)  {  lives --;  }
      }  else {
      inHole = false;
    }

  fill(0);stroke(255);
  ellipse(holeX, holeY, holeSize, holeSize);
  noStroke();
  }
/***********************************************************************************
*   LEVEL SEVEN                                                                    *
***********************************************************************************/
    if (level >= 7)  {
      if (!i5)  {
        i7 = true;
      }
  }
/***********************************************************************************
*   LEVEL EIGHT                                                                    *
***********************************************************************************/
    if (level >= 8)  {
      if (!i8)  {
        superSeaker = true;
        i8 = true;
      }
  }
/***********************************************************************************
*   Every Level                                                                    *
***********************************************************************************/
  if (level >= 11)  {
    level = 1;
    fr = fr + 20;
    frameRate(fr);
    seakMode=false;superSeaker=false;
    }
  
  float filler = map(lives,0,10,0,255);
  float shrink = map(lives,0,10,0,60);

  stroke(255);  strokeWeight(2);   fill(255,0,0,filler);
  ellipse(youX, youY, youRadius*2.0, youRadius*2.0);
  noStroke();    fill(255,0,0);

    /* har jag keffat till det här?*/
    if(inHole)
    {  ellipse(youX, youY, youRadius*2.0, youRadius*2.0);  }
    else  {  ellipse(youX, youY, shrink, shrink);  }

    fill(0);
    time = millis();
    text("lives: " + nfp(lives, 2, 0) + " points: " + nfp(points, 1,0)
    + " level: " + nfp(level, 1,0), 0, 0, width, height);
    }
    if (points >= pointcue + 10)  {
    level++;
    pointcue=points;
    }
  }

void mouseMoved() {
  youX = mouseX; youY = mouseY;  // move to the mouse coordinates
  youghX = mouseX; youghY = mouseY;

  if (youX < youRadius) {youX =+ youRadius;}  // check and correct if You extends borders
  if (youX > width - youRadius) {youX = width - youRadius;}
  if (youY < youRadius) {youY =+ youRadius;}
  if (youY > height - youRadius) {youY = height - youRadius;}

  if (youghX < youSize/2) {youghX =+ youSize/2;}  // check and correct if ghostYou extends borders
  if (youghX > width - youSize/2) {youghX = width - youSize/2;}
  if (youghY < youSize/2) {youghY =+ youSize/2;}
  if (youghY > height - youSize/2) {youghY = height - youSize/2;}
}

void gameOver()  {
  if (!WriteOnce)  {
    String lines[] = loadStrings("HiScore.txt");
    for (int i = 0 ; i < lines.length; i++) {
    }
  String[] linesb = append(lines, str(points));
  saveStrings("HiScore.txt", linesb);
  WriteOnce = true;
  } 
    background(exC,1);
    textSize(30);
    text("Game Over. You Got " + points + " Points",100,100);
    exC ++;
    // println(exC);
    if (exC >= 255)  {exit();}
}
