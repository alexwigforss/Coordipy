boolean bgtrans;

float alpha=0, angle1;
float bgx=width/4, bgy=height/2, bgxspeed=0.5, bgyspeed=0.2;
boolean movdir = true, inTrans, fractdir;
PImage fractal;

//int mods = 0;
//int i=0;
//int[] wArray = new int[5];    int[] hArray = new int[5];
//int[] wghArray = new int[5];  int[] hghArray = new int[5];
//int[] wStars = new int [40];  int[] hStars = new int [40];

//int PNR = 0;int opP = 0;int opN = 200;
//boolean bgdir = true;

//PImage bg, bgin;
//float itt = 0.0;

void bginit()  {
  getstars();
  loadPoster();
  //fractal = loadImage("rymdeeenblue.jpg");
  xpos1 = width/2; ypos1 = height/2;
  xpos2 = random(width); ypos2 = random(height);
}

void scene()  {
  poster();
  if (((level % 2) == 0) && (alpha <= 40))  {    alpha = alpha + 0.5;  }//  fractspin();
  else if ((level % 2) != 0)  
  {
    if (alpha >= 0)  {  alpha = alpha - 0.5;  }
    stars();  
    //fractspin();
  }

  preTrans();
  if (((level % 4) == 0) || ((level % 4) == 1))  {  if (level != 1)  {  drawbg01();  }  }
  if (((level % 6) == 0) || ((level % 6) == 1))  {  if (level != 1)  {  drawbg02();  }  }
  if (((level % 14) == 0) || ((level % 14) == 1))  {  if (level != 1)  {  drawbg03();  }  }
  if (((level % 12) == 0) || ((level % 12) == 1))  {  if (level != 1)  {bg05math();  bg05drawer();  }  }
  
  postTrans();
  if (((level % 10) == 0) || ((level % 10) == 1))  {  if (level != 1)  {  drawbg04();  }  }
  if (((level % 8) == 0) || ((level % 8) == 1))  {  if (level != 1)  {drawbg06();  }  }
  if (((level % 16) == 0) || ((level % 16) == 1))  {  if (level != 1)  {drawbg07();  }  }

  movdir();  bgXYAdd();  
  
  tint(255,255);  fill(255);  rectMode(CORNER);
    text("lives: " + nfp(lives, 2, 0) + " points: " + nfp(points, 1,0)
    + " level: " + nfp(level, 1,0) + nfp(round, 1, 0), 0, 0, width, height); 
}

void loadPoster()  {
  PNR++;
  bg = loadImage("bg" + PNR + ".jpg");
  if ((PNR==10)||(PNR==level))  {  PNR=0;  }
  //println(PNR);// + "  " + right + "  " + up + "  " + down);

}

void poster()  {
   imageMode(CORNER);
  if (bgdir)  {
    opP = (opP + 1) % 200;
    tint(255,opP);image(bg, 0, 0, width, height);
    if (opP >= 199)  {  bgdir = false;  }
  }  else if  (!bgdir)  {
    opN = (opN - 1) % 200;
    tint(255,opN);image(bg, 0, 0, width, height);
    if (opN <= 1)  {
      bgdir = true; opN = 200;
      if (bgtrans)  {
        loadPoster();
        bgtrans=!bgtrans;
      }
    }
  }
}

/*void fractspin()  {
  imageMode(CENTER);tint(255,map(alpha,0,40,100,0));
  scale(1.7);
  translate(width/3.5,height/2/2);
  rotate(itt);
  image(fractal, 0, 0, width, height);
  rotate(-itt);
  if ((frameCount % 4) == 0)  {
    if       (fractdir == false) {  increase();  }
    else if  (fractdir == true)  {  decrease();  }
    }
  translate(-(width/3.5),-(height/2/2));scale(0.59);
}
*/
/*
void stars()  {      
  if (mods == 0) {  getArray();  }
    strokeWeight(1);
    for (int a = 0;a < 40; a++)  {
      stroke(random(50,200));
      point(wStars[a],hStars[a]);
  }
  for (int a = 0;a < 5; a++) {
    point(random(0, width),random(0, height));
    strokeWeight(random(0,10));stroke(255,random(50,150));
    point(wArray[a], hArray[a]);
    strokeWeight(random(0,6));stroke(255,random(0,100));
    point(wghArray[a], hghArray[a]);
  }
  stroke(255);  strokeWeight(1);
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
*/

void preTrans()  {  translate(bgx,bgy);  }

void postTrans()  {  translate(-bgx,-bgy);  }

void bgXYAdd()  {
  bgx = bgx + bgxspeed;  bgy = bgy + bgyspeed;
  if ((bgx > width) || (bgx < 0)) {
    bgxspeed = bgxspeed * -1;  }
  if ((bgy > height) || (bgy < 0)) {
    bgyspeed = bgyspeed * -1;  }
}

void movdir()  {
  if (movdir)  {
    mod=mod+0.1;
    if (mod >= height/2)  {  movdir = !movdir;  }
  }  else if (!movdir)  {
    mod=mod-0.1;
    if (mod <= 0)  {  movdir = !movdir;  }
  }
    angle1 += 0.1;
    if (angle1 >= 360)  {  angle1=0;  }
}

void increase()  {  itt = itt + 0.005;  if (itt >= TWO_PI)  {  fractdir=true;  }}
void decrease()  {  itt = itt - 0.005;  if (itt <= 0.0)  {  fractdir=false;  }}
