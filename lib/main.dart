
import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tic Tac Toe',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: TicTacToeScreen(),
        ),
      ),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> boxes = List.filled(9, "");
  bool turnO = true;
  int count = 0;

  final List<List<int>> winPatterns = [
    [0, 1, 2],
    [0, 3, 6],
    [0, 4, 8],
    [1, 4, 7],
    [2, 5, 8],
    [2, 4, 6],
    [3, 4, 5],
    [6, 7, 8],
  ];

  void resetGame() {
    setState(() {
      boxes = List.filled(9, "");
      turnO = true;
      count = 0;
    });
  }

  void boxClick(int index) {
    if (boxes[index] == "") {
      setState(() {
        if (turnO) {
          boxes[index] = "🅞";
        } else {
          boxes[index] = "✘";
        }
        turnO = !turnO;
        count++;
      });

      if (count == 9 && !checkWinner()) {
        gameDraw();
      } else {
        checkWinner();
      }
    }
  }

  bool checkWinner() {
    for (var pattern in winPatterns) {
      var pos1Val = boxes[pattern[0]];
      var pos2Val = boxes[pattern[1]];
      var pos3Val = boxes[pattern[2]];

      if (pos1Val != "" && pos2Val != "" && pos3Val != "") {
        if (pos1Val == pos2Val && pos2Val == pos3Val) {
          showWinner(pos1Val);
          return true;
        }
      }
    }
    return false;
  }

  void gameDraw() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Game Draw"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text("New Game"),
            ),
          ],
        );
      },
    );
  }

  void showWinner(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          title: Text(
            "😎 Winner 😎",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Text(
            "Congratulations, Winner is $winner",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text("New Game"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        
        backgroundColor: Color.fromARGB(255, 82, 79, 82),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          title: Center(
            
              child: Text(
            '❌ TIC TAC TOE ⭕',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),),
        ),
        body: Center(
          
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.normal),
                ),
                
                
                onPressed: resetGame,
                
                child: Text(
                  'New Game',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                      ),
                ),
              ),
              Container(
                height: 40,
                color:const Color.fromARGB(255, 82, 79, 82),
              ),
              Text(
                'Tic Tac Toe',
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 9,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(10.0), // Adjust the padding as needed
                  child: ElevatedButton(
                    onPressed: () => boxClick(index),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10.0),
                    ),
                    child: Text(boxes[index], style: TextStyle(fontSize: 40)),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
                color: Color.fromARGB(255, 12, 65, 118),
                child: Center(child: Text("©️ Made with ❤ by Mahendra Singh", style: TextStyle(color: Colors.white, fontSize: 15),)),
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}