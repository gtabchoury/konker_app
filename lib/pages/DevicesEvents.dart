import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/services/DeviceService.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class DevicesEvents extends StatefulWidget {
  String guid;
  String? name;

  DevicesEvents({required this.guid, this.name});

  @override
  _DevicesEventsState createState() => _DevicesEventsState();
}

class _DevicesEventsState extends State<DevicesEvents> {
  @override
  Widget build(BuildContext context) {
    List<DataRow> _rows = <DataRow>[];

    Future<bool> loadDevices() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      List<dynamic> events =
          await DeviceService.getEvents("default", token!, widget.guid);

      for (var d in events) {
        _rows.add(new DataRow(
          cells: [
            DataCell(Text(
              d.toString(),
              style: TextStyle(fontSize: 14),
            ))
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
                          "Eventos do dispositivo: " +
                              (widget.name != null ? widget.name! : "null"),
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    )),
                body: ListView(children: <Widget>[
                  DataTable(
                    columns: [
                      DataColumn(
                          label: Text('Payload',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                    ],
                    rows: _rows,
                    dataRowHeight: 80,
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
