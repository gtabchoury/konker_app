import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/EventRoute.dart';
import 'package:konker_app/services/EventRouteService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEventRoutePage extends StatefulWidget {
  const AddEventRoutePage({Key? key}) : super(key: key);

  @override
  _AddEventRoutePageState createState() => _AddEventRoutePageState();
}

class _AddEventRoutePageState extends State<AddEventRoutePage> {

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _guidController = new TextEditingController();
  TextEditingController _incomingTypeController = new TextEditingController();
  TextEditingController _outgoingTypeController = new TextEditingController();

  bool? debug = false;
  bool? active = true;


  Future<void> _createEventRoute() async {
    try{
      EventRoute restDestination = new EventRoute(
        name: _nameController.text,
        description: _descriptionController.text,
        active: active,
        guid: _guidController.text,
        incomingType: _incomingTypeController.text,
        outgoingType: _outgoingTypeController.text,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      restDestination = await EventRouteService.create(restDestination, "default", token!);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Novo Roteador de Evento",
          style: TextStyle(color: Colors.white, fontSize: 15),),
        backgroundColor: Color(0xffbfbaf41),
      ),
      body: Container(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: 15)),
                Text("Criar Novo Roteador de Evento",
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
                      labelText: "Name",
                      labelStyle: TextStyle(color: Color(0xffbfbaf41), fontSize: 14),
                      hintText: "digite o nome do roteador de Evento"
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
                      labelText: "Description",
                      labelStyle: TextStyle(color: Color(0xffbfbaf41), fontSize: 14),
                      hintText: "digite a descrição do roteador de Evento"
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
                      hintText: "digite o guid do roteador de Evento"
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
                      labelText: "Icoming Type",
                      labelStyle: TextStyle(color: Color(0xffbfbaf41), fontSize: 14),
                      hintText: "digite o incoming type do roteador de Evento"
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
                      hintText: "digite o outgoing type do roteador de Evento"
                  ),
                  style: TextStyle(fontSize: 14),
                  controller: this._outgoingTypeController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                RaisedButton.icon(
                    onPressed: _createEventRoute,
                    padding: EdgeInsets.fromLTRB(25,10,25,10),
                    color: Color(0xffbfbaf41),
                    textColor: Colors.white,
                    icon: Icon(Icons.add),
                    label: Text("Cadastrar", style: TextStyle(fontSize: 16),)
                ),
              ],
            ),)
      ),
    );
  }
}
