//Avg table for goals and graphs parent class
class AvgTable
{
  int rank;
  String clubName;
  int matchesPlayed;
  int total;
  float perGame;
  
  AvgTable(String line)
  {
    String data[] = line.split(",");

    rank = Integer.parseInt(data[0]);
    clubName = data[1];
    matchesPlayed = Integer.parseInt(data[2]);
    total = Integer.parseInt(data[3]);
    perGame = Float.parseFloat(data[4]);
  }
  
  
}
