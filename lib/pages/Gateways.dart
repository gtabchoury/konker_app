import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/EventRoute.dart';
import 'package:konker_app/models/Gateway.dart';
import 'package:konker_app/services/GatewayService.dart';
import 'package:konker_app/services/RouteService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GatewayPage extends StatefulWidget {
  const GatewayPage({Key? key}) : super(key: key);

  @override
  _GatewayPageState createState() => _GatewayPageState();
}

class _GatewayPageState extends State<GatewayPage> {
  @override
  Widget build(BuildContext context) {

    String _gateways = "";

    List<DataRow> _rows = <DataRow>[];

    Future<bool> loadGateways() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      List<Gateway> gateways = await GatewayService.getAll("default", token!);

      for (Gateway d in gateways){
        _rows.add(new DataRow(
          cells: [
            DataCell(Text(d.name, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.description!, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.active ? "Sim" : "Não", style: TextStyle(fontSize: 14, color: d.active ? Colors.green : Colors.red),)),
          ],
        ));
      }
      return true;
    }

    return FutureBuilder<bool>(
        future: loadGateways(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xffbe54182),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Gateways",
                        style: TextStyle(color: Colors.white, fontSize: 15),),
                      RaisedButton.icon(
                          onPressed: (){
                            Navigator.pushNamed(context, "/new-gateway");
                          },
                          color: Colors.white,
                          textColor: Color(0xffbe54182),
                          icon: Icon(Icons.add),
                          label: Text("Criar Novo", style: TextStyle(fontSize: 14),)
                      ),
                    ],
                )
                ),
                body: ListView(children: <Widget>[
                  DataTable(
                    columns: [
                      DataColumn(label: Text(
                          'Nome',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                      DataColumn(label: Text(
                          'Descrição',
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
            return MyLoading(color: Color(0xffbe54182),);
          }
        }
    );
  }
}
