//class for team spending in last 10 years
class Spending
{
  int rank;
  String clubName;
  float spent;
  float sold;
  float nett;
  float perSeason;
  
  Spending()
  {
    rank = 0;
    clubName="";
    spent = 0;
    sold = 0;
    nett = 0;
    perSeason = 0;
  }
  
  Spending(String line)
  {
    String[] data = line.split(",");
    
    rank = Integer.parseInt(data[0]);
    clubName= data[1];
    spent = Float.parseFloat(data[2]);
    sold = Float.parseFloat(data[3]);
    nett = Float.parseFloat(data[4]);
    perSeason = Float.parseFloat(data[5]);
    
  }
  
  float getSpendField(int team, int i)
  {
    switch (i)
    {
    case 2:
      {
        return spending.get(team).spent;
      }
    case 3:
      {
        return spending.get(team).sold;
      }
    case 4:
      {
        return spending.get(team).nett;
      }
    case 5:
      {
        return spending.get(team).perSeason;
      }
      default:
      {
        return -1;
      }
    }
    
  }//end get field
  
  //show table
  void showSpendTable()
  {
    background(100,149,237);
    text(pllast10yrs.size() + " Teams", border * 4, 20);
    float rowDist =  (heightRange + border)  / ((float)spending.size()+1);
    float colDist = 0;
    float padding = 5;
    int numCols = 6;
    String[] spendingColNames = {"Rank", "Club Name", "Spent (£)", "Sold For (£)", "Net Spent (£)", "Per Season (£)"};
    
    for (int i = 0; i < spending.size (); i++)
    {
      for (int j = 0; j < numCols; j++)
      {
        
        text( spendingColNames[j], colDist * (j) + padding, border+rowDist);
        colDist = (float)widthRange / (numCols);
        //textAlign(RIGHT);
        stroke(255);
        fill(255);
        if (j == 0)
        {
          text( spending.get(i).rank, (colDist * (j)) + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        } else if (j != 1)
        {
          text( spending.get(i).getSpendField(i, j), (colDist * (j)) + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        } else if (j == 1)
        {
          text( spending.get(i).clubName, (colDist * (j)) + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        }
      }
      stroke(0);
      line(0, border + (rowDist * (i+1)), width, border + (rowDist*(i+1)));
      line(colDist * (i), border, colDist * (i), (float)height);
    }
  }//end showTable
  
  
}
