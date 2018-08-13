class Croud {
  Gizmo giz[] = null;

  Croud(int count) {
    giz = new Gizmo[count];
  }

  void targetGizmo(PImage image, GizmoTargetMode mode) {
    float x, y; 
    color pixel;
    color pixel2;



    switch (mode) {
    case DARKAREA:

      for (int i=0; i < giz.length; i++) {
        do {
          x = random (width-1);
          y = random (height-1);
          pixel = image.get ((int) x, (int) y);
        } while (brightness (pixel) > 90);
        giz[i].target = new PVector(x, y);
      }
      println("TargetMode DARKAREA"); 
      break;
    case EDGE:
      for (int i=0; i < giz.length; i++) {
        do {
          x = random (width-1);
          y = random (height-1);
          pixel = image.get ((int) x, (int) y);
          pixel2 = image.get ((int) x+1, (int) y+1);
        } while (brightness (pixel) ==  brightness (pixel2));
        giz[i].target = new PVector(x, y);
        giz[i].direction.x = random(10)-5;
        giz[i].direction.y = random(10)-5;
      }
      println("TargetMode EDGE"); 
      break;
    case CHAOS:
      for (int i=0; i < giz.length; i++) {
        x = random (width);
        y = random (height);
        giz[i].target = new PVector(x, y);
      }
      println("TargetMode CHAOS");   
      break;
    case OUTERBOX:
      for (int i=0; i < giz.length; i++) {
        if (random(1)>0.5) {
          if (random(1)>0.5) {
            y = 0;
            x = random (width);
          } else {
            y = height;
            x = random (width);
          }
        } else {
          if (random(1)>0.5) {
            x = 0;
            y = random (height);
          } else {
            x = width;
            y = random (height);
          }
        }
        giz[i].target = new PVector(x, y);
      }
      println("TargetMode OTERBOX"); 
      break;
    case CENTERP:
      for (int i=0; i < giz.length; i++) {
        x = width/2;
        y = height/2;
        giz[i].target = new PVector(x, y);
      }
      println("TargetMode CENTERP"); 
      break;
    case NEXTEDGE:
      int j = 0;
      for (int i=1; i < giz.length; i++) {
        do {
          if (i%2==1) {
            j = 1;
          } else {
            j = 0;
          }
          x = clipx(giz[i-j].position.x+MyRand(0.1));
          y = clipy(giz[i-j].position.y+MyRand(0.1));
          pixel = image.get ((int) x, (int) y);
        } while (brightness (pixel) > 90);
        giz[i].target = new PVector(x, y);
        j=1;
      }
      println("TargetMode NEXTEDGE"); 
      break;
    }
  }

  void reseedGizmo(PImage image, GizmoReseedMode mode) {
    float x, y; 
    color pixel;
    color pixel2;




    switch (mode) {
    case NONE:

      break;
    case DARKAREA:

      for (int i=0; i < giz.length; i++) {
        do {
          x = random (width-1);
          y = random (height-1);
          pixel = image.get ((int) x, (int) y);
        } while (brightness (pixel) > 90);
        giz[i] = new Gizmo (x, y);
      }
      break;
    case EDGE:
      for (int i=0; i < giz.length; i++) {
        do {
          x = random (width-1);
          y = random (height-1);
          pixel = image.get ((int) x, (int) y);
          pixel2 = image.get ((int) x+1, (int) y+1);
        } while (brightness (pixel) ==  brightness (pixel2));
        giz[i] = new Gizmo (x, y);
      }
      break;
    case CHAOS:
      for (int i=0; i < giz.length; i++) {
        x = random (width+200)-100;
        y = random (height+200)-100;
        giz[i] = new Gizmo (x, y);
      }
      break;
    case CHECKERBOARD:
      for (int i=0; i < giz.length; i++) {
        x = random (width/con.squareSize+1);
        y = random (height/con.squareSize+1);
        giz[i] = new Gizmo (x, y);
      }
      break;
    case OUTERBOX:
      for (int i=0; i < giz.length; i++) {
        if (random(1)>0.5) {
          if (random(1)>0.5) {
            y = 0;
            x = random (width);
          } else {
            y = height;
            x = random (width);
          }
        } else {
          if (random(1)>0.5) {
            x = 0;
            y = random (height);
          } else {
            x = width;
            y = random (height);
          }
        }
        giz[i] = new Gizmo (x, y);
      }
      break;
    case DARKNEXT:

      int j = 0;
      giz[j] = new Gizmo (width/2, height/2);
      for (int i=0; i < giz.length; i++) {
        do {
          x = clipx(giz[i-j].position.x+MyRand(1));
          y = clipy(giz[i-j].position.y+MyRand(1));
          pixel = image.get ((int) x, (int) y);
        } while (brightness (pixel) > 90);
        giz[i] = new Gizmo (x, y);
        j=1;
      }
      break;
    case NEXTEDGE:
      for (int i=0; i < giz.length; i=i+2) {
        do {
          x = random (width-1);
          y = random (height-1);
          pixel = image.get ((int) x, (int) y);
          pixel2 = image.get ((int) x+1, (int) y+1);
        } while (brightness (pixel) ==  brightness (pixel2));
        giz[i] = new Gizmo (x, y);
        giz[i+1] = new Gizmo (x, y);
      }
      break;
    }
  }
  
  void drawGizmo(PGraphics myGraphics,  GizmoDrawMode gizDrwaMode, GizmoMoveMode gizMoveMode, int drawColor , int fillColor ) {

  stroke (drawColor);
  fill(fillColor);
  for (int i=0; i < giz.length-1; i++) {
    giz[i].move (gizMoveMode);
    int x = int (giz[i].position.x);
    int y = int (giz[i].position.y);
    //color pixel = typo.get (x, y);

    // DOT, CIRCLE, XLINE, QRCODE

    //if (brightness (pixel) < 40) {
    switch (gizDrwaMode) {
    case DOT: 
      myGraphics.ellipse(x, y, 3, 3); 
      break;
    case CIRCLE: 
      myGraphics.ellipse(x, y, 10, 10); 
      break;
    case XLINE: 
      if ((i%2) == 0) {
        myGraphics.line(x, y, int (giz[i+1].position.x), int (giz[i+1].position.y));
      }

      break;
    case QRCODE:
      myGraphics.rect(x*con.squareSize, y*con.squareSize, con.squareSize, con.squareSize); 
      break;
    }
  }
}


  int MyRand(float g) {
    try {
      float f1 = 1/(random(2)-1);
      float f2 = 1/(random(2)-1);
      return (int) (f1*f2*g);
    } 
    catch (Exception e) {
      return 1;
    }
  }

  float clipx(float i) {
    if (i>=width) {
      return width-1;
    }
    if (i<0) {
      return 0;
    }
    return i;
  }

  float clipy(float i) {
    if (i>=height) {
      return height-1;
    }
    if (i<0) {
      return 0;
    }
    return i;
  }
}