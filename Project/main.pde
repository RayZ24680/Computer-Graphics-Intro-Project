import java.util.ArrayList;
Player falcon;

ArrayList<Enemy> Eships = new ArrayList(2);
ArrayList<Bullet> bullets = new ArrayList(200);

PImage bg;

boolean loss;

int enemy_cooldown = 0;
int spawnTime = 5000;
int lastSpawned = -spawnTime;
int gameState;

void setup() {
  size(1200, 654);
  falcon = new Player(width/2,height/2);
  Eships.add(new Enemy(1,30,100,1,0));
  Eships.add(new Enemy(3,width, height - 50, -1,0));
  bg = loadImage("background.png");
  loss = false;
  gameState = 0;
}

void draw() {
  background(bg);
  
  switch(gameState){
    case 0:
      showMenu();
      break;
     case 1:
       runGame();
       break;
      case 2:
        showPause();
        break;
       case 3:
         showDefeat();
         break;
        case 4:
          showVictory();
          break;
  }
}

void showMenu(){
  textAlign(CENTER);
  textSize(60);
  fill(255);
  text("SPACE RANGER", width/2, height/2 - 100);
  textSize(30);
  text("Press ENTER to Start", width/2,height/2);
}

void showPause(){
  textAlign(CENTER);
  textSize(60);
  fill(255,255,0);
  text("PAUSED", width/2, height/2);
  textSize(30);
  text("Press P to Resume", width/2, height/2 + 50);
  text("Press R to Restart", width/2,height/2 + 100);
}

void showDefeat(){
  textAlign(CENTER);
  textSize(100);
  fill(255,0,0);
  text("DEFEAT", width/2, height/2);
  textSize(30);
  text("Press R ro restart", width/2, height/2 +100);
}

void showVictory(){
  textAlign(CENTER);
  textSize(100);
  fill(0,255,0);
  text("VICTORY", width/2, height/2);
  textSize(30);
  text("Press R to Restart", width/2, height/2 +100);
}

void keyPressed(){
  if(gameState == 0 && keyCode == ENTER){
    restartGame();
    gameState = 1;
  }
  else if(gameState == 1 && key == 'p'){
    gameState = 2;
  }
  else if(gameState == 2 && key == 'p'){
    gameState = 1;
  }
  else if((gameState == 2 || gameState == 3 || gameState == 4) && key == 'r'){
    restartGame();
    gameState = 1;
  }
}

void restartGame(){
  falcon = new Player(width/2,height/2);
  Eships.clear();
  bullets.clear();
  Eships.add(new Enemy(1,30,100,1,0));
  Eships.add(new Enemy(3,width,height - 50, -1,0));
  loss = false;
  lastSpawned = -spawnTime;
}

void runGame(){
  boolean sh = falcon.handleInput();
  falcon.drawShip();
  
  if(sh && millis() - falcon.lastPress >= falcon.cooldown){
    falcon.lastPress = millis();
    for(Vector v : falcon.cannons){
      bullets.add(new Bullet(1,falcon.index,v,falcon));
    }
  }
  
  if(millis() - lastSpawned >= spawnTime){
    lastSpawned = millis();
    int levels = (int)random(0,4);
    float x_val = choice(0,width);
    float y_val = random(50,height-50);
    float x_dir = random(-1,1);
    float y_dir = random(-1,1);
    if(x_dir == 0 && y_dir == 0){x_dir = 1;}
    Eships.add(new Enemy(levels,x_val,y_val,x_dir,y_dir));
  }
  
  falcon.healthBar.update(falcon.health,falcon.maxHealth);
  falcon.expBar.update(falcon.exp,falcon.maxExp);
  falcon.healthBar.drawHUD();
  falcon.expBar.drawHUD();
  
  for(int i = 0; i < Eships.size(); i++){
    Enemy ship = Eships.get(i);
    ship.update();
    ship.drawShip();
    if(ship.canFire()){
      bullets.addAll(ship.load());
    }
    
    for(int j = bullets.size() -1; j >= 0; j--){
      Bullet b = bullets.get(j);
      b.renderBullet();
      b.updatePos();
      if(b.x < 0 || b.x > width ||b.y < 50 || b.y > height){
        bullets.remove(j);
      }
      if(ship.hit(b) && b.type == 1){
        Eships.remove(ship);
        falcon.exp += ship.type * (ship.index+1);
      }
      if(falcon.hit(b) && b.type == 2){
        falcon.health -= (b.level + 2);
        if(falcon.healthBar.isDead){
          endgame();
          gameState = 3;
          return;
        }
      }
      
    }
    if(falcon.collision(ship)){
      falcon.health -= ship.index + 5;
      Eships.remove(ship);
    }
    
  }
  if(Eships.size() == 0){
    gameState = 4;
  }
}


void endgame(){
  loss = true;
}
