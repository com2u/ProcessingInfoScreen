PVector globalDirection = new PVector(1, 1);


enum GizmoMode {
  AMEISE, FLIEGE, ZEBRA, QRCODE
};

enum GizmoMoveMode {
  DARKAREA, CHAOS, TARGET, TARGETVOLATILE, ANGLE
};

enum GizmoReseedMode {
  NONE, DARKAREA, EDGE, CHAOS, CHECKERBOARD, OUTERBOX, DARKNEXT, NEXTEDGE
};

enum GizmoTargetMode {
  DARKAREA, EDGE, CHAOS, OUTERBOX, CENTERP, NEXTEDGE
};

enum GizmoDrawMode {
  DOT, CIRCLE, XLINE, QRCODE
};

class Gizmo {

  PVector position = new PVector (width/2, height/2);
  PVector target = new PVector (width/2, height/2);
  PVector direction;

  float spin = 0.15;
  int invalide=0;


  Gizmo (float theX, float theY) {
    position    = new PVector (theX, theY);
    direction   = new PVector ();
    direction.x = random (-1, 1);
    direction.y = random (-1, 1);
  }



  void move (GizmoMoveMode mode) {
    switch (mode) {
    case DARKAREA:
      direction.x += random (-spin, spin);
      direction.y += random (-spin, spin);
      direction.normalize ();
      position.add (direction);

      color pixel = typo.get ((int)position.x, (int) position.y);
      if (brightness (pixel) < 2) {
        invalide =1;
        spin = 0.15;
      } else {
        spin = spin + 0.05;
      }

      if (position.x < 0 || position.x > width || (brightness (pixel) > 2) ) {
        direction.x *= -1*invalide;
        if (con.expandArea) typo.set ((int)position.x, (int) position.y, 0);
        invalide++;
      }
      if (position.y < 0 || position.y > height || (brightness (pixel) > 2) ) {
        direction.y *= -1*invalide;
        if (con.expandArea) typo.set ((int)position.x, (int) position.y, 0);
        invalide++;
      }
      break;
    case CHAOS:
      direction.x += random (-spin, spin);
      direction.y += random (-spin, spin);
      direction.normalize ();
      position.add (direction);

    case TARGET:
      direction.x += target.x-position.x;
      direction.y += target.y-position.y;
      direction.normalize ();
      position.add (direction);
      break;

    case TARGETVOLATILE:
      direction.x += target.x-position.x;
      direction.y += target.y-position.y;
      direction.normalize ();
      position.add (direction);
      for (int i = 0; i<3; i++) {
        if (random(1) >0.5) {
          position.add (direction);
        }
      }

      break;

    case ANGLE:
      direction.x += globalDirection.x;
      direction.y += globalDirection.y;
      direction.normalize ();
      position.add (direction);
      globalDirection.x += (random(1)-0.5)/10;
      globalDirection.y += (random(1)-0.5)/10;

      break;
    }
  }
}