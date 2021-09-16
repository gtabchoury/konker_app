import 'package:flutter/material.dart';

class MyLoading extends StatefulWidget {
  final Color color;

  MyLoading({
    this.color = Colors.black,
  });

  @override
  _MyLoadingState createState() => _MyLoadingState();
}

class _MyLoadingState extends State<MyLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Carregando...',
                    color: widget.color,
                    strokeWidth: 6,
                  ),),
              ],
            ),
          )
      ),
    );
  }
}
