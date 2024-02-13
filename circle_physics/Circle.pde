 class Circle {
 float x;
 float y;
 float height;
 float width; float radius;
 int id;
 
 Circle(float xpos, float ypos, float h, float w, int i)
{
  this.x = xpos;
  this.y = ypos;
  this.height = h;
  this.width = w;
  this.radius = w / 2;
  this.id = i;
  
}

public boolean isClickInCircle()
{
  if(Math.abs((this.x - mouseX)*(this.x - mouseX) + (this.y - mouseY)*(this.y - mouseY)) < (this.radius*this.radius))
  {
    return true;
  }
  else
  {
    return false;
  }
}

  
}
