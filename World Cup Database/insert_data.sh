#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    # get team_id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'");

    #if not found
    if [[ -z $WINNER ]]
    then
      #insert winner
      $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')");
    fi

    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'");

    #if not found
    if [[ -z $OPPONENT ]]
    then
      #insert OPPONENT
       $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')");
    fi
  fi 
done