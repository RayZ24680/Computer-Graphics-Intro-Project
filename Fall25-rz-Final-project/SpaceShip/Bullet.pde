public class Bullet{
  
  private PImage player_bullets[] = {loadImage("player_bullet1.png"),loadImage("player_bullet2.png"),loadImage("player_bullet3.png"),loadImage("player_bullet4.png"),loadImage("player_bullet5.png")};
  private PImage enemy_bullets[] = {loadImage("enemy_bullet1.png"),loadImage("enemy_bullet2.png"),loadImage("enemy_bullet3.png"),loadImage("enemy_bullet4.png")};
  
  public int type;
  public int level;
  private float speed;float angle;
  private Ship self;
  public float x,y,x_dir,y_dir;
  
  public Bullet(int t, int l,Vector v,Ship s){
    type = t;
    level = l;
    angle = s.angle;
    self = s;
    speed = self.bullet_speed;
    
    x = s.x + (v.x * cos(angle)) - v.y * sin(angle);
    y = s.y + (v.x * sin(angle)) + v.y * cos(angle);
    
    x_dir = v.x_dir * cos(angle) - v.y_dir * sin(angle);
    y_dir = v.x_dir * sin(angle) + v.y_dir * cos(angle);
  }
  public void upgrade(){
    level++;
  }
  
  public void setLevel(int l){
    level = (type == 2) ? l % 4 : l % 5;
  }
  
  public void updateA(){
    this.angle = self.angle;
  }
  
  public void updatePos(){
    float h = sqrt(pow(x_dir,2) + pow(y_dir,2));
    x += (x_dir / h) * speed;
    y += (y_dir / h) * speed;
  }
  
  
  public void renderBullet(){
    PImage img = (type == 2) ? enemy_bullets[level%4] : (level < 2) ? player_bullets[0] : (level < 4) ? player_bullets[1] : player_bullets[level - 2];
    pushMatrix();
    translate(x,y);
    rotate(angle);
    strokeWeight(10);
    stroke(255,0,0);
    image(img,x_dir,y_dir);
    popMatrix();
  }
  
}
