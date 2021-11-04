import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/pages/EditDevice.dart';
import 'package:konker_app/services/DeviceService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

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

    void _editDevice(String guid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return EditDevicePage(guid: guid);
        }),
      );
    }

    Future<void> _removeDevice(String deviceGuid, String deviceName) async {
      if (await confirm(
        context,
        title: Text(deviceName),
        content: Text('Deseja realmente remover este dispositivo?'),
        textOK: Text('Sim'),
        textCancel: Text('Cancelar'),
      )) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? token = prefs.getString("token");

        try {
          await DeviceService.delete(deviceGuid, "default", token!);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Dispositivo removido com sucesso!"),
            backgroundColor: Colors.green,
          ));

          Navigator.popAndPushNamed(context, '/dashboard');
        } on Exception catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ));
        }
      }
    }

    Future<bool> loadDevices() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      List<Device> devices = await DeviceService.getAll("default", token!);

      for (Device d in devices) {
        _rows.add(new DataRow(
          cells: [
            DataCell(GestureDetector(
                child: Text(
                  d.id,
                  style: TextStyle(fontSize: 12),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/devicesevents");
                })),
            DataCell(Text(
              d.name,
              style: TextStyle(fontSize: 12),
            )),
            DataCell(Text(
              d.active! ? "Sim" : "Não",
              style: TextStyle(
                  fontSize: 12, color: d.active! ? Colors.green : Colors.red),
            )),
            DataCell(GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onTap: () {
                  _removeDevice(d.guid!, d.name);
                })),
            DataCell(GestureDetector(
                child: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                onTap: () {
                  _editDevice(d.guid!);
                }))
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
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dispositivos",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        RaisedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, "/new-device");
                            },
                            color: Colors.white,
                            textColor: Color(0xffb00a69c),
                            icon: Icon(Icons.add),
                            label: Text(
                              "Criar Novo",
                              style: TextStyle(fontSize: 14),
                            )),
                      ],
                    )),
                body: ListView(children: <Widget>[
                  DataTable(
                    columns: [
                      DataColumn(
                          label: Text('ID',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Nome',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Ativo',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                    ],
                    rows: _rows,
                    columnSpacing: 20,
                  ),
                ]));
          } else {
            return MyLoading(
              color: Color(0xffb00a69c),
            );
          }
        });
  }
}
