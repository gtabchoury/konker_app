import 'dart:collection';

import 'package:flutter/material.dart';


class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffb051435),
        title: Text("Roteadores de Evento",
          style: TextStyle(color: Colors.white, fontSize: 15),),
      ),
      body: Container(
        child: Text("Roteadores de evento"),
      ),
    );
  }
}
