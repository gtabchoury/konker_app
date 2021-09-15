import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/RestDestination.dart';
import 'package:konker_app/services/RestDestinationService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RestDestinationsPage extends StatefulWidget {
  const RestDestinationsPage({Key? key}) : super(key: key);

  @override
  _RestDestinationsPageState createState() => _RestDestinationsPageState();
}

class _RestDestinationsPageState extends State<RestDestinationsPage> {

  @override
  Widget build(BuildContext context) {

    String _dispositivos = "";

    List<DataRow> _rows = <DataRow>[];

    Future<bool> loadRestDestinations() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      List<RestDestination> restDestinations = await RestDestinationService.getAll("default", token!);

      for (RestDestination d in restDestinations){
        _rows.add(new DataRow(
          cells: [
            // DataCell(Text(d.id, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.name, style: TextStyle(fontSize: 14),)),
            // DataCell(Text(d.active! ? "Sim" : "Não", style: TextStyle(fontSize: 14, color: d.active! ? Colors.green : Colors.red),)),
          ],
        ));
      }
      return true;
    }

    return FutureBuilder<bool>(
        future: loadRestDestinations(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xffb00a69c),
                title: Text("Destinos Rest",
                  style: TextStyle(color: Colors.white, fontSize: 15),),
              ),
              body: ListView(children: <Widget>[
                DataTable(
                    columns: [
                      // DataColumn(label: Text(
                      //     'ID',
                      //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      // )),
                      DataColumn(label: Text(
                          'Name',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                      // DataColumn(label: Text(
                      //     'Ativo',
                      //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      // )),
                    ],
                    rows: _rows,
                  columnSpacing: 0,
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
