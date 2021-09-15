import 'dart:collection';

import 'package:flutter/material.dart';


class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffb051435),
        title: Text("Meus Dispositivos",
          style: TextStyle(color: Colors.white, fontSize: 15),),
      ),
      body: Container(
        child: Text("oi!"),
      ),
    );
  }
}
