final int MAX_BRANCHES = 1000;
final int GROWTH_RATE = 3;

Branch[] branches = new Branch[MAX_BRANCHES];

//initialize starting branch
PVector startPosition = new PVector();



void setup(){
  size(500,500);
  
  background(255);
  
  branches[0] = new Branch(startPosition);
  startPosition.x = random(0, width);
  startPosition.y = random(0, height);
  
  branches[0].get_end_coords();
}



int branchCount = 0;
void draw(){

  for (int i = 0; i <= branchCount; i++){
    branches[i].show();
  }
  
  
  if (branches[branchCount].finished != true){ 
    branches[branchCount].grow();
  }
  else if (branches[branchCount].finished == true){
    startPosition.x  = branches[branchCount].current.x;
    startPosition.y = branches[branchCount].current.y;
    
    branchCount++;
    
    branches[branchCount] = new Branch(startPosition);
    branches[branchCount].get_end_coords();
  }
  

}

class Branch{
  PVector start;
  PVector end;
  PVector current;
  int dir;
  
  boolean finished = false;
  
  Branch(PVector s){
    start = s;
    current = s;

    //pick a random direction for the branch to grow, 
    //0 = down, 1 = left, 2 = up, 3 = right
    dir = (int) random(0,4);
  }
  
  void get_end_coords(){
    
    //get end coordinates for branch
    end = new PVector();
   
    if (dir == 0){
      end.x = start.x;
      end.y = random(start.y + 50, start.y + 100);
    }
    else if (dir == 1){
      end.x = random(start.x - 50, start.x - 100);
      end.y = start.y;
    }
    else if (dir == 2){
      end.x = start.x;
      end.y = random(start.y - 50, start.y - 100);
    }
    else{
      end.x = random(start.x + 50, start.x + 100);
      end.y = start.y;
    }
    
    //prevent branch from going off screen
    if (end.x < 5){
      end.x = 5;
    }
    
    if (end.x > width - 5){
      end.x = width - 5;
    }
    
    if (end.y < 5){
      end.y = 5;
    }
    
    if (end.y > height - 5){
      end.y = height - 5;
    }
  }
   
  void grow(){

    if (dir == 0){
      if(current.y <= end.y){
        current.y += GROWTH_RATE;
      }
       
      else{
        finished = true;
      }
    }
      
    else if (dir == 1){
      if(current.x >= end.x){
        current.x -= GROWTH_RATE;
      }
      else{
        finished = true;
      }
    }
      
    else if (dir == 2){
      if(current.y >= end.y){
        current.y -= GROWTH_RATE;
      }
      else{
        finished = true;
      }
    }
      
    else if (dir == 3){
      if(current.x <= end.x){
        current.x += GROWTH_RATE;
      }
      else{
        finished = true;
      }
    }
    
  }
  
  
  void show(){
    stroke(0);
    strokeWeight(4);

    line(start.x, start.y, current.x, current.y);
    
  }
  
}
