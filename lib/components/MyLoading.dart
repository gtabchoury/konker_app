import 'package:flutter/material.dart';

class MyLoading extends StatefulWidget {
  const MyLoading({Key? key}) : super(key: key);

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
                Text(
                  'Carregando...',
                  style: Theme.of(context).textTheme.headline6,
                ),
                CircularProgressIndicator(
                  semanticsLabel: 'Carregando...',
                ),
              ],
            ),
          )
      ),
    );
  }
}
