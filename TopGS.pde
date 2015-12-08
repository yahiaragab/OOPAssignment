//top Goals scorers in PL history
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

  //show table
  void showTopScorers()
  {
    background(100,149,237);
    text(scorer.size() + " Players", border * 4, 20);
    float rowDist =  (heightRange + border)  / ((float)scorer.size()+1);
    float colDist = 0;
    float padding = 15;
    int numCols = 3;
    String[] ColNames = {"Name", "Goals Scored", "Assists"};

    textAlign(LEFT);
    for (int i = 0; i < scorer.size (); i++)
    {
      for (int j = 0; j < numCols; j++)
      {
        
          text( ColNames[j],   colDist * (j) + padding, border+rowDist);
        
        colDist = (float)widthRange / (numCols);
        //textAlign(RIGHT);
        stroke(255);
        fill(255);

        if (j == 0)
          text( scorer.get(i).name, (colDist * (j))  + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        else if (j == 1)
          text( scorer.get(i).GS, (colDist * (j))  + padding, ((rowDist * i) + rowDist ) + (border+border/3));
         else if (j == 2)
          text( scorer.get(i).A, (colDist * (j))  + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        
      }
      stroke(0);
      line(0, border + (rowDist * (i+1)), width, border + (rowDist*(i+1)));
      if ( i <= 1 || i > 3)
      line(colDist * (i+1), border, colDist * (i+1), (float)height);
    }
  }//end showTable
  
  
  
}//end class

