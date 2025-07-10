class Player {
  int x,y;
  float xSpeed,ySpeed;
  float xaccel,xdeccel,yaccel,ydeccel;
  float maxXspd,maxYspd;
  float xSave,ySave;
  int xRep,yRep;
  float gravity;
  Player(int _x, int _y ) {
    x = _x;
    y = _y;
    xSpeed = 0;
    ySpeed = 0;
    xaccel = 0.5;xdeccel = 0.5;
    yaccel = 0.3;ydeccel = 0.3;
    maxXspd = 8;
    maxYspd = 6;
    xSave = 0;
    ySave = 0;
    xRep = 0;
    yRep = 0;
  }
  void update() {
    if ( right ) {
      xSpeed += xaccel;
      if ( xSpeed > maxXspd ) {
        xSpeed = maxXspd;
      }
    }
    else if ( left ) {
      xSpeed -= xaccel;
      if ( xSpeed < -maxXspd ) {
        xSpeed = -maxXspd;
      }
    }
    else { //neither right or left pressed, decelerate
      if ( xSpeed > 0 ) {
        xSpeed -= xdeccel;
        if ( xSpeed < 0 ) {
          xSpeed = 0;
        }
      }
      else if ( xSpeed < 0 ) {
        xSpeed += xdeccel;
        if ( xSpeed > 0 ) {
          xSpeed = 0;
        }
      }
    }
    
    if ( up ) {
      ySpeed -= yaccel;
      if ( ySpeed < maxYspd ) {
        ySpeed = -maxYspd;
      }
    }
    else if ( down ) {
      ySpeed += yaccel;
      if ( ySpeed > -maxYspd ) {
        ySpeed = maxYspd;
      }
    }
    else { //neither up or down pressed, decelerate
      if ( ySpeed > 0 ) {
        ySpeed -= ydeccel;
        if ( ySpeed < 0 ) {
          ySpeed = 0;
        }
      }
      else if ( ySpeed < 0 ) {
        ySpeed += ydeccel;
        if ( ySpeed > 0 ) {
          ySpeed = 0;
        }
      }
    }
    
    if ((level == 6) || (level == 10)) {
      if (inHole)  {
        if (holeX > youX)  {  xSpeed += xaccel;  }
        if (holeX < youX)  {  xSpeed -= xaccel;  }
        if (holeY > youY)  {  ySpeed += yaccel;  }  
        if (holeY < youY)  {  ySpeed -= yaccel;  }
        if (youSize <= 1)  {  die();  }
      }
    }

    
    xRep = 0; //should be zero because the for loops count it down but just as a safety
    yRep = 0;
    xRep += floor(abs(xSpeed));
    yRep += floor(abs(ySpeed));
    xSave += abs(xSpeed)-floor(abs(xSpeed));
    ySave += abs(ySpeed)-floor(abs(ySpeed));
    int signX = (xSpeed<0) ? -1 : 1;
    int signY = (ySpeed<0) ? -1 : 1;
    
    if ( xSave >= 1 ) {
      xSave -= 1;
      xRep++;
    }
    if ( ySave >= 1 ) {
      ySave -= 1;
      yRep++;
    }
    
    for ( ; yRep > 0; yRep-- ) {
        y += signY;
        if (y < youSize/2) {y = youSize/2;}
        if (y > height - youSize/2) {y = height - youSize/2;}

    }
    for ( ; xRep > 0; xRep-- ) {
        x += signX;
        if (x < youSize/2) {x = youSize/2;}
        if (x > width - youSize/2) {x = width - youSize/2;}
    }
      
  }
 
  void getYouPos() {
    youX=x;
    youY=y;
    youghX=round(x);
    youghY=round(y);
  }
}
