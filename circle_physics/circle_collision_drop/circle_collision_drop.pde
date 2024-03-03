
ArrayList<Ball> balls = new ArrayList<Ball>();
int id = 0;
Ball currentBall;

void setup() {
  size(640, 360);
  balls.add(new Ball(mouseX, mouseY,random(30,70),balls,id));
  currentBall = balls.get(0);
}

void mousePressed()
{
  currentBall.released = true;
  balls.add(new Ball(mouseX, mouseY,random(30,70),balls,id++));
  currentBall = balls.get(id);
}

void draw() {
  background(51);

  for (Ball b : balls) {
    b.update();
    b.display();
    b.checkBoundaryCollision();
    b.checkCollision();
  }
  
}
