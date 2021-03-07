import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Contador de Pessoas", home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0;
  String _info = "Pode Entrar!";

  void changePeople(int delta) {
    setState(() {
      _people += delta;
      if (_people < 0) _people = 0;
      if (_people >= 12) {
        _info = "Lotado";
        _people = 12;
      } else
        _info = "Pode Entrar!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/restaurant.jpeg",
          fit: BoxFit.cover,
          height: 1000,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pessoas: $_people",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextButton(
                      onPressed: () => {changePeople(-1)},
                      child: Text("-1",
                          style:
                              TextStyle(fontSize: 40.0, color: Colors.white))),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextButton(
                      onPressed: () => {changePeople(1)},
                      child: Text("+1",
                          style:
                              TextStyle(fontSize: 40.0, color: Colors.white))),
                ),
              ],
            ),
            Text(
              _info,
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0),
            )
          ],
        )
      ],
    );
  }
}
