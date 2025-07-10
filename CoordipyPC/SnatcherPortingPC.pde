int exC=0; //Exit Colour
boolean i1, i2, i3, i4, i5, i6, i7, i8, i9, i10; // If level first time
boolean dronemodeX=false;  // not in droneMode
boolean a, b, a2, b2, a3, b3, a4, b4 = false;  // Xmode directions

boolean inHole,pause,resur;

int level = 1, round = 1; float lives = 5; int points = 0;int pointcue = 0;
Player p1;

float youX, youY;float youRadius = 30.0;           //player
int youghX;int youghY;int youSize = int(youRadius*2);
float asin = 0.0;float inc = 255/50;
float plasm=1;float plplasm;boolean youGrowth;
int resurCount;

boolean right = false, left = false, up = false, down = false;    //movement

float recLocX = random(50.0,(width-50.0));           //points
float recLocY = random(50.0,(height-50.0));
float recWidth = 50.0;float recHeight = 50.0;

int bouncers=1;                                    //bouncers
int[] bounceX = new int[bouncers];
int[] bounceY = new int[bouncers];
int[] bXspeed = new int[bouncers];
int[] bYspeed = new int[bouncers];
int bounceSize = 50;

int ballX, ballY, ballGoalX, ballGoalY;             //walker
boolean seakMode = false; boolean superSeaker = false;
int ballSize = 50;

boolean delyBol;// boolean suckedIn = false;          //blackhole
int holeX, holeY, holeGoalX, holeGoalY;
int holeSize = 120;boolean growth = true;

float enemyLocX;   float enemyLocY;
float enemyLoc2X;  float enemyLoc2Y;  float enemyLoc3X;
float enemyLoc3Y;  float enemyLoc4X;  float enemyLoc4Y;
float enemyWidth = 50.0;float enemyHeight = 50.0;

boolean  collDetect = false; boolean collDetectB = false;
boolean collDetectC = false; boolean collDetectD = false;
boolean collDetectE = false; int fr = 100;

float zapLocX,zapLocUY,zapLocDY,zapWidth,zapHeight;
float vZapLocY,vZapLocLX,vZapLocMX,vZapLocRX,youSpeed,vzapWidth,vzapHeight;
boolean flash,zapDir,zapOrientation;


void setup() {
  // size(600,600);
  size(600,400);

  //put the player in the middle of the window
  p1 = new Player(width/2,height/2);

  introInit();
  bginit();
  psysSetup();
  roboInit();
  setupVars();  
  //For da points
  hw = 25;  hh = 25;
  scX = 10; scY=10;
  
  smooth();
  ellipseMode(CENTER);
  frameRate(fr);
  textSize(20);
  newEnemyLoc();

    // BOUNCE IN RANDOM POSITION ON SCREEN
  bounceNewPos();
    // BALL IN RANDOM POSITION ON SCREEN
  ballNewPos();  newBallGoal();
  }

void draw() {
  if (intro)  { drawIntro(); }  else  {
    if (lives <= 0)  {  score = points;  initHiScore();  drawHiScore();  //gameOver();
  }  else  {
    fill(0,255,255);
    background(0);
    scene();  //the backgrounds
    bstar();  //the points
    collDetect = isCollidingCircleRectangle(youX, youY, youRadius, recLocX, recLocY, recWidth, recHeight);
    if (collDetect == true) {  // If Hittin Point
      fill(255,0,0);recLocX = random(0.0,(width-50.0));recLocY = random(0.0,(height-50.0));  points ++;
    }
    
        if ((flash) && (zapOrientation))  {
        drawFlash();
   
        boolean collisionDetectedL = isCollidingCircleRectangle(youX, youY,
          youRadius, vZapLocLX, vZapLocY, vzapWidth, vzapHeight);
        boolean collisionDetectedM = isCollidingCircleRectangle(youX, youY,
          youRadius, vZapLocMX, vZapLocY, vzapWidth, vzapHeight);
        boolean collisionDetectedR = isCollidingCircleRectangle(youX, youY,
          youRadius, vZapLocRX, vZapLocY, vzapWidth, vzapHeight);

      if ((collisionDetectedL == true) || (collisionDetectedM == true) || (collisionDetectedR == true))  {
        //lives --;  
        die();  flash = false;  vZapLocY=0.0;
      }
    //println(collisionDetectedL+"    "+collisionDetectedM+"    "+collisionDetectedR);
    if(zapDir)  {
      vZapLocY = (vZapLocY -youSpeed/2) % height;
      if (vZapLocY <= youSpeed/2)  {  zapDir=!zapDir;  } 
    }  else if(!zapDir)  {
      vZapLocY = (vZapLocY +youSpeed/2) % height;
      if (vZapLocY >= height-youSpeed/2)  {  zapDir=!zapDir;  } 
      }
    }  else if ((flash) && (!zapOrientation))  {
      drawFlash();
   
      boolean collisionDetectedU = isCollidingCircleRectangle(youX, youY,
        youRadius, zapLocX, zapLocUY, zapWidth, zapHeight);
      boolean collisionDetectedD = isCollidingCircleRectangle(youX, youY,
        youRadius, zapLocX, zapLocDY, zapWidth, zapHeight);
     
    if ((collisionDetectedU == true) || (collisionDetectedD == true))  {
      //lives --;  die();  flash = false;  zapDir=false;
        die();  flash = false;  zapLocX=0.0;
    }
    // println(collisionDetectedU+"    "+collisionDetectedD);
    if(zapDir)  {
      zapLocX = (zapLocX -youSpeed) % width;
      if (zapLocX <= youSpeed)  {  zapDir=!zapDir;  } 
    }  else if (!zapDir)  {
      zapLocX = (zapLocX +youSpeed) % width;
      if (zapLocX >= width-youSpeed)  {  zapDir=!zapDir;  } 
    }
  }
  
/***********************************************************************************
*   LEVEL ONE                                                                      *
***********************************************************************************/
    if (!i1)  {
      if (round >= 2)  {
        flash=true;  zapOrientation=false;  zapLocX=0.0;
      }
      i1 = true;
    }
 
    fill(127);  noStroke();
    drawBouncer();  bounce();
    
    if (!resur)  {  bounceCheck();  }

    if (level >= 4) {
    if (level % 2 != 0)  { ballSize(); }
    ballWalk();
    fill(255);
  
    // Detect Collision ballBall
    if (ballBall(youghX, youghY, youSize, ballX, ballY, ballSize) == true) {
      die();
      ballNewPos();
    }
      drawWalker();

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
    if (level >= 2)  {
      if (!i2)  {
        enemyLocX = ballX;  enemyLocY = ballY;
        enemyWidth = 50.0; enemyHeight = 50.0;

        flash=false;  zapLocX=0.0;  vZapLocY=0.0;
        i2 = true;
      }
    }

    if ((level >= 2) && (level != 5) && (level != 6))  {
      
    if (!dronemodeX)  {
      collDetectB = isCollidingCircleRectangle(youX, youY, youRadius, enemyLocX, enemyLocY, enemyWidth, enemyHeight);
    }

    if (dronemodeX)  {
      collDetectB = isCollidingCircleRectangle(youX, youY, youRadius, enemyLocX,  enemyLocY,  enemyWidth, enemyHeight);
      collDetectC = isCollidingCircleRectangle(youX, youY, youRadius, enemyLoc2X, enemyLoc2Y, enemyWidth, enemyHeight);
      collDetectD = isCollidingCircleRectangle(youX, youY, youRadius, enemyLoc3X, enemyLoc3Y, enemyWidth, enemyHeight);
      collDetectE = isCollidingCircleRectangle(youX, youY, youRadius, enemyLoc4X, enemyLoc4Y, enemyWidth, enemyHeight);
    }
    
    if ((dronemodeX == false) && (collDetectB == true))  {  // If Hitin Drone
      die(); dronemodeX = true;
      newEnemyLoc();  
      XmodeVariables();
    }
    else if ((dronemodeX == true) && ((collDetectB == true) || (collDetectC == true) || (collDetectD == true) || (collDetectE == true)))
    {   
      die(); dronemodeX = false;
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
    if (level >= 4)  {
      if (!i4)  {
        i4=true;
      }
    }
/***********************************************************************************
*   LEVEL FIVE                                                                     *
***********************************************************************************/
    if (level >= 5)  {
      if (!i5)  {
        flash=true;  zapOrientation=true;  vZapLocY = 0.0;
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
        newholePos();

        flash=false;  zapLocX=0.0;  vZapLocY=0.0;
        i6 = true;
      }
  }
    if ((level == 6) || (level == 10)) {
      holeWalk();
  
      // Detect Collision youhole
      if (youhole(youghX, youghY, youSize, holeX, holeY, holeSize) == true) {

      // If Detected
      inHole = true;
      }  else {
      inHole = false;
    }
  fill(0);stroke(255);
  ellipse(holeX, holeY, holeSize, holeSize);
  //dathingy();
  noStroke();
  }
/***********************************************************************************
*   LEVEL SEVEN                                                                    *
***********************************************************************************/
    if (level >= 7)  {
      if (!i7)  {
        seakMode = true;
        i7 = true;
      }
  }
/***********************************************************************************
*   LEVEL EIGHT                                                                    *
***********************************************************************************/
    if (level >= 8)  {
      if (!i8)  {
        i8 = true;
      }
  }
/***********************************************************************************
*   LEVEL NINE                                                                     *
***********************************************************************************/
    if (level >= 9)  {
      if (!i9)  {
        superSeaker = true;
        i9 = true;
      }
  }
/***********************************************************************************
*   LEVEL TEN                                                                      *
***********************************************************************************/
    if (level >= 10)  {
      if (!i10)  {
        i10 = true;
      }
  }
/***********************************************************************************
*   Every Level                                                                    *
***********************************************************************************/
  if (level >= 11)  {
    round++;
    level = 1;
    fr = fr + 20;
    frameRate(fr);
    seakMode=superSeaker=dronemodeX=false;
    i1=i2=i3=i4=i5=i6=i7=i8=i9=i10=false;

    bouncers++;
    bounceX = expand(bounceX, bouncers);
    bounceY = expand(bounceY, bouncers);
    bXspeed = expand(bXspeed, bouncers);
    bYspeed = expand(bYspeed, bouncers);
    bounceAddPos();
  }
  
  //float shrink = map(lives,0,5,0,60);

  stroke(255);  strokeWeight(2);

  p1.update();
  p1.getYouPos();

  fill(0,0,255);  noFill();

  youDraw();
}
    
    if (points >= pointcue + 8)  {
    bgtrans=true;  level++;
    pointcue=points;
    }
    if (resur)  {    resur();  }
  }
}

void die()  {
  lives--;
  resur=true;
}

void resur()  {
  resurCount++;
  noFill();strokeWeight(resurCount);stroke(255,0,0);
  ellipse (youX,youY,youSize,youSize);
  if (resurCount >= 5)  {  resur=false;  resurCount=0;  }
}

void youDraw()  {
  float tempSize;
  if(inHole)
  {  tempSize=map(youSize/2,0,youSize,0,dist(youX,youY,holeX,holeY));  }
  else  {  tempSize=youSize;  }

  pushMatrix();
  noFill();strokeWeight(1); translate(youX,youY);
  ellipse(0, 0, tempSize, tempSize);
  for (float i = 0; i < tempSize*2; i = i + inc)  {
  ellipse(0,0,plasm-i,plasm-i);
  stroke(255-i,255-cos(asin),255-sin(asin),map(i,0,tempSize*2,255,0));
  }
  plplasm = (plplasm + inc) % 255;
  if (youGrowth)  {    plasm++;
  if (plasm >= youSize)  {  youGrowth=!youGrowth;  }
  }  else if (!youGrowth)  {    plasm--;
  if (plasm <= 0)  {  youGrowth=!youGrowth;  }
  }
  asin = asin + inc;
  popMatrix();
}
void mouseMoved() {  
  if(!intro)  {
    youX = mouseX; youY = mouseY;  // move to the mouse coordinates
    youghX = mouseX; youghY = mouseY;
  }
}
void mouseClicked() {
  if(!intro)  {
    if(!pause)  {
      noLoop(); pause=true;
    }  else if(pause)  {
      loop(); pause=false;
    }
  }
}

void keyPressed() {
  if (lives <= 0)  {
    
  // If the return key is pressed, save the String and clear it
  if (key == '\n' ) {
    saved = typing;
    typing = ""; // A String can be cleared by setting it equal to ""
    name = saved;
    HiScore = place(score);
    arrayCorrect();
    putScores();    
    }

    if (key == BACKSPACE ) {
    typing = typing.substring( 0, typing.length()-1 );
    }

    if (key == SHIFT ) {
      typing = typing.substring( 0, typing.length()-1 );
    } 
  
    else if ((key >= 'A' && key <= 'ö') || key == ' ') {
      typing = typing + key;
    }
 }  else  {
    switch(keyCode) {
      case RIGHT: right = true; break;
      case LEFT: left = true; break;
      case UP: up = true; break;
      case DOWN: down = true; break;
    }
  }
}
void keyReleased() {
  switch(keyCode) {
    case RIGHT: right = false; break;
    case LEFT: left = false; break;
    case UP: up = false; break;
    case DOWN: down = false; break;
  }
}

void gameInit()  {
  rectMode(CORNER);
  textAlign(CORNER, CORNER);
}
