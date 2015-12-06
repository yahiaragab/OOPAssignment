class AllTime
{ 
  int rank;
  String clubName;
  int matchesPlayed;
  //home
  int home_Won;
  int home_Loss;
  int home_Drawn;
  int home_GoalsFor;
  int home_GoalsAgainst;
  //away
  int away_Won;
  int away_Loss;
  int away_Drawn;
  int away_GoalsFor;
  int away_GoalsAgainst;
  //total goals
  int allGoalsFor;
  int allGoalsAgainst;
  //Rest
  int goalDiff;
  int Points;

  AllTime()
  {
    rank = 0;
    clubName = "";
    matchesPlayed = 0;
    //HOME
    home_Won = 0;
    home_Drawn = 0;
    home_Loss = 0;
    home_GoalsFor = 0;
    home_GoalsAgainst = 0;
    //AWAY
    away_Won = 0;
    away_Drawn = 0;
    away_Loss = 0;
    away_GoalsFor = 0;
    away_GoalsAgainst = 0;
    //Total Goals
    allGoalsFor = 0;
    allGoalsAgainst = 0;
    //REST
    goalDiff = 0;
    Points = 0;
  }

  AllTime(String line)
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
    away_Won =  home_GoalsFor =Integer.parseInt(data[8]);
    away_Drawn = Integer.parseInt(data[9]);
    away_Loss = Integer.parseInt(data[10]);
    away_GoalsFor = Integer.parseInt(data[11]);
    away_GoalsAgainst = Integer.parseInt(data[12]);
    //Total Goals
    allGoalsFor = Integer.parseInt(data[13]);
    allGoalsAgainst = Integer.parseInt(data[14]);
    //REST
    goalDiff = Integer.parseInt(data[15]);
    Points = Integer.parseInt(data[16]);
  }



  void showTable()
  {
    background(0);

    float rowDist =  (heightRange + border)  / (float)alltime.size();
    float colDist = 0;
    float padding = 5;
    String[] cols ;
    String[] dataAllTime = loadStrings("PLAllTime.csv");

    for (int i = 0; i < dataAllTime.length; i++)
    {
      cols = dataAllTime[i].split(",");
      for (int j = 0; j < cols.length; j++)
      {
        colDist = (float)widthRange / cols.length;
        //textAlign(RIGHT);
        stroke(255);
        fill(255);
        text( cols[j], (colDist * j), ((rowDist * i) + rowDist ) + border);
      }
      stroke(255, 0, 0);
      line(colDist * i, border, colDist * i, (float)height);
    }
  }//end showTable

  void TeamBarChartDisplay(int team)
  {

    //make the barchart diplay value (alltime.get(team).value when mouse hovers
    //   over the column... (if mouseX = && mouseY = ) and put coordinates of column
    //display name ( text(coordinates) ) over or under columns

    //      drawAxis(rainFall, months, 15, 150, border);
    stroke(0, 255, 255);

    float lineWidth =  widthRange / (float) (alltime.size() - 1) ;
    String[] dataAllTime = loadStrings("PLAllTime.csv");
    String[] data;

    data = dataAllTime[team].split(",");

    float[] cols = new float[data.length];

    for (int i = 0; i < data.length; i++)
    {
      // Add each element from the string array to the arraylist
      if (i != 1)
      {
        float f = Float.parseFloat(data[i]);
        cols[i] = f;
      }
    }
    float max = cols[0];
    int maxIndex = 0;
    for (int i = 1; i < cols.length; i ++)
    {
      if (cols[i] > max)
      {
        max = cols[i];
        maxIndex = i;
      }
    }
    float barWidth = width/ (cols.length-2);
    float scale = heightRange / max;
    text(data[1], border, border*2);
    for (int i = 2; i < cols.length; i ++)
    {
      float x = (i-2) * barWidth;
      float y = cols[i] * scale;
      float c = map(y, 0, max * scale, 255, 100);
      stroke(0, c, c);
      fill(0, c, c);        
      rect(x, height, barWidth - 1, - y);
      fill(0);
      text(cols[i], barWidth * (i-2), height - border);
      // Or use the Processing map function!
      //rect(x, height, barWidth, - map(rainFall[i], 0, max, 0, height));
    }
  }

  void TeamAllGoals(int team)
  {
    //      drawAxis(rainFall, months, 15, 150, border);
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
    text("Blue is for, red is against", width - 400, 100);

    for (int i = 0; i < alltime.size (); i ++)
    {
      float x = ( i * (barWidth*2) ) + border;
      float y = alltime.get(i).allGoalsFor * scaleFor;
      println(y);
      float c = map(y, 0, maxfor * scaleFor, 255, 100);
      stroke(0);
      fill(0, c, c);        
      rect(x, height - border, barWidth, - y);
      fill(255);

      float x2 = ( ( (i) * (barWidth*2) ) + barWidth ) + border;
      float y2 = alltime.get(i).allGoalsAgainst * scaleAgainst;
      println(y);
      float c2 = map(y2, 0, maxagainst * scaleAgainst, 255, 100);
      stroke(0, 0, 0);
      fill(c2, 0, 0);        
      rect(x2, height - border, barWidth, - y2);
      fill(255);
    }//end for
  }//end team all goals


  void TeamAllPoints(int team) //WHEN MOUSEOVER, HIGHLIGHT (change stroke color and stroke weight)
    //  AND PRINT clubName ON SCREEN
  {
    //      drawAxis(rainFall, months, 15, 150, border);
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
    text("Blue is Points, red is Games Played", widthRange - 400, 200);

    for (int i = 0; i < alltime.size (); i ++)
    {
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
    }//end for
  }//end team all goals




  void GoalGraph(int team)  //HIDEOUS CODE AND NOT WORKING GREAT
  {
    background(0);
    float sum = alltime.get(team).allGoalsFor + alltime.get(team).allGoalsAgainst;

    int maxIndexFor = 0;
    float maxfor = 0;
    int maxIndexAgainst = 0;
    float maxagainst = 0;

    //      for (int i = 0; i < alltime.size (); i ++)
    //      {
    if (alltime.get(team).allGoalsFor > maxfor)
    {
      maxfor = alltime.get(team).allGoalsFor;
    }
    if (alltime.get(team).allGoalsAgainst > maxagainst)
    {
      maxagainst = alltime.get(team).allGoalsAgainst;
    }
    //      }

    float max = 0;
    if (maxfor > maxagainst)
    {
      max = maxfor;
    } else
    {
      max = maxagainst;
    }

    //ALL GOALS FOR AND AGAINST
    float thetaPrev = 0;

    thetaPrev = pieChart("Goals for: ", alltime.get(team).allGoalsAgainst, sum, max, thetaPrev);

    fill(127);
    stroke(255, 0, 0);

    thetaPrev = pieChart("Goals Against: ", alltime.get(team).allGoalsFor, sum, max, thetaPrev);
    thetaPrev = 0;
    
    float centX = width/2.0f;
    float centY = height/2.0f;
    
    float theta = map(alltime.get(team).allGoalsFor, 0, sum, 0, TWO_PI);
    textAlign(CENTER);
    float col = map(alltime.get(team).allGoalsFor, 0, max, 255, 100);
    float thetaNext = thetaPrev + theta;
    float radius = centX * 0.5f;
    float x = (centX * 0.4) + sin(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;
    float y = (centX * 0.4) - cos(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;
    stroke(0, col, col);
    fill(0, col, col);
    text("Goals For: " + alltime.get(team).allGoalsFor, x, y);             
    stroke(0, col, col);
    fill(0, col, col);          
    //arc ( centerpointx, ecenterpointy, width, height, where arc starts, where arc ends     
    arc(centX * 0.3, centY, radius, radius, thetaPrev, thetaNext);
    thetaPrev = thetaNext;

    //AGAINST
    fill(0, 0, 255);
    stroke(0, 0, 0);

    theta = map(alltime.get(team).allGoalsAgainst, 0, sum, 0, TWO_PI);
    textAlign(CENTER);
    col = map(alltime.get(team).allGoalsAgainst, 0, max, 255, 100);
    thetaNext = thetaPrev + theta;
    x = (centX * 0.2) + sin(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;      
    y = (centY * 1.2) - cos(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;

    stroke(0, col, col);
    fill(0, col, col); 
    text("Goals Against: " + alltime.get(team).allGoalsAgainst, x, y);             
    stroke(0, col, col);
    fill(0, col, col);          
    //arc ( centerpointx, ecenterpointy, width, height, where arc starts, where arc ends     
    arc(centX * 0.3, centY, radius, radius, thetaPrev, thetaNext);
    thetaPrev = thetaNext;

    //MATCHES PLAYED AND GOALS SCORED
    //WHEN MOUSE OVER THE GOALS/GAME RATIO GETS MULTIPLIED BY NO OF alltimeGoals.matchesplayed AND
    //  PRINTS HOW MANY GOALS WOULD HAVE BEEN SCORED IN THIS MANY MATCHES (LIKE LABTEST) mouseY 
    max = goals.get(team).total;  
    float barWidth = (float)width / 25 ;
    float scale = heightRange / max;

    text(goals.get(team).clubName, centX, centY * 0.2);
    //    for (int i = 2; i < cols.length; i ++)
    //    {
    float x1 = barWidth;
    float y1 = goals.get(team).matchesPlayed * scale;
    float c1 = map(y1, 0, max * scale, 255, 100);
    stroke(0, c1, c1);
    fill(0, c1, c1);  //CHANGE COLOR OF BARS      
    stroke(0);
    rect((float)width - (x1 * 5), height - border, barWidth, - y1 + (border*2));
    text(goals.get(team).matchesPlayed, (float)height - border, barWidth, (- y1 * scale) + border);
    //fill(0);
    //text(alltimeGoals.get(team).clubName, barWidth , height - border);

    //scale = windowRange / max;
    max = goals.get(team).total;

    float x2 = barWidth;
    float y2 = goals.get(team).total * scale;
    float c2 = map(y2, 0, max * scale, 255, 100);
    stroke(0, c1, c1);
    fill(0, c1, c1);  
    stroke(0);      
    rect((float)width - (x2 * 4), height - border, barWidth, (- y2) + border*2);
    text(goals.get(team).total, height - border, barWidth + border, (- y2 * scale) - border);
    fill(255);
    text(goals.get(team).total, (float)height -  (x2), height - border/2);
    // Or use the Processing map function!
    //rect(x, height, barWidth, - map(rainFall[i], 0, max, 0, height));
  }//end goal graph

  void PointGraph(int team)  //HIDEOUS CODE AND NOT WORKING GREAT
  {
    println(team);
    background(0);
    float sum = alltime.get(team).Points + alltime.get(team).matchesPlayed;

    int maxIndexFor = 0;
    float maxfor = 0;
    int maxIndexAgainst = 0;
    float maxagainst = 0;

    //      for (int i = 0; i < alltime.size (); i ++)
    //      {
    if (alltime.get(team).Points > maxfor)
    {
      maxfor = alltime.get(team).Points;
    }
    if (alltime.get(team).matchesPlayed > maxagainst)
    {
      maxagainst = alltime.get(team).matchesPlayed;
    }
    //      }

    float max = 0;
    if (maxfor > maxagainst)
    {
      max = maxfor;
    } else
    {
      max = maxagainst;
    }

    //ALL GOALS FOR AND AGAINST
    float thetaPrev = 0;

    thetaPrev = pieChart("Points: ", alltime.get(team).Points, sum, max, thetaPrev);

    fill(127);
    stroke(255, 0, 0);

    thetaPrev = pieChart("Matches Played: ", alltime.get(team).Points, sum, max, thetaPrev);
    thetaPrev = 0;
    
    float centX = width/2.0f;
    float centY = height/2.0f;
    
    float theta = map(alltime.get(team).Points, 0, sum, 0, TWO_PI);
    textAlign(CENTER);
    float col = map(alltime.get(team).Points, 0, max, 255, 100);
    float thetaNext = thetaPrev + theta;
    float radius = centX * 0.5f;
    float x = (centX * 0.4) + sin(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;
    float y = (centX * 0.4) - cos(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;
    stroke(0, col, col);
    fill(0, col, col);
    text("Points: " + alltime.get(team).Points, x, y);             
    stroke(0, col, col);
    fill(0, col, col);          
    //arc ( centerpointx, ecenterpointy, width, height, where arc starts, where arc ends     
    arc(centX * 0.3, centY, radius, radius, thetaPrev, thetaNext);
    thetaPrev = thetaNext;

    //AGAINST
    fill(0, 0, 255);
    stroke(0, 0, 0);

    theta = map(alltime.get(team).matchesPlayed, 0, sum, 0, TWO_PI);
    textAlign(CENTER);
    col = map(alltime.get(team).matchesPlayed, 0, max, 255, 100);
    thetaNext = thetaPrev + theta;
    x = (centX * 0.2) + sin(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;      
    y = (centY * 1.2) - cos(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;

    stroke(0, col, col);
    fill(0, col, col); 
    text("matchesPlayed: " + alltime.get(team).matchesPlayed, x, y);             
    stroke(0, col, col);
    fill(0, col, col);          
    //arc ( centerpointx, ecenterpointy, width, height, where arc starts, where arc ends     
    arc(centX * 0.3, centY, radius, radius, thetaPrev, thetaNext);
    thetaPrev = thetaNext;

    //MATCHES PLAYED AND GOALS SCORED
    //WHEN MOUSE OVER THE GOALS/GAME RATIO GETS MULTIPLIED BY NO OF alltimeGoals.matchesplayed AND
    //  PRINTS HOW MANY GOALS WOULD HAVE BEEN SCORED IN THIS MANY MATCHES (LIKE LABTEST) mouseY 
    max = points.get(team).total;  
    float barWidth = (float)width / 25 ;
    float scale = heightRange / max;

    text(points.get(team).clubName, centX, centY * 0.2);
    //    for (int i = 2; i < cols.length; i ++)
    //    {
    float x1 = barWidth;
    float y1 = points.get(team).matchesPlayed * scale;
    float c1 = map(y1, 0, max * scale, 255, 100);
    stroke(0, c1, c1);
    fill(0, c1, c1);  //CHANGE COLOR OF BARS      
    stroke(0);
    rect((float)width - (x1 * 5), height - border, barWidth, - y1 + (border*2));
    text(points.get(team).matchesPlayed, (float)height - border, barWidth, (- y1 * scale) + border);
    //fill(0);
    //text(alltimeGoals.get(team).clubName, barWidth , height - border);

    //scale = windowRange / max;
    max = points.get(team).total;

    float x2 = barWidth;
    float y2 = points.get(team).total * scale;
    float c2 = map(y2, 0, max * scale, 255, 100);
    stroke(0, c1, c1);
    fill(0, c1, c1);  
    stroke(0);      
    rect((float)width - (x2 * 4), height - border, barWidth, (- y2) + border*2);
    text(points.get(team).total, height - border, barWidth + border, (- y2 * scale) - border);
    fill(255);
    text(points.get(team).total, (float)height -  (x2), height - border/2);
    // Or use the Processing map function!
    //rect(x, height, barWidth, - map(rainFall[i], 0, max, 0, height));
  }//end goal graph
  
  
  float pieChart(String message, int data, float sum, float max, float thetaPrev )
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
    stroke(0, col, col);
    fill(0, col, col);
    textSize(20);
    text(message + data, x, y);             
    stroke(0, col, col);
    fill(0, col, col);          
    //arc ( centerpointx, ecenterpointy, width, height, where arc starts, where arc ends     
    arc(centX * 0.3, centY, radius, radius, thetaPrev, thetaNext);
    thetaPrev = thetaNext;
    return thetaPrev;
  }//end piechart
}//end class

