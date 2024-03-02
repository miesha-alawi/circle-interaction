
//circle
Circle[] circles = new Circle[10];
int numcircles = 10;
Circle selected = null;
boolean overCircle = false;
float velocityY = 0;
float gravity = 0.2;
float spring = 0.05;
float friction = -0.9;

//misc
boolean locked = false;
float xOffset = 0.0;
float yOffset = 0.0;


void setup() {
  size(640, 480);
  //adds ten balls with randomized size and xy position
  for(int i = 0; i < 10; i++)
  {
  circles[i] = new Circle(random(width), random(height), random(30, 70), circles, i);
  }
}

void draw() {
  background(155); //clears background
  for(Circle c : circles)
  {
    c.collide();
    c.move();
    c.display();
     
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
 
