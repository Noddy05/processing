  
ArrayList<Rigidbody> balls = new ArrayList<Rigidbody>();
CircleCollider[] blocks;
float forceConservation = 0.8;
float ballSpawnerX;
float radius = 8;

void setup(){
  size(400, 400);
  ballSpawnerX = width / 2;
  int layers = 5;  
  blocks = new CircleCollider[(int)(0.5 * pow(layers, 2) + 0.5 * layers)];  
  
  int count = 0;
  for(int i = 0; i < layers; i++){
    for(int j = 0; j < i + 1; j++){
      blocks[count] = new CircleCollider(width / 2 - 25 * i + 50 * j, 100 + 50 * i, radius);
      count++;
    }
  }
  
}

Rigidbody SpawnPlingoBall(float x, float y, float r){
  return new Rigidbody(x, y, r);
}

int currentScore;
int ballsThrown = 0;
float ballXDirection = 1;
void draw(){
  strokeWeight(0);
  background(32);
  
  textSize(30);  
  fill(234);  
  text("Score: " + currentScore, width / 2, 40);
  textAlign(CENTER);
  
  textSize(30);
  textAlign(CENTER);

  if(ballsThrown < 1)  
    text("Skill level: " + currentScore, width / 2, 70);
  else
    text("Skill level: " + currentScore / ballsThrown, width / 2, 70);
    
  
  fill(255);
  ballSpawnerX += ballXDirection;
  if(ballSpawnerX > width * 0.9 || ballSpawnerX < width * 0.1)
    ballXDirection = -ballXDirection;
  for(int i = 0; i < balls.size(); i++){
    circle(balls.get(i).x, balls.get(i).y, balls.get(i).collider.radius * 2);
    balls.get(i).Update();
    balls.get(i).forceY += 0.05;
    if((balls.get(i).x > width && balls.get(i).forceX > 0) 
      || (balls.get(i).x < 0 && balls.get(i).forceX < 0))
    {
      balls.get(i).forceX *= -forceConservation;
    }
    
    if(balls.get(i).y > height)
    {
      float distance = abs(balls.get(i).x - width / 2);
      float score = pow(distance, -1) * 10000;
      currentScore += (int)score;
      ballsThrown++;
      balls.remove(i);
    }
  }
  
  for(int i = 0; i < blocks.length; i++) {
    circle(blocks[i].x, blocks[i].y, blocks[i].radius * 2);
    for(int j = 0; j < balls.size(); j++){
      if(blocks[i].CollidingWithCircle(balls.get(j).collider)){
        float lengthOfForce = sqrt(pow(balls.get(j).forceX, 2) + pow(balls.get(j).forceY, 2));
        float distance = sqrt(pow(balls.get(j).x - blocks[i].x, 2) + pow(balls.get(j).y -blocks[i].y, 2));
        balls.get(j).forceX = (balls.get(j).x - blocks[i].x) / distance * lengthOfForce * forceConservation + random(0.1);
        balls.get(j).forceY = (balls.get(j).y - blocks[i].y) / distance * lengthOfForce * forceConservation;
      }
    }
  }
  
  rect(ballSpawnerX - 20, 0, 40, 30);
}

void mouseClicked(){
  balls.add(SpawnPlingoBall(ballSpawnerX, 30, radius));
  balls.get(balls.size() - 1).forceY += 1;
}
