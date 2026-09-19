public class HUD{
  public int type;
  public float level;
  public int x;
  public int y;
  public int col;
  public boolean isDead;
  
  
  public HUD(int t, int x0, int y0, int c){
    type = t;
    x = x0;
    y = y0;
    level = (t == 1) ? width : 0;
    col = c;
    isDead = false;
  }
  
  public void drawHUD(){
    pushMatrix();
    rectMode(CORNER);
    fill(32,32,32);
    strokeWeight(1);
    stroke(255);
    rect(0,y,width,y+10);
    fill(col);
    rect(0,y,level,y+10);
    popMatrix();
  }
  public void updateLevel(int l, int maxL){
    level =  (float)l / (float)maxL * (float)width;
  }
  
}
