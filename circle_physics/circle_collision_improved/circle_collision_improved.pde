
int numballs = 5;
Ball[] balls = new Ball[numballs];

void setup() {
  size(640, 360);
  for(int i = 0; i < numballs; i++)
  {
  balls[i] = new Ball(random(width), random(height), random(15, 40), balls, i);
  }
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
