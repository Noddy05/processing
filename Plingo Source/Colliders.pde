class CircleCollider{
  
  float x, y, radius;
  
  boolean CollidingWithCircle(CircleCollider collider) {
    return sqrt(pow(x - collider.x, 2) + pow(y - collider.y, 2)) < radius + collider.radius;
  }
  
  CircleCollider(){
    x = width / 2;
    y = height / 2;
    radius = 10;
  }
  
  CircleCollider(float x, float y, float radius){
    this.x = x;
    this.y = y;
    this.radius = radius;
  }
}

class Rigidbody{
  CircleCollider collider;
  
  float x, y;
  float forceX, forceY;
  
  void Update(){
    x += forceX;
    y += forceY;
    
    collider.x = x;
    collider.y = y;
  }
  
  Rigidbody(){
    x = width / 2;
    y = height / 2;
    forceX = 0;
    forceY = 0;
    collider = new CircleCollider();
    collider.x = x;
    collider.y = y;
    collider.radius = 10;
  }
  
  Rigidbody(float x, float y, float radius){
    this.x = x;
    this.y = y;
    forceX = 0;
    forceY = 0;
    collider = new CircleCollider();
    collider.x = x;
    collider.y = y;
    collider.radius = radius;
  }
}
