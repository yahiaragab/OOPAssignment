//draw team formation
class MostValuableXI
{
  int num;
  PImage pic;
  String name;
  String pos;
  int age;
  int value;

  MostValuableXI()
  {
    num = 0;
    pic = null;
    name = "";
    pos = "";
    age = 0;
    value = 0;
  }

  MostValuableXI(String line, int i)
  {
    String[] data = line.split(",");

    num = Integer.parseInt(data[0]);
    pic = loadImage( i + ".jpg");
    name = data[1];
    pos = data[2];
    age = Integer.parseInt(data[3]);
    value = Integer.parseInt(data[4]);
  }

  //draw football pitch in background
  void drawPitch()
  {
    fill(50, 205, 50);
    stroke(230);
    strokeWeight(5);
    rect(border, border, widthRange, heightRange);

    float sections = 8;
    float colDist = widthRange / sections;
    float rowDist = heightRange / sections;

    for (int i = 0; i < sections; i++)
    {
      if (i == 1 || i == 7)
      {
        line( border + (colDist * i), border, border + (colDist * i), (rowDist*2) + border);
        line( border + (colDist * i), border + (rowDist * 6), border + (colDist * i), heightRange + border);
        line( border + (colDist * 3), border + (rowDist*i), border + (colDist * 5), border + (rowDist*i));
      }
      if (i == 3 || i == 5)
      {
        line( border + (colDist * i), border, border + (colDist * i), (rowDist*1) + border);
        line( border + (colDist * i), border + (rowDist*7), border + (colDist * i), heightRange + border);
      }
      if ( i == sections/2)
      {
        line( border, border + (rowDist * i), widthRange + border, border + (rowDist * i));
        noFill();
        ellipse( (widthRange/2.0f) + border, (heightRange/2.0f) + border, rowDist, rowDist);
      }
      if (i==2 || i ==6)
      {
        line( border + (colDist * 1), border + (rowDist*i), border + (colDist * 7), border + (rowDist*i));
      }
    }//end for
    strokeWeight(1);
  }//end drawPitch

  
  //my algorithm for drawing the formation
  int counter = 0;

  void drawXI(int numInLine, int lines, int Z)
  {
    fill(255);
    text("MOST VALUABLE XI (MARKET VALUE:453.000.000€)", widthRange/2, border/2);
    float w = 60;
    float h = 80;
    float rowDist = ( widthRange / (numInLine+1) ) - (w/2);
    float colDist = heightRange / (float)lines;

    //draw XI
    for (int i = counter; i < numInLine + counter; i++)
    {
      float x = ( ( ( rowDist * ( i - counter) ) + rowDist ) + border ) + (w/2);

      if ( (i - counter) == 0 )
      {
        x -= (w/2);
      }

      float y = ( heightRange - ( (colDist * Z) + colDist ) ) + (border + border/2);
      noStroke();
      fill(255, 165, 0);
      rect( x - 5, y - 5, w + 10, h+ 10);
      image(player.get(i).pic, x, y, w, h);
      stroke(0);
      fill(0);
      textAlign(CENTER);
      text(player.get(i).pos + ": " + player.get(i).name, x + ( w/2 ), y + ( h + (h/4) ));
    }

    counter += numInLine;

    if (counter > player.size())
    {
      counter = 0;
    }
  }//display
  
}//end class

