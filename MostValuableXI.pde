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
  
  
  void drawPitch()
  {
    fill(0);
    stroke(150);
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
  }//end drawPitch
  
  int counter = 0;

  void drawXI(int numInLine, int lines, int Z)
  {
    float w = 60;
    float h = 80;
    float padding = 10;
    float rowDist = ( widthRange / (numInLine + 1) ) - (w/2);
    float colDist = (heightRange / (float)lines) + padding;

    //draw XI
    for (int i = counter; i < numInLine + counter; i++)
    {
      float x = ( ( ( rowDist * ( i - counter) ) + rowDist ) + border ) + (w/2);
      
      if(i == 0 || i == 10)
      {
        x -= w/2;
      }
      
      float y = ( heightRange - ( (colDist * Z) + colDist ) ) + (border*2);
      rect(x, y, w, h);
      image(player.get(i).pic, x, y, w, h);
      stroke(255);
      textSize(20);
      fill(255);
      textAlign(CENTER);
      text(player.get(i).name, x + ( w/2 ), y + ( h + (h/4) ));
    }

    counter += numInLine;

    if (counter > player.size())
    {
      counter = 0;
    }
  }//display
  
  
}//end class

