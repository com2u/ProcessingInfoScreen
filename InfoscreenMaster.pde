import java.awt.AWTException; //<>//
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.awt.event.*;


Croud croud = null;
Croud croud2 = null;
Controller con = new Controller();
BackgroundLayer layer = new BackgroundLayer();
Text txt = new Text(); 
Robot robot;


PGraphics thisPG;
PGraphics pg;
PImage bgImage;
PImage typo;
PImage mergeImage;
Boolean simulation;



void setup () {
  size (600, 600);
  //fullScreen();
  simulation = true;
  try {
  robot = new Robot();
  } catch (Exception e) {
    System.out.println("Could not start Robot");
  }

  thisPG = this.getGraphics();
  stroke (0);
  background (255);
  //txt.loadINI();
  txt.loadJSON();
  con.init();
  typo = con.seq().backgroundPicture;
  pg = con.seq().textGraphics;
  croud = new Croud(con.numberOfGizmo);
  croud2 = new Croud(con.numberOfGizmo2);
  croud.reseedGizmo(pg, con.seq().reseedMode);
  croud.targetGizmo(pg, con.seq().targetMode);
  croud2.reseedGizmo(typo, con.seq().reseedMode);
  nextSequence();
}

void seqStep() {
  mergeImage = nextSequence();

  System.out.println("Reseed "+con.seqStep);

  croud.reseedGizmo(mergeImage, con.seq().reseedMode);
  croud.targetGizmo(pg, con.seq().targetMode);
  
}

PImage nextSequence() {
  typo = con.seq().backgroundPicture;
  pg = con.seq().textGraphics;


  System.out.println("nextSequence"+java.lang.Math.random());
  switch (con.seq().mergeImageMode) {
  case 0:  
    return typo;
  case 1: 
    //image(typo, 0, 0); 
    return typo;
  case 2: 
    //image(pg, 0, 0); 
    return pg;
  case 3: 
    bgImage=typo.copy(); 
    tint(255, 127); 
     bgImage.resize(width, height); 
    background(bgImage);
    bgImage.blend(pg, 0, 0, width, height, 0, 0, width, height, OVERLAY);
    return pg;
    /*
      bgImage.filter(OPAQUE);
     bgImage.blend(pg, 0, 0, width, height, 0, 0, width, height, OVERLAY);
     //pg.blend(bgImage, 0, 0, width, height, 0, 0, width, height, ADD);
     //fill (255, con.seq().fadeGrade);
     //rect (0, 0, width, height);
     
     image(bgImage, 0, 0); 
     */
    /*
          fill (255, con.seq().fadeGrade);
     rect (0, 0, width, height);
     */

    //image(bgImage, 0, 0); 
    //break;

  case 4: 
    return typo;
  case 5: 
    bgImage=typo.copy(); 
    tint(255, 127); 
    bgImage.resize(width, height); 
    background(bgImage);
    bgImage.blend(pg, 0, 0, width, height, 0, 0, width, height, OVERLAY);
    return bgImage;
  }


  return typo;
}







void draw () {

  noStroke ();
  if (con.nextStep) {
    con.nextStep = false;
  }
  drawBackgroundImage();
  /*
  if (con.seq().fadeGrade >=0 ) {
   fill (255, con.seq().fadeGrade);
   rect (0, 0, width, height);
   }*/

  //croud.drawGizmo(thisPG, con.seq().drawMode, con.seq().moveMode, 0);
  croud.drawGizmo(thisPG, con.seq().drawMode, con.seq().moveMode, con.seq().gizmoColor, con.seq().gizmoColor2);
  con.count--;
  //image(pg, 0, 0);
  delay(con.delayTime);
}

void drawBackgroundImage() {
  switch (con.seq().mergeImageMode) {
  case 0:  
    break;
  case 1: 
    image(typo, 0, 0); 
    break;
  case 2: 
    image(pg, 0, 0); 
    break;
  case 3: 
    //bgImage=typo; 
    //bgImage.blend(pg, 0, 0, width, height, 0, 0, width, height, OVERLAY);
    image(bgImage, 0, 0); 
    //fill(255);  // Apply transparency without changing color
    tint(255, 126);  // Apply transparency without changing color
    image(pg, 0, 0);
    //    System.out.println("Case 3 "+java.lang.Math.random());

    break;

  case 4: 
    bgImage = this.drawBackground(GizmoDrawMode.DOT, GizmoMoveMode.CHAOS); 
    //bgImage=pg; 
    //bgImage.blend(typo, 0, 0, width, height, 0, 0, width, height, DARKEST  );
    bgImage.blend(pg, 0, 0, width, height, 0, 0, width, height, SUBTRACT  );
    // DIFFERENCE , BLEND , ADD , SUBTRACT , DARKEST , LIGHTEST , LIGHTEST , MULTIPLY , EXCLUSION , EXCLUSION , SCREEN , OVERLAY , HARD_LIGHT , SOFT_LIGHT , DODGE , BURN 
    translate(width/2, height/2);
    rotate(con.count/500);
    translate(-width/2, -height/2);
    scale(con.count/100);
    image(bgImage, 0, 0); 
    break;
  case 5: 
    //bgImage=typo; 
    //bgImage.blend(pg, 0, 0, width, height, 0, 0, width, height, OVERLAY);
    image(bgImage, 0, 0); 
    //fill(255);  // Apply transparency without changing color
    tint(255, 126);  // Apply transparency without changing color
    image(pg, 0, 0);
  }
}




void keyPressed() {
  con.findNxetStep();
  seqStep();

}


PGraphics drawBackground(GizmoDrawMode drawMode, GizmoMoveMode moveMode) {
  PGraphics newBackground = createGraphics(width, height);
  newBackground.beginDraw();
  newBackground.stroke(200);
  newBackground.fill(200);
  newBackground.background(255);
  croud2.drawGizmo(newBackground, drawMode, moveMode, con.seq().gizmoColor, con.seq().gizmoColor2);
  newBackground.endDraw();
  return newBackground;
}