//class for all time PL table
class AllTime extends PLTable
{ 
  AllTime()
  {
    super();
  }

  AllTime(String line)
  {
    super(line);
  }

  //getField is used to avoid hardcoding (arraylist.get(i).field) for every field
  int getField(int team, int i)
  {
    switch (i)
    {
    case 0:
      {
        return alltime.get(team).rank;
      }
    case 2:
      {
        return alltime.get(team).matchesPlayed;
      }
    case 3:
      {
        return alltime.get(team).home_Won;
      }
    case 4:
      {
        return alltime.get(team).home_Loss;
      }
    case 5:
      {
        return alltime.get(team).home_Drawn;
      }
    case 6:
      {
        return alltime.get(team).home_GoalsFor;
      }
    case 7:
      {
        return alltime.get(team).home_GoalsAgainst;
      }
    case 8:
      {
        return alltime.get(team).away_Won;
      }
    case 9:
      {
        return alltime.get(team).away_Loss;
      }
    case 10:
      {
        return alltime.get(team).away_Drawn;
      }
    case 11:
      {
        return alltime.get(team).away_GoalsFor;
      }
    case 12:
      {
        return alltime.get(team).away_GoalsAgainst;
      }
    case 13:
      {
        return alltime.get(team).allGoalsFor;
      }
    case 14:
      {
        return alltime.get(team).allGoalsAgainst;
      }
    case 15:
      {
        return alltime.get(team).goalDiff;
      }
    case 16:
      {
        return alltime.get(team).Points;
      }
    default:
      {
        return -1;
      }
    }
  }//end get field

  //show all time table
  void showTable()
  {
    background(100,149,237);
    text(alltime.size() + " Teams", border * 4, 20);
    float rowDist =  (heightRange + border)  / ((float)alltime.size()+1);
    float colDist = 0;
    float padding = 5;
    int numCols = 17;

    for (int i = 0; i < alltime.size (); i++)
    {
      for (int j = 0; j < numCols; j++)
      {
        //dont write column headers for first 2 columns
        if( j > 1)
        {
          text( allTimeColNames[j-2].substring( 0, allTimeColNames[j-2].indexOf(' ') ),   colDist * (j+2) + padding, border+rowDist);
        }
        colDist = (float)widthRange / (numCols+1);
        //textAlign(RIGHT);
        stroke(255);
        fill(255);
      
        if (j == 0) // first column
        {
          text( alltime.get(i).rank, (colDist * (j)) + padding, ((rowDist * i) + rowDist ) + (border+border/3));
          
        }
        else if (j != 1) // all other columns
        {
          text( alltime.get(i).getField(i, j), (colDist * (j+2)) + padding, ((rowDist * i) + rowDist ) + (border+border/3));
        } else if (j == 1) // 2nd column
        {
          text( alltime.get(i).clubName, (colDist * (j)) + padding, ((rowDist * i) + rowDist ) + (border+border/3));
          
        }//end if elses
        
      }//end nested for
      
      //draw lines of table
      stroke(0);
      line(0, border + (rowDist * (i+1)), width, border + (rowDist*(i+1)));
      if ( i <= 1 || i > 3)
        line(colDist * (i), border, colDist * (i), (float)height);
    }
  }//end showTable

  //barchart of all individual team's details
  void TeamBarChartDisplay(int team)
  {
    stroke(0, 255, 255);
    //get max for scale
    float lineWidth =  10;
    int numCols = 17;
    float max = alltime.get(team).rank;
    int maxIndex = 0;
    for (int i = 1; i < numCols; i ++)
    {
      if (alltime.get(team).getField(team, i) > max)
      {
        max = alltime.get(team).getField(team, i);
        maxIndex = i;
      }
    }
    float barWidth = (widthRange - lineWidth) / ((float)numCols-2);
    float scale = (heightRange-border) / max;
  
    //legend
    color P = color(100);
    color home = color(0, 255, 0);
    color away = color(0, 0, 127);
    color goals = color(255, 100, 0);
    color rest =  color(100, 100, 100);

    stroke(P);
    fill(P);
    rect(border*4, 5, 10, 10);
    fill(255);
    text("Played", (border*4) +10, 20);

    stroke(home);
    fill(home);
    rect(border*7, 5, 10, 10);
    fill(255);
    text("Home", border*7 +10, 20);

    stroke(away);
    fill(away);
    rect(border*10, 5, 10, 10);
    fill(255);
    text("Away", border*10 +10, 20);

    stroke(goals);
    fill(goals);
    rect(border*13, 5, 10, 10);
    fill(255);
    text("Goals", border*13 +10, 20);

    stroke(rest);
    fill(rest);
    rect(border*16, 5, 10, 10);
    fill(255);
    text("GD and Pts.", border*16 +10, 20);
    
    //drawing bars
    for (int i = 2; i < numCols; i ++)
    {
      float x = ((i-2) * barWidth) + (border);
      float y = (alltime.get(team).getField(team, i) * scale);
      float c = map(y, 0, max * scale, 255, 100);
      stroke(150);
      strokeWeight(2);

      //coloring bars
      fill(P); 
      if (i > 2 && i < 8)
        fill(home);  
      else if (i > 7 && i <= 12)
        fill(away);
      else if (i > 12 && i <= 14)
        fill(goals);
      else if (i > 14 && i <= 16)
        fill(rest);
      
      //drawing bars and their values
      rect(x+lineWidth, (heightRange - lineWidth) + border, barWidth-lineWidth, - y);
      textSize(25);
      fill(255);
      text(alltime.get(team).getField(team, i), (barWidth * (i-2)) + border + lineWidth, (heightRange - y) + 10);
      text( allTimeColNames[i-2].substring( 0, allTimeColNames[i-2].indexOf(' ') ), ( ( (i-2) * barWidth ) + barWidth ), height - 10 );
    }
    
    //draw club logo
    int imgSide = 150;
    image(alltime.get(team).pict, border*4, border, imgSide, imgSide);
    
    //draw axes
    stroke(255);
    strokeWeight(lineWidth);
    fill(255);
    line(border, border, border, heightRange + border);
    line(border, heightRange + border, widthRange + border, heightRange+border);
    strokeWeight(1);
  }
  
  //All PL teams goals in graph
  void TeamAllGoals(int team)
  {
    //get all goals sum and display it
    float sum = 0;
    for(int i = 0; i < alltime.size(); i ++)
    {
      sum += alltime.get(i).allGoalsFor;
    }
    textSize(20);
    text(sum + " goals have been scored in the Premier League.", widthRange *0.5f, border*3);
    textSize(12);
    
    //scale
    stroke(0, 255, 255);
    float lineWidth =  widthRange / (float) (alltime.size() - 1) ;

    int maxIndexFor = 0;
    float maxfor = 0;
    int maxIndexAgainst = 0;
    float maxagainst = 0;

    for (int i = 0; i < alltime.size (); i ++)
    {
      if (alltime.get(i).allGoalsFor > maxfor)
      {
        maxfor = alltime.get(i).allGoalsFor;
        maxIndexFor = i;
      }
      if (alltime.get(i).allGoalsAgainst > maxagainst)
      {
        maxagainst = alltime.get(i).allGoalsAgainst;
        maxIndexAgainst = i;
      }
    }

    float barWidth = widthRange / ( alltime.size() * 2 );
    float max = 0;
    if (maxfor > maxagainst)
    {
      max = maxfor;
    } else
    {
      max = maxagainst;
    }

    float scaleFor = (heightRange) / maxfor;
    float scaleAgainst = (heightRange- border) / maxagainst;
    
    //color for legend
    color G = color(0, 255, 0);
    color A = color(255, 0, 0);
    //legend
    stroke(G);
    fill(G);
    rect(border*4, 5, 10, 10);
    fill(255);
    text("Goals For", (border*4) +10, 20);

    stroke(A);
    fill(A);
    rect(border*7, 5, 10, 10);
    fill(255);
    text("Goals Against", border*7 +10, 20);

    //display bars for and against
    for (int i = 0; i < alltime.size (); i ++)
    {
      //text on Y axis
      fill(255);
      float distY = (heightRange+border) / 47;
      text(alltime.get( (alltime.size () -1 ) - i).allGoalsFor, 0, (heightRange+border) - (distY * i));
      
      //first bar
      float x = ( i * (barWidth*2) ) + border;
      float y = alltime.get(i).allGoalsFor * scaleFor;
      println(y);
      float c = map(y, 0, maxfor * scaleFor, 255, 100);
      stroke(0);
      fill(0, c, c);        
      rect(x, height - border, barWidth, - y);
      fill(255);
 
      //second bar
      float x2 = ( ( (i) * (barWidth*2) ) + barWidth ) + border;
      float y2 = alltime.get(i).allGoalsAgainst * scaleAgainst;
      println(y);
      float c2 = map(y2, 0, maxagainst * scaleAgainst, 255, 100);
      stroke(0, 0, 0);
      fill(c2, 0, 0);        
      rect(x2, height - border, barWidth, - y2);
      fill(255);
      //club logo corresponding to bars
      image(alltime.get(i).pict, ((barWidth*2) * i) + border, height - border, barWidth*2, barWidth*2);

    }//end for
  }//end team all goals

  //exactly like all goals but for points
  void TeamAllPoints(int team)
  {
    float sum = 0;
    for(int i = 0; i < alltime.size(); i ++)
    {
      sum += alltime.get(i).Points;
    }
    textSize(20);
    text(sum + " points have been scored in the Premier League.", widthRange *0.5f, border*3);
    textSize(12);
    
    stroke(0, 255, 255);
    float lineWidth =  widthRange / (float) (alltime.size() - 1) ;

    int maxIndexFor = 0;
    float maxfor = 0;
    int maxIndexAgainst = 0;
    float maxagainst = 0;

    for (int i = 0; i < alltime.size (); i ++)
    {
      if (alltime.get(i).Points > maxfor) //CHANGE THESE TO goals AND points
      {
        maxfor = alltime.get(i).Points;
        maxIndexFor = i;
      }
      if (alltime.get(i).matchesPlayed > maxagainst)
      {
        maxagainst = alltime.get(i).matchesPlayed;
        maxIndexAgainst = i;
      }

    }

    float barWidth = widthRange / ( alltime.size() * 2 );
    float max = 0;
    if (maxfor > maxagainst)
    {
      max = maxfor;
    } else
    {
      max = maxagainst;
    }

    float scaleFor = (heightRange) / maxfor;
    float scaleAgainst = (heightRange- border) / maxagainst;

    color P = color(0, 255, 0);
    color M = color(255, 0, 0);

    stroke(P);
    fill(P);
    rect(border*4, 5, 10, 10);
    fill(255);
    text("Points", (border*4) +10, 20);

    stroke(M);
    fill(M);
    rect(border*7, 5, 10, 10);
    fill(255);
    text("Matches Played", border*7 +10, 20);

    for (int i = 0; i < alltime.size (); i ++)
    {
      fill(255);
      float distY = (heightRange+border) / 47;
      text(alltime.get( (alltime.size () -1 ) - i).Points, 0, (heightRange+border) - (distY * i));
      float x = ( i * (barWidth*2) ) + border;
      float y = alltime.get(i).Points * scaleFor;
      println(y);
      float c = map(y, 0, maxfor * scaleFor, 255, 100);
      stroke(0);
      fill(0, c, c);        
      rect(x, height - border, barWidth, - y);
      fill(255);

      float x2 = ( ( (i) * (barWidth*2) ) + barWidth ) + border;
      float y2 = alltime.get(i).matchesPlayed * scaleAgainst;
      println(y);
      float c2 = map(y2, 0, maxagainst * scaleAgainst, 255, 100);
      stroke(0, 0, 0);
      fill(c2, 0, 0);        
      rect(x2, heightRange + border, barWidth, - y2);
      fill(255);
      image(alltime.get(i).pict, ((barWidth*2) * i) + border, height - border, barWidth*2, barWidth*2);

    }//end for
  }//end team all goals

  //detailed graphs for goals scored by team in pie chart and bargraph
  void GoalGraph(int team)  //HIDEOUS CODE AND NOT WORKING GREAT
  {
    background(0);
    float sum = alltime.get(team).allGoalsFor + alltime.get(team).allGoalsAgainst;
    //scale
    int maxIndexFor = 0;
    float maxfor = 0;
    int maxIndexAgainst = 0;
    float maxagainst = 0;

    if (alltime.get(team).allGoalsFor > maxfor)
    {
      maxfor = alltime.get(team).allGoalsFor;
    }
    if (alltime.get(team).allGoalsAgainst > maxagainst)
    {
      maxagainst = alltime.get(team).allGoalsAgainst;
    }

    float max = 0;
    if (maxfor > maxagainst)
    {
      max = maxfor;
    } else
    {
      max = maxagainst;
    }

    //ALL GOALS FOR
    float thetaPrev = 0;

    thetaPrev = pieChart("Goals for: ", alltime.get(team).allGoalsAgainst, sum, max, thetaPrev, 1);

    fill(127);
    stroke(255, 0, 0);

    //all goals against
    thetaPrev = pieChart("Goals Against: ", alltime.get(team).allGoalsFor, sum, max, thetaPrev, 2);
    thetaPrev = 0;

    // DRAW BARS
    
    //bar 1
    float centX = width/2.0f;
    float centY = height/2.0f;

    max = goals.get(team).total;  
    float barWidth = (float)width / 25 ;
    float scale = heightRange / max;

    image(alltime.get(team).pict, centX, centY, 200, 200);
    float x1 = barWidth;
    float y1 = goals.get(team).matchesPlayed * scale;
    float c1 = map(y1, 0, max * scale, 255, 100);
    stroke(0, c1, c1);
    fill(0, c1, c1);     
    stroke(0);
    rect((float)width - (x1 * 5), height - border, barWidth, - y1 + (border*2));
    text("Matches Played: " + goals.get(team).matchesPlayed, (float)height - border, barWidth, (- y1 * scale) + border);

    //bar 2
    max = goals.get(team).total;

    float x2 = barWidth;
    float y2 = goals.get(team).total * scale;
    float c2 = map(y2, 0, max * scale, 255, 100);
    stroke(0, c1, c1);
    fill(0, c2, c2);  
    stroke(0);      
    rect((float)width - (x2 * 4), height - border, barWidth, (- y2) + border*2);
    text("Total goals scored: " + goals.get(team).total, height - border, barWidth + border, (- y2 * scale) - border);
    fill(255);

    float avg = (float)goals.get(team).total / (float)goals.get(team).matchesPlayed;
    text("Goals Per Match: " + avg, height - border, barWidth + border*2);

  }//end goal graph

  //just like goal graph but for points
  void PointGraph(int team)  //HIDEOUS CODE AND NOT WORKING GREAT
  {
    println(team);
    background(0);
    float sum = alltime.get(team).Points + alltime.get(team).matchesPlayed;

    int maxIndexFor = 0;
    float maxfor = 0;
    int maxIndexAgainst = 0;
    float maxagainst = 0;

    if (alltime.get(team).Points > maxfor)
    {
      maxfor = alltime.get(team).Points;
    }
    if (alltime.get(team).matchesPlayed > maxagainst)
    {
      maxagainst = alltime.get(team).matchesPlayed;
    }

    float max = 0;
    if (maxfor > maxagainst)
    {
      max = maxfor;
    } else
    {
      max = maxagainst;
    }

    //ALL POINTS FOR AND AGAINST
    float thetaPrev = 0;

    thetaPrev = pieChart("Points: ", alltime.get(team).Points, sum, max, thetaPrev, 1);

    fill(127);
    stroke(255, 0, 0);

    thetaPrev = pieChart("Matches Played: ", alltime.get(team).matchesPlayed, sum, max, thetaPrev, 2);
    thetaPrev = 0;

    float centX = width/2.0f;
    float centY = height/2.0f;

    max = points.get(team).total;  
    float barWidth = (float)width / 25 ;
    float scale = heightRange / max;

    image(alltime.get(team).pict, centX, centY, 200, 200);

    float x1 = barWidth;
    float y1 = points.get(team).matchesPlayed * scale;
    float c1 = map(y1, 0, max * scale, 255, 100);
    stroke(0, c1, c1);
    fill(0, c1, c1); 
    stroke(0);
    rect((float)width - (x1 * 5), height - border, barWidth, - y1 + (border*2));
    text("Matches Played: " + points.get(team).matchesPlayed, (float)height - border, barWidth, (- y1 * scale) + border);

    max = points.get(team).total;

    float x2 = barWidth;
    float y2 = points.get(team).total * scale;
    float c2 = map(y2, 0, max * scale, 255, 100);
    stroke(0, c2, c2);
    fill(0, c2, c2);  
    stroke(0);      
    rect((float)width - (x2 * 4), height - border, barWidth, (- y2) + border*2);
    text("Total Points: " + points.get(team).total, height - border, barWidth + border, (- y2 * scale) - border);
    fill(255);
    
    float avg = (float)points.get(team).total / (float)points.get(team).matchesPlayed;
    text("Points Per Match: " + avg, height - border, barWidth + border*2);

  }

  //DRAW PIECHART AND RETURN THETAPREV
  float pieChart(String message, int data, float sum, float max, float thetaPrev, int text)
  {
    float centX = (float)width / 2.0f;
    float centY = (float)height / 2.0f;
    float theta = map(data, 0, sum, 0, TWO_PI);
    textAlign(CENTER);
    float col = map(data, 0, max, 255, 100);
    float thetaNext = thetaPrev + theta;
    float radius = centX * 0.5f;
    float x = (centX *0.5) + sin(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;
    float y = (centY *0.5) - cos(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;
    stroke(col, col, 0);
    fill(col, col, 0);
    textSize(20);
    text(message + data, border*3, border + (border* text));             
    stroke(col, col, 0);
    fill(col, col, 0);
    arc(centX * 0.3, centY, radius, radius, thetaPrev, thetaNext);
    thetaPrev = thetaNext;
    return thetaPrev;
  }//end piechart
  
}//end class

