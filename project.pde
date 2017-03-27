PImage start1,start2,bg, crying, moneyBag, hand;
PImage [] money = new PImage[3];
boolean isPlaying = false;
boolean money1Catch = true, money2Catch = true,money3Catch = true;;
final int MONEY_W = 70;
final int MONEY_H = 70;
final int MONEY_MIN_X = 0;
final int MONEY_MAX_X = 630; 
final int HAND_W = 150;
final int HAND_H = 100;
final int HAND_Y = 530;
final int CRYING_W = 60;
final int CRYING_H = 60;
final int GROUND_Y = 640;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

int gameState;
float handX;
float money1X, money2X, money3X,money1Y, money2Y ,money3Y ;
float money1SpeedY, money2SpeedY,money3SpeedY;
float usTNtd = random(29, 31);
float engTNtd = random(39, 41);
float jpTNtd = random(0.26, 0.3);
float score = 0;

void setup() {
  size(700, 700);
  gameState = GAME_START;
  for (int i = 0; i < 3; i++) {
    money[i] = loadImage("img/"+ (i + 1) + ".png");
  }
  bg = loadImage("img/bg.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  crying = loadImage("img/crying.png");
  moneyBag = loadImage("img/moneyBag.png");
  hand = loadImage("img/hand.png");
  money1X = random(MONEY_MIN_X, MONEY_MAX_X);
  money2X = random(MONEY_MIN_X, MONEY_MAX_X);
  money3X = random(MONEY_MIN_X, MONEY_MAX_X);
  money1SpeedY = random(6, 12);
  money2SpeedY = random(6, 12);
  money3SpeedY = random(6, 12);
  money1Y = -200;
  money2Y = 0;
  money3Y = -100;
  textFont(createFont("arialBlack.ttf", 20));
  textAlign(LEFT);
}

void draw() {

  switch(gameState) {
    
  case GAME_START:
    image(start1, 0, 0,700,700) ;
  
    //mouse action

    if ( mouseX > 220 && mouseX < 480 && mouseY < 580 && mouseY > 495){
      image(start2, 0, 0,700,700) ;
      if ( mousePressed ){
        //click
        isPlaying = true ;
        gameState = GAME_RUN;
      }
    }
  
    
  case GAME_RUN:
    if (isPlaying) {

      image(bg, 0, 0, 700, 700);
      scoreChange();

      //Condition: money0 ( eng ) is Catched or Not
      if (money1Catch) {
        image(money[0], money1X, money1Y, MONEY_W, MONEY_H);
        money1Y += money1SpeedY;
        if (money1Y > HAND_Y) {
          if (  handX < money1X &&  money1X+MONEY_W <  handX +HAND_W) {
            money1Y = 0;
            money1X = random(MONEY_MIN_X, MONEY_MAX_X); 
            money1SpeedY = random(6, 12);
            score += engTNtd;
          } else {
            money1Catch = false;
          }
        }
      }
      if (money1Catch == false) {
        image(crying, money1X, GROUND_Y, CRYING_W, CRYING_H);
      }

      //Condition: money1 ( us ) is Catched or Not
      if (money2Catch) {
        image(money[1], money2X, money2Y, MONEY_W, MONEY_H);
        money2Y += money2SpeedY;
        if (money2Y > HAND_Y) {
          if (  handX < money2X &&  money2X+MONEY_W <  handX +HAND_W) {
            money2Y = 0;
            money2X = random(MONEY_MIN_X, MONEY_MAX_X); 
            money2SpeedY = random(6, 12);
            score += usTNtd;
          } else {
            money2Catch = false;
          }
        }
      }
      if (money2Catch == false) {
        image(crying, money2X, GROUND_Y, CRYING_W, CRYING_H);
      }

     
      //Condition: money2 ( jp ) is Catched or Not
      if (money3Catch) {
        image(money[2], money3X, money3Y, MONEY_W, MONEY_H);
        money3Y += money3SpeedY;
        if (money3Y > HAND_Y) {
          if (  handX < money3X &&  money3X+MONEY_W <  handX +HAND_W) {
            money3Y = 0;
            money3X = random(MONEY_MIN_X, MONEY_MAX_X); 
            money3SpeedY = random(6, 12);
            score += jpTNtd;
          } else {
            money3Catch = false;
          }
        }
      }
      if (money3Catch == false) {
        image(crying, money3X, GROUND_Y, CRYING_W, CRYING_H);
      }
      
      //game over
     if (money1Catch == false && money2Catch == false && money3Catch == false) {
        gameState = GAME_OVER;
      }

      //Control Basket Movement
      handX = mouseX - HAND_W/2;
      if ( mouseX + HAND_W/2 > width ) {
        handX = width - HAND_W ;
      }
      if ( mouseX - HAND_W/2 < 0 ) {
        handX =  0 ;
      }
      image(hand, handX, HAND_Y, HAND_W, HAND_H);
    }
    break;
    
    
      

  case GAME_OVER:
    isPlaying = false;
    image(bg, 0, 0, 700, 700);
    image(crying, money1X, GROUND_Y, CRYING_W, CRYING_H);
    image(crying, money2X, GROUND_Y, CRYING_W, CRYING_H);
    image(crying, money3X, GROUND_Y, CRYING_W, CRYING_H);
    text("Click To Play Again", 480, 620);
    scoreChange();
    if (mousePressed) {
      gameState = GAME_RUN;
    }
    break;
  }
}

void scoreChange() { 
  fill(#FFFFFF); 
  textSize(32); 
  text(score, 530, 95); 
  textSize(17); 
  text(usTNtd, 150, 90);
  text(engTNtd, 150, 117);
  text(jpTNtd, 160, 144);
}

void mouseClicked() {
  if (!isPlaying) {
    //restart
    isPlaying = true;
    money1Catch = true;
    money2Catch = true;
    money3Catch = true;
    money1Y = -80;
    money2Y = 0;
    money3Y = -150;
    score = 0;
    usTNtd = random(29, 31);
    engTNtd = random(39, 41);
    jpTNtd = random(0.26, 0.3);
  }
}