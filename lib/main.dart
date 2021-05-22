import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //* hiding debug banner
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _seconds = 0;
  int _minutes = 25;
  late Timer _timer;
  var f = NumberFormat('00');

  void _startTimer() {
    if (_minutes > 0) {
      _seconds = _minutes * 60;
    }
    if (_seconds > 60) {
      _minutes = (_seconds / 60).floor();
      _seconds -= (_minutes * 60);
    }
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else if (_minutes > 0) {
          _seconds = 59;
          _minutes--;
        }
      });
    });
  }

  void _stopTimer() {
    _seconds = 0;
    _minutes = 25;
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, //* aligning
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${f.format(_minutes)} : ${f.format(_seconds)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                ),
              ),
            ],
          ),
          SizedBox(
            //* just adds empty space
            height: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _stopTimer();
                  });
                },
                color: Colors.black,
                shape: CircleBorder(
                  //* adding circle border
                  side: BorderSide(color: Colors.orange),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _startTimer();
                },
                color: Colors.orange,
                shape: CircleBorder(
                  //* adding circle border
                  side: BorderSide(color: Colors.orange),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
