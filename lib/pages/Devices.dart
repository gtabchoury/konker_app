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

    List<DataRow> _rows = <DataRow>[];

    Future<bool> loadDevices() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      List<Device> devices = await DeviceService.getAll("default", token!);

      for (Device d in devices){
        _rows.add(new DataRow(
          cells: [
            DataCell(Text(d.id, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.name, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.active! ? "Sim" : "Não", style: TextStyle(fontSize: 14, color: d.active! ? Colors.green : Colors.red),)),
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
                title: Text("Dispositivos",
                  style: TextStyle(color: Colors.white, fontSize: 15),),
              ),
              body: ListView(children: <Widget>[
                DataTable(
                    columns: [
                      DataColumn(label: Text(
                          'ID',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                      DataColumn(label: Text(
                          'Name',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                      DataColumn(label: Text(
                          'Ativo',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                    ],
                    rows: _rows,
                  columnSpacing: 20,
                ),
              ])
            );
          } else {
            return MyLoading(color: Color(0xffb00a69c),);
          }
        }
    );
  }



}
