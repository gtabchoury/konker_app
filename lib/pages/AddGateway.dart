import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/models/Gateway.dart';
import 'package:konker_app/services/DeviceService.dart';
import 'package:konker_app/services/GatewayService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddGatewayPage extends StatefulWidget {
  const AddGatewayPage({Key? key}) : super(key: key);

  @override
  _AddGatewayPageState createState() => _AddGatewayPageState();
}

class _AddGatewayPageState extends State<AddGatewayPage> {
  
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();
  
  bool active = true;

  Future<void> _createGateway() async {
      try{
        Gateway gateway = new Gateway(
            name: _nameController.text,
            description: _descController.text,
            locationName: _locationController.text,
            active: active,
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? token = prefs.getString("token");

        gateway = await GatewayService.create(gateway, "default", token!);
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
        title: Text("Criar Novo Gateway",
          style: TextStyle(color: Colors.white, fontSize: 15),),
        backgroundColor: Color(0xffbe54182),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 15)),
            Text("Criar Novo Gateway",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffbe54182), ),),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffbe54182), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffbe54182), width: 2),
                ),
                labelText: "Nome",
                labelStyle: TextStyle(color: Color(0xffbe54182), fontSize: 14),
                hintText: "digite o nome do gateway",
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
                  borderSide: BorderSide(color: Color(0xffbe54182), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffbe54182), width: 2),
                ),
                labelText: "Localização",
                labelStyle: TextStyle(color: Color(0xffbe54182), fontSize: 14),
                hintText: "digite a localização gateway",
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
                  borderSide: BorderSide(color: Color(0xffbe54182), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffbe54182), width: 2),
                ),
                labelText: "Descrição",
                labelStyle: TextStyle(color: Color(0xffbe54182), fontSize: 14),
                hintText: "Descrição do gateway",
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
                    setState(() {
                      active = value!;
                    });
                  },
                ),
                GestureDetector(
                  child: Text("Ativo", style: TextStyle(color: Color(0xffbe54182), fontSize: 16),),
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
                onPressed: _createGateway,
                padding: EdgeInsets.fromLTRB(25,10,25,10),
                color: Color(0xffbe54182),
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
