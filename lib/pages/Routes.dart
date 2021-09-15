import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/EventRoute.dart';
import 'package:konker_app/services/RouteService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  @override
  Widget build(BuildContext context) {

    String _dispositivos = "";

    List<DataRow> _rows = <DataRow>[];

    Future<bool> loadDevices() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      List<EventRoute> routes = await RouteService.getAll("default", token!);

      for (EventRoute d in routes){
        _rows.add(new DataRow(
          cells: [
            DataCell(Text(d.name, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.active ? "Sim" : "Não", style: TextStyle(fontSize: 14, color: d.active ? Colors.green : Colors.red),)),
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
                  backgroundColor: Color(0xffbfbaf41),
                  title: Text("Roteadores de Eventos",
                    style: TextStyle(color: Colors.white, fontSize: 15),),
                ),
                body: ListView(children: <Widget>[
                  DataTable(
                    columns: [
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
                    columnSpacing: 0,
                  ),
                ])
            );
          } else {
            return MyLoading(color: Color(0xffbfbaf41),);
          }
        }
    );
  }
}
