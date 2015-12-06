class TopGS
{
  String name;
  int GS;
  int A;

  TopGS()
  {
    name = "";
    GS = 0;
    A = 0;
  }

  TopGS(String line)
  {
    String[] data = line.split(",");

    name = data[0];
    GS = Integer.parseInt(data[1]);
    A = Integer.parseInt(data[2]);
  }


  void showTopScorers()
  {
    background(0);

    float rowDist =  (heightRange + border)  / (float)alltime.size();
    float colDist = 0;
    float padding = 5;
    String[] cols ;
    String[] dataAllTime = loadStrings("TopGS.csv");

    for (int i = 0; i < dataAllTime.length; i++)
    {
      cols = dataAllTime[i].split(",");
      for (int j = 0; j < cols.length; j++)
      {
        colDist = (float)widthRange / cols.length;
        textAlign(LEFT);
        stroke(255);
        fill(255);
        text( cols[j], (colDist * j), ((rowDist * i) + rowDist ) + border);
      }
      stroke(255, 0, 0);
      line(colDist * i, border, colDist * i, (float)height);
    }//end for
  }//end show topscorers
  
  
  
}//end class

