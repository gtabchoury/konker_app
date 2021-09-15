import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/services/DeviceService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {

  @override
  Widget build(BuildContext context) {

    String _dispositivos = "";

    List<TableRow> _rows = <TableRow>[
      new TableRow(
        children: <Widget>[
          Text("Nome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
          Text("Ativo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
        ],
      ),
    ];

    Future<bool> loadDevices() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      List<Device> devices = await DeviceService.getAll("default", token!);

      for (Device d in devices){
        _rows.add(new TableRow(
          children: <Widget>[
            Text(d.name, style: TextStyle(fontSize: 20),),
            Text(d.active.toString(), style: TextStyle(fontSize: 20),)
          ],
        ));
      }

      return true;
    }

    return FutureBuilder<bool>(
        future: loadDevices(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xffb00a69c),
                title: Text("Meus Dispositivos",
                  style: TextStyle(color: Colors.white, fontSize: 15),),
              ),
              body: Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: SingleChildScrollView(
                      child: Table(
                        children: _rows,
                      ),
                    )
                  )
                ),),
            );
          } else {
            return MyLoading();
          }
        }
    );
  }



}
