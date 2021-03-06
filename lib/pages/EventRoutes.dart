import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/EventRoute.dart';
import 'package:konker_app/services/EventRouteService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:konker_app/pages/EditEventRoute.dart';

class EventRoutesPage extends StatefulWidget {
  const EventRoutesPage({Key? key}) : super(key: key);

  @override
  _EventRoutesPageState createState() => _EventRoutesPageState();
}

class _EventRoutesPageState extends State<EventRoutesPage> {
  @override
  Widget build(BuildContext context) {

    List<DataRow> _rows = <DataRow>[];

    void _editRoute(String guid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return EditEventRoutePage(guid: guid);
        }),
      );
    }

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
          await EventRouteService.delete(routeUuid, "default", token!);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Roteador de evento removido com sucesso!"),
            backgroundColor: Colors.green,
          ));

          Navigator.popAndPushNamed(context,'/dashboard');
        } on Exception catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ));
        }
      }
    }

    Future<bool> loadEventRoutes() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      List<EventRoute> routes = await EventRouteService.getAll("default", token!);

      for (EventRoute d in routes){
        _rows.add(new DataRow(
          cells: [
            DataCell(Text(d.name, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.incomingType!, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.outgoingType!, style: TextStyle(fontSize: 14),)),
            DataCell(Text( d.active! ? "Sim" : "N??o", style: TextStyle(fontSize: 14, color:  d.active! ? Colors.green : Colors.red),)),
            DataCell(GestureDetector(child: Icon(Icons.delete, color: Colors.red,), onTap: () {_removeRoute(d.guid!, d.name);}))
          ],
        ));
      }
      return true;
    }

    return FutureBuilder<bool>(
        future: loadEventRoutes(),
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
