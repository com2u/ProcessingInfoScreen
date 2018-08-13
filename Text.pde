import java.net.*;
import java.io.*;
import java.util.*;

class Text {
  String subtitel="";
  JSONArray screenJSON;
  JSONObject screen;
 /* 
 String titel="";
  int numberOfPages=0;
  Properties p = null;
 
  void loadINI() {
    p = new Properties();

    try {
      if (simulation) {
        p.load(new FileInputStream("D:\\Data\\Projects\\CCC\\ProcessingCircle1\\Infoscreen016\\infoscreen.ini"));
      } else {

        URL u = new URL("http://www.com2u.de/Infoscreen/infoscreen.ini");
        InputStream in = u.openStream();
        p.load(in);
      }
      System.out.println("Titel = " + p.getProperty("Titel"));
      System.out.println("SubTitel = " + p.getProperty("SubTitel"));
      titel = p.getProperty("Titel");
      subtitel = p.getProperty("SubTitel");
      numberOfPages = new Integer( p.getProperty("Pages"));
    }
    catch (Exception e) {
      System.out.println("Can't load INI");
      System.out.println(e);
    }
  }


  String getTextOld(String search) {
    String s = p.getProperty(search);
    s = s.replace("\"", "");
    return s;
  }
  
  
  
  try {
      if (simulation) {
        myBGImage = loadImage (imageName);
      } else {
        if (InetAddress.getByName("www.com2u.de").isReachable(1000)) {
        String url = "http://www.com2u.de/Infoscreen/"+imageName;
        myBGImage = loadImage (url, "jpg");
        } else {
          System.out.println("Internal Load ++++++++++++++++++++++++++++++++++++++++++++++");
          myBGImage = loadImage (imageName);
        }
      }
    } 
    catch (Exception e) {
      System.out.println("Internal Load");
      myBGImage = loadImage (imageName);
    } 
    
  */
  
    void loadJSON() {
      
      try {
      
        if (InetAddress.getByName("www.com2u.de").isReachable(1000)) {
        //String url = "http://www.com2u.de/Infoscreen/"+imageName;
        screenJSON = loadJSONArray("http://www.com2u.de/Infoscreen/Infoscreen.json");
        } else {
          System.out.println("Internal JSON Load ++++++++++++++++++++++++++++++++++++++++++++++");
          screenJSON = loadJSONArray("Infoscreen.json");
        }
      
    } 
    catch (Exception e) {
      System.out.println("Internal JSON Load");
      screenJSON = loadJSONArray("Infoscreen.json");
    } 
    
    //screenJSON = loadJSONArray("Infoscreen.json");
    //screenJSON = loadJSONArray("http://www.com2u.de/Infoscreen/Infoscreen.json");
    println(screenJSON.size());
  
    for (int i = 0; i < screenJSON.size(); i++) {

      screen = screenJSON.getJSONObject(i); 

      int id = screen.getInt("page");
      String title = screen.getString("Titel");
      int lines = screen.getInt("Lines");

      println(id + ", " + title + ", " + lines);
    }
    
  }

  String getText(int page, String search) {
    screen = screenJSON.getJSONObject(page); 
    String s = screen.getString(search);
    s = s.replace("\"", "");
    return s;
  }
  
  int getNumber(int page, String search) {
    screen = screenJSON.getJSONObject(page); 
    int i = screen.getInt(search);
    return i;
  }
}