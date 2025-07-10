PShape s;  boolean intro = true;
float rotation = width/2; int zoom = 85; boolean grw = true;
int decrease = 255;  int circleSize = 90;
color circleColor, baseColor;
boolean circleOver = false;  boolean trans = false;

void introInit()  {
  youX=width/2;
  youY=height/2;
  s = loadShape("sntext.svg");
  baseColor = color(decrease);
  ellipseMode(CENTER);
  shapeMode(CORNER);
  textAlign(CENTER, CENTER);
}

void drawIntro() {
  pushMatrix();
  background(baseColor);
  button();
  whatewa();
  popMatrix();

    fill(175);
    text("LAUNCH", width/2, height/2);
    
  if (trans)  {
  youDraw();
  baseColor = color(decrease);
  decrease-=4;
  if (circleSize > 50)  {  circleSize--;  }
  if (decrease <= 0)    {  intro = false;  gameInit();  }
  }
}

void button() {
  update(mouseX, mouseY);
  
  if ((circleOver) && (!trans)) {
    fill(255);stroke(200);strokeWeight(5);
  } else {
    fill(0);
    stroke(0);
  }
  ellipse(width/2, height/2, circleSize, circleSize);
}

void update(int x, int y) {
  if ( overCircle(width/2, height/2, circleSize) ) {
    circleOver = true;
  } else {
    circleOver = false;
  }
}

void mousePressed() {
  if ((intro)&&(circleOver)) {
    fill(200);
  }

}
void mouseReleased() {
  if ((intro)&&(circleOver)) {
    trans = true;  stroke(0);
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

void whatewa() {
  translate(width/2, height/2); //för att utgå från mitten
  rotate(rotation);
  shape(s, -1-zoom, -1-zoom, 2+zoom*2, 2+zoom*2);
  rotation = rotation + 0.01;
  if (grw == true)  {
    zoom ++;
    if (zoom > width/2)  {  grw = false;  }
  }
  else if (grw == false)  {
    zoom --;
    if (zoom < 85)  {  grw = true;  }
  }
}
