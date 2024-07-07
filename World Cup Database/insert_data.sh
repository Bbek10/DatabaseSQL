#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo Truncate teams and games table

# When you run your insert_data.sh script, it should add each
# unique team to the teams table. There should be 24 rows

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  #get team name form teams
  TEAMS=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
  if [[ $WINNER != "winner" ]]
  then
    #if team name is not found in table
    if [[ -z $TEAMS ]]
    then
      INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ INSERT_TEAM == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $Winner
      fi
    fi
  fi

  #get team name form teams
  TEAMS2=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
  if [[ $OPPONENT != "opponent" ]]
  then
    #if team name is not found in table
    if [[ -z $TEAMS2 ]]
    then
      INSERT_TEAM2=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ INSERT_TEAM2 == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi
    fi
  fi
# When you run your insert_data.sh script, it should insert a 
# row for each line in the games.csv file (other than the top line of the file). 
# There should be 32 rows. Each row should have every column filled in with
#  the appropriate info. Make sure to add the correct ID's from the teams table 
#  (you cannot hard-code the values)

TEAM_ID_W=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'");
TEAM_ID_O=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'");
# -n means signal is not null
if [[ -n $TEAM_ID_W || -n $TEAM_ID_O ]]
then
  if [[ $YEAR != "year" ]]
    then
      INSERT_GAMES=$($PSQL "INSERT into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $TEAM_ID_W, $TEAM_ID_O, $WINNER_GOALS, $OPPONENT_GOALS)")
      if [[ INSERT_GAMES == "INSERT 0 1" ]]
      then
            echo Inserted into teams, $YEAR
      fi
  fi
fi

done