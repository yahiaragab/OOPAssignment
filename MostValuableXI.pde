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

  int counter = 0;

  void display(int numInLine, int lines, int Z)
  {
    float w = 60;
    float h = 80;
    float rowDist = ( widthRange / (numInLine+1) ) - (w/2);
    float colDist = heightRange / (float)lines;
    
    
    
    //draw XI
    for (int i = counter; i < numInLine + counter; i++)
    {
      float x = ( rowDist * ( i - counter) ) + rowDist;
      float y = ( heightRange - ( (colDist * Z) + colDist ) ) + (border + border/2);
      image(player.get(i).pic, x, y, w, h);
      textAlign(CENTER);
      text(player.get(i).name, x + ( w/2 ), y + ( h + (h/4) ));
    }

    counter += numInLine;
 
  }//display
  
  
  
}//end class


