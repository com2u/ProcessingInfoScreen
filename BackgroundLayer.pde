class BackgroundLayer {

  /*
  PImage generateBackgroundImage(PGraphics mainWindow) {
   String imageName = "background"+con.seqStep+".jpg";
   PImage myBGImage;
   try {
   if (simulation) {
   myBGImage = loadImage (imageName);
   } else {
   if (InetAddress.getByName("www.com2u.de").isReachable(1000)) {
   String url = "http://www.com2u.de/Infoscreen/"+imageName;
   myBGImage = loadImage (url, "jpg");
   } else {
   System.out.println("Internal Image "+imageName+" Load ++++++++++++++++++++++++++++++++++++++++++++++");
   myBGImage = loadImage (imageName);
   }
   }
   } 
   catch (Exception e) {
   System.out.println("Internal Image "+imageName+" Load ++++++++++++++++++++++++++++++++++++++++++++++");
   myBGImage = loadImage (imageName);
   } 
   myBGImage.resize(width, height); 
   myBGImage.filter(GRAY);
   
   return myBGImage;
   }
   */
  /*
  PGraphics generateBackgroundText() {
   String page = "Page"+con.seqStep+".";
   PGraphics bgGraphics = createGraphics(width, height);
   bgGraphics.beginDraw();
   bgGraphics.stroke(0);
   bgGraphics.fill(0);
   bgGraphics.background(255);
   bgGraphics.textSize(128);
   bgGraphics.text(txt.getText(con.seqStep,"Titel"), 10, 130); 
   
   int lines = new Integer( txt.getNumber(con.seqStep,"Lines"));
   String text="";
   for (int i = 0; i <  lines; i++) {
   text += txt.getText(con.seqStep,"text"+i)+"\n";
   }
   bgGraphics.textSize((height-300)/(lines*2.5));
   println(text);   
   bgGraphics.text(text, 10, 230, width, height);
   bgGraphics.endDraw();
   return bgGraphics;
   }
   */

  PGraphics generateBackgroundText(int no) {
    PGraphics bgGraphics = createGraphics(width, height);
    bgGraphics.beginDraw();
    bgGraphics.stroke(0);
    bgGraphics.fill(0);
    bgGraphics.background(255);
    bgGraphics.textSize(128);
    bgGraphics.text(txt.getText(no, "Titel"), 10, 130); 

    int lines = new Integer( txt.getNumber(no, "Lines"));
    String text="";
    for (int i = 0; i <  lines; i++) {
      text += txt.getText(no, "text"+i)+"\n";
    }
    bgGraphics.textSize((height-300)/(lines*2.5));
    println(text);   
    bgGraphics.text(text, 10, 230, width, height);
    bgGraphics.endDraw();
    return bgGraphics;
  }




  PImage loadBackgroundImage( int no) {
    String imageName = "background"+no+".jpg";
    PImage myBGImage;
    try {
      if (simulation) {
        myBGImage = loadImage (imageName);
      } else {
        if (InetAddress.getByName("www.com2u.de").isReachable(1000)) {
          String url = "http://www.com2u.de/Infoscreen/"+imageName;
          myBGImage = loadImage (url, "jpg");
        } else {
          System.out.println("Internal Image "+imageName+" Load ++++++++++++++++++++++++++++++++++++++++++++++");
          myBGImage = loadImage (imageName);
        }
      }
    } 
    catch (Exception e) {
      System.out.println("Internal Image "+imageName+" Load ++++++++++++++++++++++++++++++++++++++++++++++");
      myBGImage = loadImage (imageName);
    } 
    myBGImage.resize(width, height); 
    myBGImage.filter(GRAY);

    return myBGImage;
  }
}