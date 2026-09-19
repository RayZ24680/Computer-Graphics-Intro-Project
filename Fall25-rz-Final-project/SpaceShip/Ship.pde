import java.util.ArrayList;

public class Ship{
  protected PImage player_ships[] = {loadImage("ship1.png"),loadImage("ship2.png"),loadImage("ship3.png"),loadImage("ship4.png"),loadImage("ship5a.png"),loadImage("ship5b.png"),loadImage("ship5c.png")};
  protected PImage enemy_ships[] = {loadImage("enemy1.png"),loadImage("enemy2.png"),loadImage("enemy3.png"),loadImage("enemy4.png")};
  protected int type;
  protected int index;
  protected int health; int maxHealth;
  protected int exp; int maxExp;
  public float x,y,angle;
  protected boolean bullet = false;
  protected ArrayList<Vector> cannons = new ArrayList(10);
  protected ArrayList<Bullet> bullets = new ArrayList(30);
  public boolean reachedMax = false; public boolean aimAssist;
  public float bullet_speed;
  
  public Ship(int t,int i, float x0, float y0, float a0){
    type = t;
    index = (type == 1) ? 0 : i;
    health = 50;
    maxExp = 20;
    maxHealth = 50;
    x = x0;y = y0;angle = a0;
    aimAssist = false;
  }
  
  public void drawShip(){
    PImage img = (type == 1) ? player_ships[index] : enemy_ships[index];
    pushMatrix();
    strokeWeight(2);
    translate(x, y);
    rotate(angle);
    imageMode(CENTER);
    image(img, 0, 0);
    if(aimAssist){
      stroke(#FFFF00);
      line(0,0,0,-100 * (index + 1));
    }
    popMatrix();
  }  
  public boolean collision(Ship b){
    if (abs(this.x - b.x) < 15 && abs(this.y - b.y) < 15){
      return true;
    }
    else{
      return false;
    }
  }
  
  public boolean hit(Bullet b){
    if (abs(this.x - b.x) < 10 && abs(this.y - b.y) < 10){
      return true;
    }
    else{
      return false;
    }
  }
}
