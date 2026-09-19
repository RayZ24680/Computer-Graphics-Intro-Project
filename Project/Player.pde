
public class Player extends Ship{
  float speed = 3;
  float rotation = 0.05;
  int cooldown = 500;
  int lastPress = -cooldown;
  
  HealthBar healthBar = new HealthBar();
  ExpBar expBar = new ExpBar();
  

  Player(float startX, float startY) {
    super(1,0,startX, startY,0);
    cannons.add(new Vector(0,0,0,-1));
    bullet_speed = 2;
  }

  public void upgrade(){
    if(index == 6){return;}
    index++;
    health += 100;
    speed += 2;
    rotation += 0.01;
    if(index == 1){
      cannons.add(new Vector(-10,0,0,-1));
      cannons.add(new Vector(10,0,0,-1));
      bullet_speed++;
      maxHealth = 70;
      maxExp = 40;
      exp = 0;
      health = maxHealth;
      cooldown -= 50;
    }
    else if(index == 2){
      cannons.add(new Vector(0,-6,1,-1));
      cannons.add(new Vector(0,-6,-1,-1));
      bullet_speed++;
      maxHealth = 90;
      maxExp = 60;
      exp = 0;
      health = maxHealth;
      cooldown -= 50;
    }
    else if(index == 3){
      cannons.add(new Vector(-1,1,-1,1));
      cannons.add(new Vector(1,1,1,1));
      bullet_speed++;
      maxHealth = 120;
      maxExp = 80;
      exp = 0;
      health = maxHealth;
      cooldown -= 50;
    }
    else if(index == 4){
      cannons.clear();
      cannons.add(new Vector(0,-2,0,-2));
      cannons.add(new Vector(-10,-1,0,-2));
      cannons.add(new Vector(10,-1,0,-2));
      cannons.add(new Vector(0,0,1,-1));
      cannons.add(new Vector(0,0,-1,-1));
      maxHealth = 150;
      maxExp = 100;
      exp = 0;
      health = maxHealth;
      bullet_speed += 3;
      cooldown -= 100;
    }
    else if(index == 5){
      cannons.add(new Vector(-1,1,-1,1));
      cannons.add(new Vector(1,1,1,1));

      maxHealth = 180;
      maxExp = 150;
      exp = 0;
      health = maxHealth;
      bullet_speed++;
      cooldown += 100;
    }
    else if(index == 6){
      cannons.add(new Vector(0,0,1,0));
      cannons.add(new Vector(0,0,-1,0));
      maxHealth = 500;
      maxExp = 250;
      exp = 0;
      health = maxHealth;
      reachedMax = true;
    }
  }

  public boolean handleInput() {
    if (keyPressed) {
      if (keyCode == UP) {
        x -= sin(-1*angle) * speed;
        y -= cos(-1*angle) * speed;
        if(x >= width){x *= 0;}else if(x <= 0){x = width;}
        if(y >= height){y *= 0;}else if(y <= 0){y = height;}
      } else if (keyCode == DOWN) {
        x += sin(-1*angle) * speed;
        y += cos(-1*angle) * speed;
        if(x >= width){x = 0;}else if(x <= 0){x = width;}
        if(y >= height){y = 0;}else if(y <= 0){y = height;}
      } else if (keyCode == LEFT) {
        angle -= rotation;
      } else if (keyCode == RIGHT) {
        angle += rotation;
      }
      else if(key == ' '){
        bullet = true;
        return true;
      }
      else if(key == 'a'){
        aimAssist = !aimAssist;
      }
    }
    if(this.expBar.maxedOut){
      this.upgrade();
      this.expBar.maxedOut = false;
    }
    return reachedMax;
  }

}
