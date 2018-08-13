import java.util.Timer;
import java.util.TimerTask;
final Timer tpage = new Timer();
final Timer tcontent = new Timer();


InfoPage infoPage[] = new InfoPage[7];


class Controller {

  boolean expandArea=false;
  //int drawMode=1;

  int sequence=0;
  boolean pane0=false;
  int count=500;
  int numberOfGizmo = 2000;
  int numberOfGizmo2 = 600;
  int delayTime=00;
  int squareSize = 10;
  boolean nextStep = true;
  int seqStep = 0;


  void init() {
    BackgroundLayer layer = new BackgroundLayer();
    initInfoPages(infoPage);   
    loadAllImages();
    loadAllText();
    createPageUpdate(infoPage[0].duration);
    createContentUpdate(100);
    println("InfoPage: " +0);
  }

  InfoPage seq() {  
    if (con.seqStep < (infoPage.length)) {
      return infoPage[seqStep];
    } else {
      return infoPage[0];
    }
  }




  void createPageUpdate(final float sec) {
    con.nextStep = true;

    tpage.schedule(new TimerTask() {
      public void run() {

        con.nextStep = true;
        /*
      if (con.seqStep < infoPage.length-1) {
         con.seqStep++;
         //robot.keyPress(java.awt.event.KeyEvent.VK_ENTER);
         //robot.mousePress(java.awt.event.InputEvent.BUTTON1_MASK);
         } else {
         con.seqStep=0;
         //txt.loadINI();
         txt.loadJSON();
         robot.mousePress(java.awt.event.InputEvent.BUTTON1_MASK);
         //robot.keyPress(java.awt.event.KeyEvent.VK_J);
         }*/

        findNxetStep();
        seqStep();
        createPageUpdate(infoPage[con.seqStep].duration);

        println("InfoPage: " +con.seqStep);
        //con.nextInfoPage();
      }
    }
    , (long) (sec*1e3));
  }

  void findNxetStep() {
    con.seqStep++;
    if (!con.seq().active) {
      findNxetStep();
    }
    if (con.seqStep >= (infoPage.length)) {
      con.seqStep = 0;
      println("Step:"+con.seqStep);
    }
  }


  void createContentUpdate(final float sec) {
    con.nextStep = true;
    tcontent.schedule(new TimerTask() {
      public void run() {
        loadAllImages();
        loadAllText();
        robot.mousePress(java.awt.event.InputEvent.BUTTON1_MASK); // to prevent screensaver
        createPageUpdate(sec);

        println("Update Conetent");
      }
    }
    , (long) (sec*1e3));
  }

  void loadAllImages() {
    for (int i = 0; i < infoPage.length; i++) {
      infoPage[i].backgroundPicture = layer.loadBackgroundImage( i);
    }
  }

  void loadAllText() {
    for (int no = 0; no < infoPage.length; no++) {
      infoPage[no].textGraphics = layer.generateBackgroundText( no);
      infoPage[no].duration = txt.getNumber(con.seqStep, "Duration");
      infoPage[no].duration = 3;
      infoPage[no].active = (txt.getNumber(con.seqStep, "Active") > 0) ? true : false;
    }
  }
}