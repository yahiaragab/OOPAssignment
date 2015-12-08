//different format to the alltime table so i had to make a new class. All goals for and against are
//    calculated in the constructor rather than brought in from te file
class Last10YearsTable extends PLTable
{

  Last10YearsTable()
  {
    super();
  }

  Last10YearsTable(String line)
  {
    String[] data = line.split(",");

    rank = Integer.parseInt(data[0]);
    clubName = data[1];
    matchesPlayed = Integer.parseInt(data[2]);
    //HOME
    home_Won = Integer.parseInt(data[3]);
    home_Drawn = Integer.parseInt(data[4]);
    home_Loss = Integer.parseInt(data[5]);
    home_GoalsFor =Integer.parseInt(data[6]);
    home_GoalsAgainst =Integer.parseInt(data[7]);
    //AWAY
    away_Won = Integer.parseInt(data[8]);
    away_Drawn = Integer.parseInt(data[9]);
    away_Loss = Integer.parseInt(data[10]);
    away_GoalsFor = Integer.parseInt(data[11]);
    away_GoalsAgainst = Integer.parseInt(data[12]);
    //Total Goals
    allGoalsFor = away_GoalsFor + home_GoalsFor;
    allGoalsAgainst = away_GoalsAgainst + home_GoalsAgainst;
    //REST
    goalDiff = Integer.parseInt(data[13]);
    Points = Integer.parseInt(data[14]);
    pict = loadImage(clubName + ".jpg");
  }

  int getField(int team, int i)
  {
    switch (i)
    {
    case 0:
      {
        return pllast10yrs.get(team).rank;
      }
    case 2:
      {
        return pllast10yrs.get(team).matchesPlayed;
      }
    case 3:
      {
        return pllast10yrs.get(team).home_Won;
      }
    case 4:
      {
        return pllast10yrs.get(team).home_Loss;
      }
    case 5:
      {
        return pllast10yrs.get(team).home_Drawn;
      }
    case 6:
      {
        return pllast10yrs.get(team).home_GoalsFor;
      }
    case 7:
      {
        return pllast10yrs.get(team).home_GoalsAgainst;
      }
    case 8:
      {
        return pllast10yrs.get(team).away_Won;
      }
    case 9:
      {
        return pllast10yrs.get(team).away_Loss;
      }
    case 10:
      {
        return pllast10yrs.get(team).away_Drawn;
      }
    case 11:
      {
        return pllast10yrs.get(team).away_GoalsFor;
      }
    case 12:
      {
        return pllast10yrs.get(team).away_GoalsAgainst;
      }
    case 13:
      {
        return pllast10yrs.get(team).allGoalsFor;
      }
    case 14:
      {
        return pllast10yrs.get(team).allGoalsAgainst;
      }
    case 15:
      {
        return pllast10yrs.get(team).goalDiff;
      }
    case 16:
      {
        return pllast10yrs.get(team).Points;
      }

    default:
      {
        return -1;
      }
    }
  }//end get field
  
  //show table
  void show10YrsTable()
  {
    background(100, 149, 237);
    text(pllast10yrs.size() + " Teams", border * 4, 20);
    float rowDist =  (heightRange + border)  / ((float)pllast10yrs.size()+1);
    float colDist = 0;
    float padding = 5;
    int numCols = 17;

    for (int i = 0; i < pllast10yrs.size (); i++)
    {
      for (int j = 0; j < numCols; j++)
      {
        if ( j > 1)
        {
          text( allTimeColNames[j-2].substring( 0, allTimeColNames[j-2].indexOf(' ') ), colDist * (j+2) + padding, border+rowDist);
        }
        colDist = (float)widthRange / (numCols+2);
        //textAlign(RIGHT);
        stroke(255);
        fill(255);
        if (j == 0)
        {
          text( pllast10yrs.get(i).rank, (colDist * (j)) + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        } else if (j != 1)
        {
          text( pllast10yrs.get(i).getField(i, j), (colDist * (j+2)) + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        } else if (j == 1)
        {
          text( pllast10yrs.get(i).clubName, (colDist * (j)) + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        }
      }
      stroke(0);
      line(0, border + (rowDist * (i+1)), width, border + (rowDist*(i+1)));
      if ( i <= 1 || i > 3 )
        line(colDist * (i), border, colDist * (i), (float)height);
    }
  }//end showTable

  //how much teams have spent vs how well they've done
  void showCorrelation()
  {
    int sumPts = 0;
    for (int i=0; i<pllast10yrs.size (); i++)
    {
      sumPts += pllast10yrs.get(i).Points ;
    }

    int sumSpent = 0;
    for (int i=0; i < spending.size (); i++)
    {
      sumSpent += spending.get(i).spent ;
    }
    float avg = sumSpent / sumPts;

    text("The cost per point in the PL in the last 10 years is: " + avg + " (171 Thousand)", border*5, border);

    float distX = widthRange / spending.size();
    float distY = heightRange / spending.size();

    //maximum is first place (get(0))

    float max = spending.get(0).spent;
    float min = pllast10yrs.get(pllast10yrs.size() - 1).Points;

    for (int i = 1; i < spending.size (); i++)
    {
      if ( spending.get(i).spent > max )
      {
        max = spending.get(i).spent;
      }
    }

    text(max, widthRange - border*2, heightRange+border*2);
    text(pllast10yrs.get(0).Points, border/2 - 10, border*2);
    float windowHorRange = max - min;

    float scaleY = heightRange / max;

    float scaleX = (border + windowHorRange) / pllast10yrs.get(0).Points;

    line(border, border, border, heightRange + border);
    line(border, heightRange + border, widthRange + border, heightRange+border);
    text("SPENDING >", border + 15, heightRange + border*2);
    text(" ^\nPTS", (border /2) - 10, widthRange/4);
    float x = 0;
    float y = 0;
    float imgSize = 30;
    for (int i = 0; i < pllast10yrs.size (); i++)
    {
      for (int j = 0; j < spending.size (); j++)
      {

        if ( pllast10yrs.get(i).clubName.equals(spending.get(j).clubName) )
        {
          x = ( ( pllast10yrs.get(j).Points ) ) ;
          y = (border + heightRange) - ( spending.get(j).spent * scaleY ) ;
          stroke(255, 0, 0);
          fill(255);
          image(pllast10yrs.get(i).pict, x, y, imgSize, imgSize);
          text(pllast10yrs.get(i).Points, x, y );
          break;
        }//end if
      }//end for
    }//end outter for
  }
}//end class

