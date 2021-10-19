import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/RestDestination.dart';
import 'package:konker_app/services/RestDestinationService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:konker_app/pages/EditRestDestination.dart';


class RestDestinationsPage extends StatefulWidget {
  const RestDestinationsPage({Key? key}) : super(key: key);

  @override
  _RestDestinationsPageState createState() => _RestDestinationsPageState();
}

class _RestDestinationsPageState extends State<RestDestinationsPage> {

  @override
  Widget build(BuildContext context) {

    List<DataRow> _rows = <DataRow>[];

    void _editRestDestination(String guid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return EditRestDestinationPage(guid: guid);
        }),
      );
    }



    Future<void> _removeRestDestination(String restDestinationGuid, String restDestinationName) async {
      if (await confirm(
        context,
        title: Text(restDestinationName),
        content: Text('Deseja realmente remover este destino Rest?'),
        textOK: Text('Sim'),
        textCancel: Text('Cancelar'),
      )){
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? token = prefs.getString("token");

        try{
          await RestDestinationService.delete(restDestinationGuid, "default", token!);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Destino rest removido com sucesso!"),
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

    Future<bool> loadRestDestinations() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      List<RestDestination> restDestinations = await RestDestinationService.getAll("default", token!);

      for (RestDestination d in restDestinations){
        _rows.add(new DataRow(
          cells: [
            DataCell(Text(d.name, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.method, style: TextStyle(fontSize: 14),)),
            DataCell(Text(d.type, style: TextStyle(fontSize: 14),)),
            DataCell(GestureDetector(child: Icon(Icons.delete, color: Colors.red,), onTap: () {_removeRestDestination(d.guid!, d.name);})),
            DataCell(GestureDetector(child: Icon(Icons.edit, color: Colors.blue,), onTap: () {_editRestDestination(d.guid!);}))
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
                backgroundColor: Color(0xffb667978),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Destinos Rest",
                        style: TextStyle(color: Colors.white, fontSize: 15),),
                      RaisedButton.icon(
                          onPressed: (){
                            Navigator.pushNamed(context, "/new-rest-destination");
                          },
                          color: Colors.white,
                          textColor: Color(0xffb667978),
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
                          'Método',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                      DataColumn(label: Text(
                          'Tipo',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                      DataColumn(label: Text(
                          '',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      )),
                    ],
                    rows: _rows,
                  columnSpacing: 0,
                ),
              ])
            );
          } else {
            return MyLoading(color: Color(0xffb667978),);
          }
        }
    );
  }



}
