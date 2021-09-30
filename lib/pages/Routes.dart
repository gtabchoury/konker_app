import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/EventRoute.dart';
import 'package:konker_app/services/RouteService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  @override
  Widget build(BuildContext context) {

    List<DataRow> _rows = <DataRow>[];

    Future<void> _removeRoute(String routeUuid, String routeName) async {
      if (await confirm(
        context,
        title: Text(routeName),
        content: Text('Deseja realmente remover este roteador de evento?'),
        textOK: Text('Sim'),
        textCancel: Text('Cancelar'),
      )){
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? token = prefs.getString("token");

        try{
          await RouteService.delete(routeUuid, "default", token!);
        } on Exception catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ));
        }
      }
    }

    Future<bool> loadRoutes() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      List<EventRoute> routes = await RouteService.getAll("default", token!);

      for (EventRoute d in routes){
        _rows.add(new DataRow(
          cells: [
            DataCell(Text(d.name, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.incomingType!, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.outgoingType!, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.active ? "Sim" : "Não", style: TextStyle(fontSize: 14, color: d.active ? Colors.green : Colors.red),)),
            DataCell(GestureDetector(child: Icon(Icons.delete, color: Colors.red,), onTap: () {_removeRoute(d.guid!, d.name);}))
          ],
        ));
      }
      return true;
    }

    return FutureBuilder<bool>(
        future: loadRoutes(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                    backgroundColor: Color(0xffbfbaf41),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Roteadores de Evento",
                          style: TextStyle(color: Colors.white, fontSize: 15),),
                        RaisedButton.icon(
                            onPressed: (){
                              Navigator.pushNamed(context, "/new-event-route");
                            },
                            color: Colors.white,
                            textColor: Color(0xffbfbaf41),
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
                          'Origem',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                      DataColumn(label: Text(
                          'Destino',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                      DataColumn(label: Text(
                          'Ativo',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                      DataColumn(label: Text(
                          '',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                    ],
                    rows: _rows,
                    columnSpacing: 20,
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
