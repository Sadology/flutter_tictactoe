// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

// Idea and Algorith taken from https://www.geeksforgeeks.org/flutter-building-a-tic-tac-toe-game/

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tic Tac Toe",
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool oTurn = true;
  bool gameEnded = false;
  String message = "Play!";
  List<String> displayElement = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tic Tac Toe"),
        backgroundColor: Color.fromARGB(255, 223, 166, 144),
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 223, 166, 144),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 50, 0),
                child: Column(
                  children: <Widget>[
                    Text("O",
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text(oScore.toString(),
                        style: TextStyle(fontSize: 30, color: Colors.white))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Column(
                  children: <Widget>[
                    Text(message,
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 40, 0, 0),
                child: Column(
                  children: <Widget>[
                    Text("X",
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text(xScore.toString(),
                        style: TextStyle(fontSize: 30, color: Colors.white))
                  ],
                ),
              )
            ],
          )),
          Expanded(
            flex: 2,
            child: GridView.builder(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => {taps(index)},
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 247, 201, 183)),
                      child: Center(
                          child: Text(
                        displayElement[index],
                        style: TextStyle(color: Colors.white, fontSize: 80),
                      )),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 100, 0),
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                        elevation: 0,
                        onPressed: newGame,
                        child: Icon(Icons.restart_alt_outlined),
                        backgroundColor: Color.fromARGB(255, 247, 201, 183)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 40, 0, 0),
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                        elevation: 0,
                        onPressed: clearScore,
                        child: Icon(Icons.clear_all_outlined),
                        backgroundColor: Color.fromARGB(255, 247, 201, 183)),
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }

  void taps(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        oTurn = !oTurn;
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        oTurn = !oTurn;
        filledBoxes++;
      }

      CheckWinner();
    });
  }

  // Algorithm
  void CheckWinner() {
    // Check Row
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      ShowWin(displayElement[0]);
    }

    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      ShowWin(displayElement[3]);
    }

    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      ShowWin(displayElement[6]);
    }
    // Check Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      ShowWin(displayElement[0]);
    }

    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      ShowWin(displayElement[1]);
    }

    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      ShowWin(displayElement[2]);
    }
    // Check Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      ShowWin(displayElement[0]);
    }

    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      ShowWin(displayElement[2]);
    } else if (filledBoxes == 9) {
      ShowDraw();
    }
  }

  void ShowWin(String winner) {
    if (gameEnded == true) {
      return;
    }
    setState(() {
      message = winner + " Won!";
    });
    gameEnded = true;
    if (winner == 'O') {
      oScore++;
    } else if (winner == "X") {
      xScore++;
    }
  }

  void clearScore() {
    setState(() {
      oScore = 0;
      xScore = 0;
      newGame();
    });
  }

  void newGame() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
      message = "Play!";
      gameEnded = false;
    });
    filledBoxes = 0;
  }

  void ShowDraw() {
    if (gameEnded == true) {
      return;
    }
    setState(() {
      message = "Draw!";
    });
    gameEnded = true;
  }
}
