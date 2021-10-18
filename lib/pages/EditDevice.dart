import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/pages/Devices.dart';
import 'package:konker_app/services/DeviceService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDevicePage extends StatefulWidget {
  String guid;

  EditDevicePage({required this.guid});

  @override
  _EditDevicePageState createState() => _EditDevicePageState();
}

class _EditDevicePageState extends State<EditDevicePage> {

  TextEditingController _idController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();

  bool? debug = false;
  bool? active = false;

  Future<void> _editDevice() async {
      try{
        Device device = new Device(
            id: _idController.text,
            name: _nameController.text,
            description: _descController.text,
            locationName: _locationController.text,
            active: active,
            debug: debug
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? token = prefs.getString("token");

        await DeviceService.edit(device, widget.guid, "default", token!);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Dispositivo atualizado com sucesso!"),
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

  Future<Device> loadDevice() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    Device device = await DeviceService.getByGuid(widget.guid, "default", token!);

    _idController.text = device.id;
    _nameController.text = device.name;
    _descController.text = device.description!;
    _locationController.text = device.locationName!;

    if (device.debug!=null){
      debug = device.debug;
    }else{
      debug = false;
    }

    if (device.active!=null){
      active = device.active;
    }else{
      active = true;
    }
    setState(() {

    });
    return device;
  }

  @override
  void initState() {
    super.initState();
    loadDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Dispositivo",
          style: TextStyle(color: Colors.white, fontSize: 15),),
        backgroundColor: Color(0xffb00a69c),
      ),
      body: Container(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: 15)),
                Text("Editar Dispositivo",
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
                            debug = !debug!;
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
                            active = !active!;
                          });
                        }
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 15)),
                RaisedButton.icon(
                    onPressed: _editDevice,
                    padding: EdgeInsets.fromLTRB(25,10,25,10),
                    color: Color(0xffb00a69c),
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
