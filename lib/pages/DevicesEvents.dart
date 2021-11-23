import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/components/MySelectField.dart';
import 'package:konker_app/services/DeviceService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class ChartItem {
  double value;
  DateTime date;

  ChartItem(this.value, this.date);
}

class DevicesEvents extends StatefulWidget {
  String guid;
  String? name;

  DevicesEvents({required this.guid, this.name});

  @override
  _DevicesEventsState createState() => _DevicesEventsState();
}

class _DevicesEventsState extends State<DevicesEvents> {
  List<SelectFieldItem> fieldsNames_ = [];
  List<charts.Series<ChartItem, DateTime>> timeline_ = [];

  String selectedAtt_ = "";
  String selectedDateFrom_ = "";
  String selectedDateTo_ = "";

  @override
  Widget build(BuildContext context) {
    List<DataRow> _rows = <DataRow>[];

    Future<bool> loadDevices() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      List<dynamic> events = await DeviceService.getEvents("default", token!,
          widget.guid, selectedAtt_, selectedDateFrom_, selectedDateTo_);

      print(events.length);

      if (events.length>0){
        Iterable i = events[0].keys;

        fieldsNames_ =
        List<SelectFieldItem>.from(i.map((x) => SelectFieldItem(x, x)));

        if (selectedAtt_.isNotEmpty) {
          List<ChartItem> charItems = [];
          for (var d in events) {
            DateTime dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss")
                .parse(d["timestamp"].toString().substring(0, 19));

            print(dateTime);

            charItems.add(
                ChartItem(double.parse(d[selectedAtt_].toString()), dateTime));
          }

          timeline_ = [
            charts.Series(
              id: "Resultado",
              data: charItems,
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (ChartItem timeline, _) => timeline.date,
              measureFn: (ChartItem timeline, _) => timeline.value,
            )
          ];
        }
      }else{
        timeline_ = [];
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
                body: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        Container(
                          child: MySelectField(
                              label: 'Propriedade',
                              currentValue: '',
                              items: fieldsNames_,
                              onChange: (String? s) {
                                selectedAtt_ = s!;
                              }),
                          height: 55,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        DateTimeFormField(
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.event_note),
                            labelText: 'Data inicial',
                          ),
                          mode: DateTimeFieldPickerMode.dateAndTime,
                          onDateSelected: (DateTime value) {
                            selectedDateFrom_ =
                                value.toString().substring(0, 19);
                          },
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        DateTimeFormField(
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.event_note),
                            labelText: 'Data final',
                          ),
                          mode: DateTimeFieldPickerMode.dateAndTime,
                          onDateSelected: (DateTime value) {
                            selectedDateTo_ = value.toString().substring(0, 19);
                          },
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        RaisedButton.icon(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(Icons.search),
                            label: Text('Buscar')),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        if (timeline_.length>0)
                          Container(
                            height: 400,
                            padding: EdgeInsets.all(20),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      selectedAtt_,
                                    ),
                                    Expanded(
                                      child: charts.TimeSeriesChart(
                                        timeline_,
                                        animate: false,
                                        dateTimeFactory:
                                            const charts.LocalDateTimeFactory(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                      ],
                    )));
          } else {
            return MyLoading(
              color: Color(0xffb00a69c),
            );
          }
        });
  }
}
