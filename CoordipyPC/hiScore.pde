String typing = "";String saved = "";String ns = "";int indent = 25;

boolean even=true;String[] names;int[] hps;String name;
int score; int HiScore; int strLength = 0;
String line;  boolean Once;

void initHiScore()  {
  if (!Once)  {
    getScores();
    println("this hapens only once");
    //println(hps);
    Once=true;
  }
}

void drawHiScore()  {
  strLength = saved.length();
  if((strLength == 0) && (score >= hps[9]))
  {
    nameInput();
  }  else  {
    namesDisplay();
  }
}

void namesDisplay()  {
  String lines[] = loadStrings("HiScore.txt");
  background(175);
  for (int i = 0; i < lines.length; i = i+2)
  {
    line = names[i]+"  "+names[i+1];
    text(names[i],indent,(40+i*20));
    text(names[i+1],indent+200,(40+i*20));
  }
}

void nameInput()  {
  getScores();
  background(175);
  text("Type your name and press Enter. ", indent, 40);
  text(typing,indent,90);
  text(saved,indent,130);
}

int place(int HiSc)  {
       if (score >= hps[1])  {  HiSc = 1;  }
  else if (score >= hps[3])  {  HiSc = 2;  }
  else if (score >= hps[5])  {  HiSc = 3;  }
  else if (score >= hps[7])  {  HiSc = 4;  }
  else if (score >= hps[9])  {  HiSc = 5;  }
  else  {  HiSc = 0;  }
  return HiSc;
}

void getScores()  {
  String lines[] = loadStrings("HiScore.txt");
  for (int i = 0 ; i < lines.length; i++) {
    if(!even)  {    hps = int(lines);    names = lines;    }
    else if(even)  {    names = lines;    }
    even = !even;
  }
}

void putScores()  {
  saveStrings("HiScore.txt", names);
}

void arrayCorrect()  {
  switch(HiScore)  {
    case 0:
      break;
    case 1:
      names[8]=names[6];names[6]=names[4];names[4]=names[2];names[2]=names[0];names[0]=name;
      names[9]=names[7];names[7]=names[5];names[5]=names[3];names[3]=names[1];names[1]=str(score);
      break;
    case 2:
      names[8]=names[6];names[6]=names[4];names[4]=names[2];names[2]=name;
      names[9]= names[7];names[7]=names[5];names[5]=names[3];names[3]=str(score);
      break;
    case 3:
      names[8]=names[6];names[6]=names[4];names[4]=name;
      names[9]=names[7];names[7]=names[5];names[5]=str(score);
      break;
    case 4:
      names[8]=names[6];names[6]=name;
      names[9]=names[7];names[7]=str(score);
      break;
    case 5:
      names[8]=name;
      names[9]=str(score);
      break;
  }
}
