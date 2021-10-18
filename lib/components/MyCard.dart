import 'package:flutter/material.dart';
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/services/DeviceService.dart';

class MyCard extends StatefulWidget {

  final Icon icon;
  final Color color;
  final String title;
  final int count;

  MyCard({
    required this.icon,
    this.color = Colors.white,
    required this.title,
    required this.count
  });

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
      width: 160,
      height: 160,
      color: widget.color,
      child: Column(
        children: [
          widget.icon,
          Padding(padding: EdgeInsets.only(top: 5)),
          Text("Você tem", style: TextStyle(color: Colors.white),),
          Padding(padding: EdgeInsets.only(top: 5)),
          Text("${widget.count}", style: TextStyle(color: Colors.white, fontSize: 30),),
          Padding(padding: EdgeInsets.only(top: 5)),
          Text("${widget.title}", style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

