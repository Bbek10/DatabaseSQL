#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=number_guess --no-align --tuples-only -c"
SECRET_NUMBER=$((RANDOM % 1000 + 1))
echo $SECRET_NUMBER
echo "Enter your username:"
read USERNAME

#check if username exists in the db
HAVE_USERNAME=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME'")

#if no username in db
if [[ -z $HAVE_USERNAME ]]
then
  INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
#if the user is already into our db
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM users INNER JOIN games USING(user_id) WHERE username='$USERNAME'")
  BEST_GAME=$($PSQL "SELECT MIN(guesses) FROM users INNER JOIN games USING(user_id) WHERE username='$USERNAME'")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses., with $USERNAME"
fi

echo "Guess the secret number between 1 and 1000:"
GUESS=1
while read NUM
do
  if [[ ! $NUM =~ ^[0-9]+$ ]]
    then
      echo "That is not an integer, guess again:"
  else
    if [[ $NUM -eq $SECRET_NUMBER ]]
      then
      break;
    else
      if [[ $NUM -gt $SECRET_NUMBER ]]
        then
         echo -n "It's lower than that, guess again:"
      elif [[ $NUM -lt $SECRET_NUMBER ]]
        then
          echo -n "It's higher than that, guess again:"
      fi
    fi
  fi
  GUESS=$(( $GUESS + 1 ))
done

if [[ $GUESS == 1 ]]
  then
    echo "You guessed it in 1 tries. The secret number was $SECRET_NUMBER . Nice job!"
  else
     echo "You guessed it in $GUESS tries. The secret number was $SECRET_NUMBER. Nice job!"
fi

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
INSERT_GAME=$($PSQL "INSERT INTO games(guesses, user_id) VALUES($GUESS, $USER_ID)")