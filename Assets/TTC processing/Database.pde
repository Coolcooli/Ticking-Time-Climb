//Made by Lars Nienhuis 500882270 && Kevin Kroon 500855487 && Robin Schellingerhout
class Database {
  PVector playerPosition = new PVector(0, 0);
  String deathMarkerQuery = "SELECT playery, Player_name, score FROM DeathEvent";
  Table deathMarkerTable;
  String getHighscores = "SELECT Player_name, score FROM DeathEvent ORDER BY score DESC LIMIT 10"; 
  Table highscore;
  Table deathEvent;

  void init() {
    databaseInfo.setProperty("user", "nienhul"); //Set the username and password for the database
    databaseInfo.setProperty("password", "17xHkSY#YSaNyf3H");
    try {
      myConnection = new MySQLConnection("jdbc:mysql://oege.ie.hva.nl/znienhul?serverTimezone=UTC", databaseInfo); //Try to make a connection with the Oege server
    } 
    catch (Exception e) {
      dataBaseError = true; //If it can't connect this boolean becomes true
    }
    if (!dataBaseError) {
      deathEvent = myConnection.getTable("DeathEvent"); //Set the table DeathEvent to the table in the database "DeathEvent"
    }
  }

  void addMetrics(String metric, int amount) { // add metrics to database
    if (amount <= 0)
      return;
    myConnection.updateQuery("INSERT INTO Metrics (Player_name, idMetrics, amount) VALUES(\"" + name + "\",\"" + metric + "\"," + amount +");");
  }

  //void achievements(SQLConnection connection, String metric) {

  //}

  void addUser() { // add user
    //SELECT CASE WHEN EXISTS(SELECT name FROM Player WHERE name = \""+ name +"\") THEN 0 ELSE 1 END AS IsEmpty
    Table table = myConnection.runQuery("SELECT name FROM Player WHERE name = \""+ name +"\"");
    if (!boolean(table.getRowCount())) {
      myConnection.updateQuery("INSERT INTO Player (name) VALUES(\""+ name +"\");");
    }
  }

  Table getMetric(String metric) { // get table of metrics
    return myConnection.runQuery("SELECT Player_name,SUM(amount) FROM Metrics WHERE idMetrics = \"" + metric + "\" group by Player_name;");
  }

  void enterScore() {
    myConnection.updateQuery("INSERT INTO DeathEvent (Player_name, score, playerx, playery) VALUES(\"" + name +"\", "+ int(scoreCount) + ","+ playerPosition.x +","+ playerPosition.y +");");    

    String joinQuery = "SELECT * FROM DeathEvent INNER JOIN Player On DeathEvent.Player_timestamp = Player.timestamp WHERE DeathEvent.Player_name = name;";
    myConnection.runQuery(joinQuery);
  }
}
