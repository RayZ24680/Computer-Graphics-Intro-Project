public class Enemy extends Ship{
  public float dir_x, dir_y;
  public float exp;
  public int fireCooldown;
  public int time = -fireCooldown;
  
  

  Enemy(int i,float x0, float y0, float xDir, float yDir) {
    super(2, i ,x0, y0,atan2(yDir,xDir));
    dir_x = xDir;
    dir_y = yDir;
    bullet_speed = 1;
    exp = 100;
    fireCooldown = 5200 - 100*i;
    
    if(index >= 0 && index < 1){
      cannons.add(new Vector(0,-2,1,0));
      cannons.add(new Vector(0,-2,-1,0));
      bullet_speed += 0.5;
      exp += 20;
    }
    if(index == 1){
      cannons.add(new Vector(0,-3,0,-1));
      cannons.add(new Vector(0,3,0,1));
      bullet_speed += 0.5;
      exp += 40;
    }
    if(index >= 2){
      cannons.add(new Vector(0,0,0,1));
      cannons.add(new Vector(0,0,0,-1));
      cannons.add(new Vector(0,0,1,0));
      cannons.add(new Vector(0,0,-1,0));
      cannons.add(new Vector(0,0,1,1));
      cannons.add(new Vector(0,0,1,-1));
      cannons.add(new Vector(0,0,-1,1));
      cannons.add(new Vector(0,0,-1,-1));
      bullet_speed += 1;
      exp += 50;
      if(index == 3){
        bullet_speed += 2;
        exp += 100;
      }
    }
  }

  void update() {
    x += dir_x;
    y += dir_y;

    if (x < 0 || x > width) dir_x *= -1;
    if (y < 100 || y > height) dir_y *= -1;
  }
  
  public boolean canFire(){
    return millis() - time >= fireCooldown;
  }
  
  public ArrayList<Bullet> load(){
    ArrayList<Bullet> shots = new ArrayList();
    for(Vector v : cannons){
      shots.add(new Bullet(2,index,v,this));
    }
    time = millis();
    return shots;
  }
}
