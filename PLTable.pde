//field are the same in all PL tables, so this class is used
class PLTable
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
  
  PImage pict;

  PLTable()
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
    
    pict = null;
  }

  PLTable(String line)
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
    allGoalsFor = Integer.parseInt(data[13]);
    allGoalsAgainst = Integer.parseInt(data[14]);
    //REST
    goalDiff = Integer.parseInt(data[15]);
    Points = Integer.parseInt(data[16]);
    
    pict = loadImage(clubName + ".jpg");
  }

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
  
}//end class

