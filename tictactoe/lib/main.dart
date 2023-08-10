import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late List<List<String>> _board;
  bool _isPlayerX = true;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _isPlayerX = true;
    _gameOver = false;
  }

  void _makeMove(int row, int col) {
    if (!_gameOver && _board[row][col] == "") {
      setState(() {
        _board[row][col] = _isPlayerX ? "X" : "O";
        _isPlayerX = !_isPlayerX;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] != "" &&
          _board[i][0] == _board[i][1] &&
          _board[i][1] == _board[i][2]) {
        _setWinner(_board[i][0]);
        return;
      }
      if (_board[0][i] != "" &&
          _board[0][i] == _board[1][i] &&
          _board[1][i] == _board[2][i]) {
        _setWinner(_board[0][i]);
        return;
      }
    }
    if (_board[0][0] != "" &&
        _board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2]) {
      _setWinner(_board[0][0]);
      return;
    }
    if (_board[0][2] != "" &&
        _board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0]) {
      _setWinner(_board[0][2]);
      return;
    }
    bool isBoardFull = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == "") {
          isBoardFull = false;
          break;
        }
      }
    }
    if (isBoardFull) {
      _setWinner("Draw");
    }
  }

  void _setWinner(String winner) {
    setState(() {
      _gameOver = true;
      _showGameOverDialog(winner);
    });
  }

  void _showGameOverDialog(String winner) {
    String message;
    if (winner == "Draw") {
      message = "It's a draw!";
    } else {
      message = "Player $winner wins!";
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _initializeBoard();
              },
              child: Text("Play Again"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () {
                    _makeMove(row, col);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        _board[row][col],
                        style: TextStyle(fontSize: 50.0),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 9,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pinkAccent,
                // side: BorderSide(color: Colors.yellow, width: 5),
                textStyle: const TextStyle(
                    color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: _gameOver
                  ? () {
                setState(() {
                  _initializeBoard();
                });
              }
                  : null,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
