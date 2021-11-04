import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/Gateway.dart';
import 'package:konker_app/pages/Gateways.dart';
import 'package:konker_app/services/GatewayService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditGatewayPage extends StatefulWidget {
  String guid;

  EditGatewayPage({required this.guid});

  @override
  _EditGatewayPageState createState() => _EditGatewayPageState();
}

class _EditGatewayPageState extends State<EditGatewayPage> {
  TextEditingController _idController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();

  bool active = false;

  Future<void> _editGateway() async {
    try {
      Gateway device = new Gateway(
          name: _nameController.text,
          description: _descController.text,
          locationName: _locationController.text,
          active: active);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      await GatewayService.edit(device, widget.guid, "default", token!);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Dispositivo atualizado com sucesso!"),
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

  Future<Gateway> loadGateway() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    Gateway device =
        await GatewayService.getByGuid(widget.guid, "default", token!);

    _nameController.text = device.name;
    _descController.text = device.description!;
    //_locationController.text = device.locationName!;
    active = device.active;
    setState(() {});
    return device;
  }

  @override
  void initState() {
    super.initState();
    loadGateway();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Editar Gateway",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: Color(0xffb00a69c),
      ),
      body: Container(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: 15)),
                Text(
                  "Editar Gateway",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffb00a69c),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffb00a69c), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffb00a69c), width: 2),
                    ),
                    labelText: "Nome",
                    labelStyle:
                        TextStyle(color: Color(0xffb00a69c), fontSize: 14),
                    hintText: "digite o nome do dispositivo",
                  ),
                  style: TextStyle(fontSize: 14),
                  controller: this._nameController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffb00a69c), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffb00a69c), width: 2),
                    ),
                    labelText: "Localização",
                    labelStyle:
                        TextStyle(color: Color(0xffb00a69c), fontSize: 14),
                    hintText: "digite a localização dispositivo",
                  ),
                  style: TextStyle(fontSize: 14),
                  controller: this._locationController,
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffb00a69c), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffb00a69c), width: 2),
                    ),
                    labelText: "Descrição",
                    labelStyle:
                        TextStyle(color: Color(0xffb00a69c), fontSize: 14),
                    hintText: "Descrição do dispositivo",
                  ),
                  style: TextStyle(fontSize: 14),
                  controller: this._descController,
                  minLines: 2,
                  maxLines: 2,
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                Row(
                  children: [
                    Checkbox(
                      value: this.active,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    GestureDetector(
                        child: Text(
                          "Debug",
                          style: TextStyle(
                              color: Color(0xffb00a69c), fontSize: 16),
                        ),
                        onTap: () {
                          setState(() {});
                        }),
                    Padding(padding: EdgeInsets.only(right: 30)),
                    Checkbox(
                      value: this.active,
                      onChanged: (value) {
                        setState(() {
                          active = value!;
                        });
                      },
                    ),
                    GestureDetector(
                        child: Text(
                          "Ativo",
                          style: TextStyle(
                              color: Color(0xffb00a69c), fontSize: 16),
                        ),
                        onTap: () {
                          setState(() {
                            active = !active;
                          });
                        })
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                RaisedButton.icon(
                    onPressed: _editGateway,
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    color: Color(0xffb00a69c),
                    textColor: Colors.white,
                    icon: Icon(Icons.refresh),
                    label: Text(
                      "Atualizar",
                      style: TextStyle(fontSize: 16),
                    )),
              ],
            ),
          )),
    );
  }
}
