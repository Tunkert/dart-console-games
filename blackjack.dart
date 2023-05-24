// import math for random numbers and io for user input
import 'dart:math';
import 'dart:io';

void main() {
  // create an Ace count variable for bloth the player and the user
  int aceCountPlayer = 0;
  int aceCountDealer = 0;

  // create card deck as multi-dimensional array
  var cardDeck = [
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
  ];

  // create initial card variables.
  int dealer1, dealer2, player1, player2;
  // assign initial card values
  dealer1 = cardDeck[Random().nextInt(4)][Random().nextInt(13)];
  dealer2 = cardDeck[Random().nextInt(4)][Random().nextInt(13)];
  player1 = cardDeck[Random().nextInt(4)][Random().nextInt(13)];
  player2 = cardDeck[Random().nextInt(4)][Random().nextInt(13)];

  // tell the player what card the dealer has showing
  if (dealer1 != 1 && dealer1 != 11 && dealer1 != 12 && dealer1 != 13) {
    print("The dealer has a $dealer1 card showing.");
  } else if (dealer1 == 11) {
    print("The dealer has a jack showing.");
  } else if (dealer1 == 12) {
    print("The dealer has a queen showing.");
  } else if (dealer1 == 13) {
    print("The dealer has a king showing.");
  } else {
    print("The dealer has an Ace showing.");
  }

  // account for jack, queen, and king for the dealer.
  if (dealer1 == 11 || dealer1 == 12 || dealer1 == 13) {
    dealer1 = 10;
  }
  if (dealer2 == 11 || dealer2 == 12 || dealer2 == 13) {
    dealer2 = 10;
  }

  // acount for jack, queen, and king for the player.
  if (player1 == 11 || player1 == 12 || player1 == 13) {
    player1 = 10;
  }
  if (player2 == 11 || player2 == 12 || player2 == 13) {
    player2 = 10;
  }

  // let the player know how many aces they have
  if (player1 == 1) {
    if (player2 == 1) {
      print("You have two aces.");
    } else {
      print("You have one ace.");
    }
  } else {
    if (player2 == 1) {
      print("You have one ace.");
    } else {
      print("You have no aces.");
    }
  }

  // find the initial sum of the dealer and the player
  int sumDealer = dealer1 + dealer2;
  int sumPlayer = player1 + player2;

  // welcome the player to the game
  print("Welcome to Blackjack!");

  // set initial user_response
  String user_response = "no";

  // begin do while loop to allow player to hit and force dealer to hit when less than 21
  do {
    int addToDealerSum = cardDeck[Random().nextInt(4)][Random().nextInt(13)];
    if (addToDealerSum == 11 || addToDealerSum == 12 || addToDealerSum == 13) {
      addToDealerSum = 10;
    }
    if (addToDealerSum == 1) {
      aceCountDealer += 1;
      print("The dealer drew an Ace!");
    }

    // consider whether the dealer should take a hit based on the aces they have
    if (dealer1 == 1 && sumDealer < 8) {
      sumDealer += addToDealerSum;
    } else if (dealer2 == 1 && sumDealer < 8) {
      sumDealer += addToDealerSum;
    } else if (sumDealer < 17) {
      sumDealer += addToDealerSum;
    } 

    // see if the player wants a hit.
    print("Your card total is $sumPlayer. Do you want to hit. Type 'yes' or 'no'");
    user_response = stdin.readLineSync()!;
    if (user_response.toLowerCase() == 'y' || user_response.toLowerCase() == 'yes') {
      int player3 = cardDeck[Random().nextInt(4)][Random().nextInt(13)];
      if (player3 == 11 || player3 == 12 && player3 == 13) {
        player3 = 10;
      }
      if (player3 == 1) {
        aceCountPlayer += 1;
        print("You drew an Ace!");
      }
      sumPlayer += player3;
      if (sumPlayer > 21 || sumDealer > 21) {
        break;
      }
    }
  } while (user_response == "yes" || sumDealer < 17);
  // end do while loop

  // if the player has aces figure out the highest possible score they can have without going over 21
  if (player1 == 1) {
    if (player2 == 1) {
      int possibleScore1 = sumPlayer + 10 + 10;
      int possibleScore2 = sumPlayer + 10;
      if (possibleScore1 > possibleScore2 && possibleScore1 <= 21) {
        sumPlayer = possibleScore1;
      } else if (possibleScore2 > possibleScore1 && possibleScore2 <= 21) {
        sumPlayer = possibleScore2;
      }
    } else {
      int possibleScore3 = sumPlayer + 10;
      if (possibleScore3 <= 21) {
        sumPlayer = possibleScore3;
      }
    }
  }

  // if the dealer has aces figure out the highest possible score they can have without going over 21
  if (dealer1 == 1) {
    if (dealer2 == 1) {
      int possibleDealerScore1 = sumDealer + 10 + 10;
      int possibleDealerScore2 = sumDealer + 10;
      if (possibleDealerScore1 > possibleDealerScore2 && possibleDealerScore1 <= 21) {
        sumPlayer = possibleDealerScore1;
      } else if (possibleDealerScore2 > possibleDealerScore1 && possibleDealerScore2 <= 21) {
        sumPlayer = possibleDealerScore2;
      }
    } else {
      int possibleDealerScore3 = sumDealer + 10;
      if (possibleDealerScore3 <= 21) {
        sumPlayer = possibleDealerScore3;
      }
    }
  }

  // take into account additional aces for the player
  if (aceCountPlayer > 0) {
    int newPlayerScore = sumPlayer + 10; // we can't add more than 10 because the player score will be atleast 2

    if (newPlayerScore <= 21) {
      sumPlayer = newPlayerScore;
    }
  }

  // take into account additional aces for the player
  if (aceCountDealer > 0) {
    int newDealerScore = sumDealer + 10; // we can't add more than 10 becausse the dealer score will be atleast 2
    if (aceCountDealer <= 21) {
      sumDealer = newDealerScore;
    }
  }

  // print out the total of both players
  print("The dealer finishes with a total of $sumDealer.");
  print("Your total was $sumPlayer.");

  // decide who wins and print out output of the game to the console
  if (sumPlayer > 21 || (sumPlayer <= sumDealer) && (sumDealer <= 21)) {
    print("You lost, loser!");
  } else {
    print("You won!");
  }
}
