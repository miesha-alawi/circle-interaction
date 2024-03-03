class Ball {
  PVector position;
  PVector velocity;
  PVector gravity;
  ArrayList<Ball> others;
  int id;
  boolean released;

  float radius, m;

  Ball(float x, float y, float r_, ArrayList<Ball> oin, int i)
  {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    velocity.mult(3);
    radius = r_;
    m = radius*.1;
    gravity = new PVector(0,0.01);
    others = oin;
    id = i;
    released = false;
  }

  void update() {
    if(released == true)
    {
      position.add(velocity);
      velocity.add(gravity);
    }
    else
    {
      position.x = mouseX;
      position.y = mouseY;
    }
    
  }

  void checkBoundaryCollision() {
    if (position.x > width-radius) {
      position.x = width-radius;
      velocity.x *= -1;
    } else if (position.x < radius) {
      position.x = radius;
      velocity.x *= -1;
    } else if (position.y > height-radius) {
      position.y = height-radius;
      velocity.y *= -1;
    } else if (position.y < radius) {
      position.y = radius;
      velocity.y *= -1;
    }
  }

  void checkCollision() {
      for(int i = id + 1; i < balls.size(); i++)
      { 
        
    // Get distances between the balls components
    PVector distanceVect = PVector.sub(others.get(i).position, position);

    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();

    // Minimum distance before they are touching
    float minDistance = radius + others.get(i).radius;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      others.get(i).position.add(correctionVector);
      position.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      //bTemp will hold rotated ball positions. 
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * others.get(i).velocity.x + sine * others.get(i).velocity.y;
      vTemp[1].y  = cosine * others.get(i).velocity.y - sine * others.get(i).velocity.x;

      //1D conservation of momentum equations to calculate 
      //the final velocity along the x-axis. 
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      // final rotated velocity for ball 1
      vFinal[0].x = ((m - others.get(i).m) * vTemp[0].x + 2 * others.get(i).m * vTemp[1].x) / (m + others.get(i).m);
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for ball 2
      vFinal[1].x = ((others.get(i).m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + others.get(i).m);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      // Rotate ball positions and velocities back
       //Reverse signs in trig expressions to rotate 
      // in the opposite direction 
      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      // update balls to screen position
      others.get(i).position.x = position.x + bFinal[1].x;
      others.get(i).position.y = position.y + bFinal[1].y;

      position.add(bFinal[0]);

      // update velocities
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      others.get(i).velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      others.get(i).velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
        }
      }
  }

  void display() {
    noStroke();
    fill(204);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}
