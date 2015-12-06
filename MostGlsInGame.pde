class MostGlsInGame
{
  int goals;
  String name;
  String team;
  String against;
  String date;

  MostGlsInGame()
  {
    goals = 0;
    name = "";
    team = "";
    against = "";
    date = "";
  }

  MostGlsInGame(String line)
  {
    String[] data = line.split(",");
    
    goals = Integer.parseInt(data[0]);
    name = data[1];
    team = data[2];
    against = data[3];
    date = data[4];
  }


  void showMostGlsInGame()
  {
    background(0);

    float rowDist =  (heightRange + border)  / (float)alltime.size();
    float colDist = 0;
    float padding = 5;
    String[] cols ;
    String[] dataAllTime = loadStrings("MostGoalsInGame.csv");

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

