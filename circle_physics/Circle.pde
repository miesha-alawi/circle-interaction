  class Circle {
 float x, y;
 float diameter;
 float vx = 0;
 float vy = 0;
 int id;
 Circle[] others;
 
 
 Circle(float xpos, float ypos, float din, Circle[] oin, int i)
{
 x = xpos;
 y = ypos;
 diameter = din;
 id = i;
 others = oin;
 
}

public boolean isClickInCircle()
{
  float radius = diameter/2;
  if(Math.abs((this.x - mouseX)*(this.x - mouseX) + (this.y - mouseY)*(this.y - mouseY)) < (radius*radius))
  {
    return true;
  }
  else
  {
    return false;
  }
}
  void collide() {
    for (int i = id + 1; i < numcircles; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }   
  }
    void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction; 
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }

  
}
