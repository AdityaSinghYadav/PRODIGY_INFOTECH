import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(StopwatchApp());

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  bool _isRunning = false;
  bool _isPaused = false;
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _formattedTime = '00:00.000';

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
      _stopwatch.start();
      _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        if (_isRunning && !_isPaused) {
          setState(() {
            _formattedTime =
            '${(_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}.${(_stopwatch.elapsed.inMilliseconds % 1000).toString().padLeft(3, '0')}';
          });
        }
      });
    });
  }

  void _stopStopwatch() {
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _stopwatch.stop();
      _formattedTime =
      '${(_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}.${(_stopwatch.elapsed.inMilliseconds % 1000).toString().padLeft(3, '0')}';
      _timer?.cancel();
    });
  }

  void _holdStopwatch() {
    setState(() {
      _isPaused = true;
    });
  }

  void _resetStopwatch() {
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _stopwatch.reset();
      _formattedTime = '00:00.000';
      _timer?.cancel();
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formattedTime,
              style: TextStyle(fontSize: 40.0),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isRunning ? _stopStopwatch : _startStopwatch,
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isRunning ? _holdStopwatch : null,
                  child: Text('Hold'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isRunning || _isPaused ? _resetStopwatch : null,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
