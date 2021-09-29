import 'package:flutter/material.dart';
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/services/DeviceService.dart';

class MyCardHelp extends StatefulWidget {

  final Icon icon;
  final Color color;
  final String title;

  MyCardHelp({
    required this.icon,
    this.color = Colors.white,
    required this.title,
  });

  @override
  _MyCardHelpState createState() => _MyCardHelpState();
}

class _MyCardHelpState extends State<MyCardHelp> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
      width: 150,
      height: 150,
      color: widget.color,
      child: Column(
        children: [
          widget.icon,
          Padding(padding: EdgeInsets.only(top: 15)),
          Text("${widget.title}", style: TextStyle(color: Colors.white, fontSize: 14), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

