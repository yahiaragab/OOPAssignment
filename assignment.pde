
import controlP5.*;
ControlP5 controlP5;

//Declaring globals
ArrayList<controlP5.Button> buttons = new ArrayList<controlP5.Button>();
DropdownList ddl;
PFont btnfont = createFont("Arial", 20, false); // use true/false for smooth/no-smooth
ControlFont btnFont = new ControlFont(btnfont, 241);
PFont headfont = createFont("Times", 15, false); // use true/false for smooth/no-smooth
ControlFont headFont = new ControlFont(headfont, 241);

ArrayList<AllTime> alltime = new ArrayList<AllTime>();
ArrayList<Last10YearsTable> pllast10yrs = new ArrayList<Last10YearsTable>();
ArrayList<Spending> spending = new ArrayList<Spending>();
ArrayList<Points> points = new ArrayList<Points>();
ArrayList<Goals> goals = new ArrayList<Goals>();
ArrayList<TopGS> scorer = new ArrayList<TopGS>();
ArrayList<MostGlsInGame> scorerGame = new ArrayList<MostGlsInGame>();
ArrayList<MostValuableXI> player = new ArrayList<MostValuableXI>();

//column names for pl tables
String[] allTimeColNames = {
  "P Total Matches Played", 
  "W Wins (Home)", "L Losses (Home)", "D Draws (Home)", "GF Goals For (Home)", "GA Goals For (Home)", 
  "W Wins (Away)", "L Losses (Away)", "D Draws (Away)", "GF Goals For (Away)", "GA Goals For (Away)", 
  "F Total Goals For", "A Total Goals Against", 
  "GD All Time Goal Difference", "Pts All Time Points"
};

//drawing variables
float border;
float widthRange;
float heightRange;

void setup() 
{
  size(1200, 700);
  border = 40;
  
  widthRange = (float)width - (border*2);
  heightRange = (float)height - (border*2);
  
  //load all data from files
  loadData();
  //display main menu
  mainMenu();
}

void loadData()
{
  String[] data = loadStrings("PLAllTime.csv");

  for (int i = 0; i < data.length; i++)
  {
    AllTime row = new AllTime(data[i]);
    alltime.add(row);
  }

  data = loadStrings("PLLast10Yrs.txt");

  for (int i = 0; i < data.length; i++)
  {
    Last10YearsTable row = new Last10YearsTable(data[i]);
    pllast10yrs.add(row);
  }

  data = loadStrings("SpendingLast10Yrs.txt");

  for (int i = 0; i < data.length; i++)
  {
    Spending row = new Spending(data[i]);
    spending.add(row);
  }

  data = loadStrings("PLAllTimeAvgPts.csv");

  for (int i = 0; i < data.length; i++)
  {
    Points row = new Points(data[i]);
    points.add(row);
  }

  data = loadStrings("PLAllTimeAvgGls.csv");

  for (int i = 0; i < data.length; i++)
  {
    Goals row = new Goals(data[i]);
    goals.add(row);
  }

  data = loadStrings("TopGS1.csv");

  for (int i = 0; i < data.length; i++)
  {
    TopGS row = new TopGS(data[i]);
    scorer.add(row);
  }

  data = loadStrings("MostGoalsInGame.csv");

  for (int i = 0; i < data.length; i++)
  {
    MostGlsInGame row = new MostGlsInGame(data[i]);
    scorerGame.add(row);
  }

  data = loadStrings("MostValuableXI.csv");

  for (int i = 0; i < data.length; i++)
  {
    MostValuableXI row = new MostValuableXI(data[i], i);
    player.add(row);
  }
}

//variables used to access classes
AllTime at = new AllTime();
TopGS tgs = new TopGS();
MostGlsInGame mgg = new MostGlsInGame();
MostValuableXI mvxi = new MostValuableXI();
Last10YearsTable ty = new Last10YearsTable();
Spending ts = new Spending();
Last10YearsTable cg = new Last10YearsTable();

PImage pic;

void draw() 
{
  //load background image
  pic = loadImage("EPL.jpg");
  image(pic, 0, 0, width, height);

  //hide button method deals with ControlP5 buttons shown
  hideButton();

  switch (mode)
  {
  case 101:
    {
      at.showTable();
      break;
    }
  case 102:
    {
      background(0);
      at.TeamBarChartDisplay(team);
      break;
    }
  case 103:
    {
      background(0);
      at.TeamAllGoals(team);
      break;
    }
  case 104:
    {
      background(0);
      at.TeamAllPoints(team);
      break;
    }
  case 105:
    {
      background(0);
      at.GoalGraph(team);
      break;
    }
  case 106:
    {
      background(0);
      at.PointGraph(team);
      break;
    }
  case 107:
    {
      tgs.showTopScorers();
      break;
    }
  case 108:
    {
      background(0);
      mgg.showMostGlsInGame();
      break;
    }
  case 109:
    {
      background(0);
      MostValuableXI mvxi = new MostValuableXI();
      mvxi.drawPitch();
      int[] formation = {
        1, 4, 2, 3, 1
      };
      for (int i = 0; i < formation.length; i++)
      {
        mvxi.drawXI(formation[i], formation.length, i);
      }
      break;
    }
  case 110:
    {
      ty.show10YrsTable();
      break;
    }
  case 111:
    {
      ts.showSpendTable();
      break;
    }
  case 112:
    {
      background(0);
      cg.showCorrelation();
      break;
    }
  default:
    {
      textAlign(LEFT);
      fill(255);
      stroke(255);
      textSize(15);
//      text("Stats correct up to the end of the 2014/2015 season.", ((float)widthRange * 0.15f), border/2);
    }
    break;
  }
}

//option chosen. starts at 100, because teams are 0-46. less error checking
int mode = 100; 
//team chosen in dropdown
int team; 
//number of buttons in mains menu
int mainBtns; 

//Control P5 menu code
void mainMenu()
{
  controlP5 = new ControlP5(this);

  //options on buttons in main menu
  String[] mainMsg = {
    "Return To Main Menu", "All Time BPL Table", "Your Team", 
    "All Teams: Goals", "All Teams: Points", "By Team: Goals", 
    "By Team: Points", "Top Goal Scorers", "Most Goals/Game", 
    "Most Valuable XI"
  }; 
  
  //add buttons to array list buttons
  int padding = 150;
  int w = (int)textWidth(mainMsg[0]);
  int h = 35;
  //return to main menu button. (value 100)
  buttons.add( controlP5.addButton(mainMsg[0], 100, 0, 0, w, h) );

  //other options
  for (int i = 1; i < mainMsg.length; i++)
  {
    w = (int)textWidth(mainMsg[i]) + padding;
    h = 30;
    int x = ( 3 * ( (int)widthRange / 4 ) ) - (w/2);
    int y = ( (int)heightRange / mainMsg.length) * i;
    buttons.add( controlP5.addButton(mainMsg[i], i + 100, x, y, w, h) );
    buttons.get(i).getCaptionLabel().setFont(btnfont);
  }

  //menu for money in PL
  String[] spentMsg = {
    "PL Table: Last 10 Years", "PL Spending: Last 10 Years", 
    "Teams: Cost Per Point"
  }; 

  //adding money buttons to array list
  for (int i = 0; i < spentMsg.length; i++)
  {
    w = (int)textWidth(spentMsg[i]) + padding;
    h = 30;
    int x = ( 1 * ( (int)widthRange / 4 ) ) - (w/2);
    int y = ( (int)heightRange / (spentMsg.length + 1) ) * (i + 1);
    buttons.add( controlP5.addButton(spentMsg[i], i + (100 + mainMsg.length), x, y, w, h) );
    buttons.get( i + (mainMsg.length) ).getCaptionLabel().setFont(btnfont);
    //    buttons.get(i).captionLabel().getStyle().marginTop = 36;
  }

  //dropdown menu ddl to choose teams
  int ddlX = (int)(width * 0.7);
  int ddlY = 0;
  int ddlW = 300;
  int ddlH = 120;

  //create and customise ddl
  ddl = controlP5.addDropdownList("Select Team", ddlX, ddlY, ddlW, ddlH);
  ddl.close();
  ddl.getCaptionLabel().getStyle().marginTop = 6;
  //  ddl.getCaptionLabel().getStyle().marginLeft = 60;

  customize(ddl);

  //number of buttons in main menu
  mainBtns = mainMsg.length + spentMsg.length;
}

void customize(DropdownList ddl)
{
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(30);
  ddl.setBarHeight(30);

  for (int i = 0; i < alltime.size (); i++)
  {
    ddl.addItem(alltime.get(i).clubName, i ); // give each item a value, in this example starting from zero
    ddl.getCaptionLabel().setFont(btnfont);
  }
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

//deals with values returned from buttons
void controlEvent(ControlEvent theEvent)
{
  if ((int)theEvent.getValue() > 99)
    mode = (int)theEvent.getValue();
  else
    team = (int)theEvent.getValue();
  println(theEvent.getValue());
}//control event

//hiding and showing buttons
void hideButton() 
{
  if (mode == 100) 
  {
    for (int i = 1; i < buttons.size (); i++)
    {
      if (i < mainBtns)
      {
        buttons.get(i).show();
      }//end if
      else
      {
        buttons.get(i).hide();
      }//end else
    }//end for
  }//end if
  else 
  {
    for (int i = 1; i < buttons.size (); i++)
    {
      if (i < mainBtns)
      {
        buttons.get(i).hide();
      }//end if
    }//end for
  }//end else
}//end hide button

//spacebar takes u to main menu
void keyPressed()
{
  if ( key == ' ' )
  {
    mode = 100;
  }
}

