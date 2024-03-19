#!/bin/bash

#if no argument
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

  #get atomic_number using argument
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1") 2> /dev/null
  fi

  #check if atomic_number variable is empty
  if [[ -z $ATOMIC_NUMBER ]]
  then
    #get symbol using argument
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")

    #check if symbol variable is empty
    if [[ -z $SYMBOL ]]
    then
      #get name using argument
      NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
      #check if name variable is empty
      if [[ -z $NAME ]]
      then
        #give error
        echo I could not find that element in the database.
      else
        #get elements data using name variable
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$NAME'")
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
        TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
        TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
        ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
        MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
        BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
        
        #give output
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      fi
    else
      #get elements data using symbol variable
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$SYMBOL'")
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    
      #give output
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius." 
    fi
  else
    #get elements data using atomic_number variable
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    
    #give output
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius." 
  fi
fi

