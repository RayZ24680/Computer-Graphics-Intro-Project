public class HealthBar extends HUD{
  
  
  public boolean isDead;
  
  public HealthBar(){
    super(1,0,0,#00FF00);
    isDead = false;
  }
  
  public void update(int h, int maxH){
    this.updateLevel(h,maxH);
    if(h <= 0){
      isDead = true;
    }
  }
}
