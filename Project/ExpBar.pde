public class ExpBar extends HUD{
  
  public boolean maxedOut;
  
  public ExpBar(){
    super(2,0,10,#0000FF);
    maxedOut = false;
  }
  
  public void update(int l, int maxL){
    this.updateLevel(l,maxL);
    if(l >= maxL){
      maxedOut = true;
    }
  }
}
