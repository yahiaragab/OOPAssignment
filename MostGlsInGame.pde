//most goals in a single game
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

  //table show
  void showMostGlsInGame()
  {
    background(100, 149, 237);
    text(scorerGame.size() + " Players", border * 4, 20);
    float rowDist =  (heightRange + border)  / ((float)scorerGame.size()+1);
    float colDist = 0;
    float padding = 15;
    int numCols = 5;
    String[] ColNames = {
      "# Goals", "Name", "Team", "Against", "Date"
    };

    textAlign(LEFT);
    for (int i = 0; i < scorerGame.size (); i++)
    {
      for (int j = 0; j < numCols; j++)
      {

        text( ColNames[j], colDist * (j) + padding, border+rowDist);

        colDist = (float)widthRange / (numCols);
        //textAlign(RIGHT);
        stroke(255);
        fill(255);

        if (j == 0)
          text( scorerGame.get(i).goals, (colDist * (j))  + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        else if (j == 1)
          text( scorerGame.get(i).name, (colDist * (j))  + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        else if (j == 2)
          text( scorerGame.get(i).team, (colDist * (j))  + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        else if (j == 3)
          text( scorerGame.get(i).against, (colDist * (j))  + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        else if (j == 4)
          text( scorerGame.get(i).date, (colDist * (j))  + padding, ((rowDist * i) + rowDist ) + (border+border/3));
      }
      stroke(0);
      line(0, border + (rowDist * (i+1)), width, border + (rowDist*(i+1)));
      line(colDist * (i+1), border, colDist * (i+1), (float)height);
    }
  }//end showTable
}//end class

