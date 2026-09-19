public class Vector{
  
  
  public float x,y,x_dir,y_dir;
  
  public Vector(float x0,float y0,float dx,float dy){
    x = x0;
    y = y0;
    x_dir = dx;
    y_dir = dy;
  }
  
  public void updateDir(float nx, float ny){
    x_dir = nx;
    y_dir = ny;
  }
}
