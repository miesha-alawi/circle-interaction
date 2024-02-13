
//circle
ArrayList<Circle> circles = new ArrayList<Circle>();
Circle selected = null;
boolean overCircle = false;

//misc
boolean locked = false;
float xOffset = 0.0;
float yOffset = 0.0;


void setup() {
  size(640, 480);
  //adds ten balls with randomized size and xy position
  for(int i = 0; i < 10; i++)
  {
  float x = (float)Math.floor(Math.random() * 640); //screen height limit
  float y = (float)Math.floor(Math.random() * 480); //screen width limit
  float size = (float)Math.floor(Math.random() * 100 + 10); //min and max size
  Circle circle = new Circle(x, y, size, size, i);
  circles.add(circle);
  }
}

void draw() {
  background(155); //clears background
  for(Circle c : circles)
  {
    
    if(c.isClickInCircle())
      {
      overCircle = true;
      stroke(255); //white border when mouse is over circle
      selected = c; 
      }
    else
      {
      overCircle = false;
      stroke(155);
      }
   for(Circle ball : circles)
  {
    for(Circle target : circles)
    {
      if(ball.id != target.id) //avoids self-checking
      {
        if(DoCirclesOverlap(ball.x, ball.y, ball.radius, target.x, target.y, target.radius))
          {
            //distance between ball centers
            float fDistance = (float)Math.sqrt((ball.x - target.x)*(ball.x - target.x) + (ball.x - target.x)*(ball.x - target.x));
            
            //calculate displacement required
            float fOverlap = 0.5 * (fDistance - ball.radius - target.radius);
            
            //displace current ball away from collision
            ball.x -= fOverlap * (ball.x - target.x) / fDistance;
            ball.x -= fOverlap * (ball.y - target.y) / fDistance;
            
            //displace target ball away from collision
            target.x += fOverlap * (ball.x - target.x) / fDistance;
            target.y += fOverlap * (ball.y - target.y) / fDistance;
        
          }
      }
      
    }
  }
    //border checks
    if(c.x >= 640 - c.radius)
    {
      c.x = 640 - c.radius;
    }
    if(c.x <= 0 + c.radius)
    {
      c.x = 0 + c.radius;
    }
    if(c.y <= 0 + c.radius)
    {
      c.y = 0 + c.radius;
    }
    if(c.y >= 480 - c.radius)
    {
      c.y = 480 - c.radius;
    }
    
    //draw circle
     ellipse(c.x, c.y, c.width, c.height);
     
  }
  
  
  
  
  
}

void mousePressed() {
  if(overCircle)
  {
    locked = true;
  }
  else
  {
    locked = false;
  }
  xOffset = mouseX - selected.x;
  yOffset = mouseY- selected.y;
  
}

void mouseDragged() {
  if(locked)
  {
    selected.x = mouseX-xOffset;
    selected.y = mouseY-yOffset;
  }
}

 void mouseReleased() {
   locked = false;
 }
 
 boolean DoCirclesOverlap(float x1, float y1, float r1, float x2, float y2, float r2)
 {
   return (Math.abs((x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2)) <= (r1 + r2)*(r1 + r2));

 }
 
