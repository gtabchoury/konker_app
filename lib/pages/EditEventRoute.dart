import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/EventRoute.dart';
import 'package:konker_app/pages/EventRoutes.dart';
import 'package:konker_app/services/EventRouteService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditEventRoutePage extends StatefulWidget {
  String guid;

  EditEventRoutePage({required this.guid});

  @override
  Event_EditRoutePageState createState() => Event_EditRoutePageState();
}

class Event_EditRoutePageState extends State<EditEventRoutePage> {

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _guidController = new TextEditingController();
  TextEditingController _incomingTypeController = new TextEditingController();
  TextEditingController _outgoingTypeController = new TextEditingController();

  bool? debug = false;
  bool? active = false;

  Future<void> Event_editRoute() async {
    try{
      EventRoute eventRoute = new EventRoute(
        name: _nameController.text,
        description: _descriptionController.text,
        active: active,
        guid: _guidController.text,
        incomingType: _incomingTypeController.text,
        outgoingType: _outgoingTypeController.text,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      await EventRouteService.edit(eventRoute, widget.guid, "default", token!);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Roteador de Evento atualizado com sucesso!"),
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

  Future<EventRoute> EventloadRoute() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    EventRoute eventRoute = await EventRouteService.getByGuid(widget.guid, "default", token!);

    _nameController.text = eventRoute.name;
    _descriptionController.text = eventRoute.description!;
    _guidController.text = eventRoute.guid!;
    _incomingTypeController.text = eventRoute.incomingType!;
    _outgoingTypeController.text = eventRoute.outgoingType!;

    if (eventRoute.active!=null){
    active = eventRoute.active;
    }else{
    active = true;
    }

    setState(() {

    });
    return eventRoute;
  }

  @override
  void initState() {
    super.initState();
    EventloadRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Roteador de Evento",
          style: TextStyle(color: Colors.white, fontSize: 15),),
        backgroundColor: Color(0xffbfbaf41),
      ),
      body: Container(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: 15)),
                Text("Editar Roteador de Evento",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffbfbaf41), ),),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffbfbaf41), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffbfbaf41), width: 2),
                      ),
                      labelText: "Nome",
                      labelStyle: TextStyle(color: Color(0xffbfbaf41), fontSize: 14),
                      hintText: "digite o nome do Roteador de Evento"
                  ),
                  style: TextStyle(fontSize: 14),
                  controller: this._nameController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffbfbaf41), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffbfbaf41), width: 2),
                      ),
                      labelText: "Derscrição",
                      labelStyle: TextStyle(color: Color(0xffbfbaf41), fontSize: 14),
                      hintText: "digite a descrição do Roteador de Evento"
                  ),
                  style: TextStyle(fontSize: 14),
                  controller: this._descriptionController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffbfbaf41), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffbfbaf41), width: 2),
                      ),
                      labelText: "Guid",
                      labelStyle: TextStyle(color: Color(0xffbfbaf41), fontSize: 14),
                      hintText: "digite o guid do Roteador de Evento"
                  ),
                  style: TextStyle(fontSize: 14),
                  controller: this._guidController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffbfbaf41), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffbfbaf41), width: 2),
                      ),
                      labelText: "Incoming Type",
                      labelStyle: TextStyle(color: Color(0xffbfbaf41), fontSize: 14),
                      hintText: "digite o incoming type do Roteador de Evento"
                  ),
                  style: TextStyle(fontSize: 14),
                  controller: this._incomingTypeController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffbfbaf41), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffbfbaf41), width: 2),
                      ),
                      labelText: "Outgoing Type",
                      labelStyle: TextStyle(color: Color(0xffbfbaf41), fontSize: 14),
                      hintText: "digite o outgoing type do Roteador de Evento"
                  ),
                  style: TextStyle(fontSize: 14),
                  controller: this._outgoingTypeController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                RaisedButton.icon(
                    onPressed: Event_editRoute,
                    padding: EdgeInsets.fromLTRB(25,10,25,10),
                    color: Color(0xffbfbaf41),
                    textColor: Colors.white,
                    icon: Icon(Icons.refresh),
                    label: Text("Atualizar", style: TextStyle(fontSize: 16),)
                ),
              ],
            ),)
      ),
    );
  }
}
