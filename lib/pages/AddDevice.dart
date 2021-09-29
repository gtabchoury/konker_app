import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/services/DeviceService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({Key? key}) : super(key: key);

  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {

  TextEditingController _idController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  TextEditingController _modelNameController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();

  bool debug = false;
  bool active = true;

  Future<void> _createDevice() async {
      try{
        Device device = new Device(
            id: _idController.text,
            name: _nameController.text,
            description: _descController.text,
            deviceModelName: _modelNameController.text,
            locationName: _locationController.text,
            active: active,
            debug: debug
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? token = prefs.getString("token");

        device = await DeviceService.create(device, "default", token!);
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
        title: Text("Criar Novo Dispositivo",
          style: TextStyle(color: Colors.white, fontSize: 15),),
        backgroundColor: Color(0xffb00a69c),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 15)),
            Text("Criar Novo Dispositivo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffb00a69c), ),),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb00a69c), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb00a69c), width: 2),
                  ),
                  labelText: "Id",
                  labelStyle: TextStyle(color: Color(0xffb00a69c), fontSize: 14),
                  hintText: "digite o id do dispositivo"
              ),
              style: TextStyle(fontSize: 14),
              controller: this._idController,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffb00a69c), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffb00a69c), width: 2),
                ),
                labelText: "Nome",
                labelStyle: TextStyle(color: Color(0xffb00a69c), fontSize: 14),
                hintText: "digite o nome do dispositivo",
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
                  borderSide: BorderSide(color: Color(0xffb00a69c), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffb00a69c), width: 2),
                ),
                labelText: "Nome do Modelo",
                labelStyle: TextStyle(color: Color(0xffb00a69c), fontSize: 14),
                hintText: "digite o nome do modelo do dispositivo",
              ),
              style: TextStyle(fontSize: 14),
              controller: this._modelNameController,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffb00a69c), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffb00a69c), width: 2),
                ),
                labelText: "Localização",
                labelStyle: TextStyle(color: Color(0xffb00a69c), fontSize: 14),
                hintText: "digite a localização dispositivo",
              ),
              style: TextStyle(fontSize: 14),
              controller: this._locationController,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(10,20,10,20),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffb00a69c), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffb00a69c), width: 2),
                ),
                labelText: "Descrição",
                labelStyle: TextStyle(color: Color(0xffb00a69c), fontSize: 14),
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
                  value: this.debug,
                  onChanged: (value) {
                    setState(() {
                      debug = value!;
                    });
                  },
                ),
                GestureDetector(
                    child: Text("Debug", style: TextStyle(color: Color(0xffb00a69c), fontSize: 16),),
                    onTap: () {
                      setState(() {
                        debug = !debug;
                      });
                    }
                ),
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
                  child: Text("Ativo", style: TextStyle(color: Color(0xffb00a69c), fontSize: 16),),
                  onTap: () {
                    setState(() {
                      active = !active;
                    });
                  }
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            RaisedButton.icon(
                onPressed: _createDevice,
                padding: EdgeInsets.fromLTRB(25,10,25,10),
                color: Color(0xffb00a69c),
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
