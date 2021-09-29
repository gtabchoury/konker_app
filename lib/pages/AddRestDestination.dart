import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/RestDestination.dart';
import 'package:konker_app/services/RestDestinationService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRestDestinationPage extends StatefulWidget {
  const AddRestDestinationPage({Key? key}) : super(key: key);

  @override
  _AddRestDestinationPageState createState() => _AddRestDestinationPageState();
}

class _AddRestDestinationPageState extends State<AddRestDestinationPage> {

  TextEditingController _guidController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _methodController = new TextEditingController();
  TextEditingController _serviceURIController = new TextEditingController();
  TextEditingController _serviceUsernameController = new TextEditingController();
  TextEditingController _servicePasswordController = new TextEditingController();
  TextEditingController _typeController = new TextEditingController();
  TextEditingController _bodyController = new TextEditingController();

  bool debug = false;
  bool active = true;

  Future<void> _createRestDestination() async {
      try{
        RestDestination restDestination = new RestDestination(
            guid: _guidController.text,
            name: _nameController.text,
            method: _methodController.text,
            serviceURI: _serviceURIController.text,
            serviceUsername: _serviceUsernameController.text,
            servicePassword: _servicePasswordController.text,
            type: _typeController.text,
            body: _bodyController.text,
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? token = prefs.getString("token");

        restDestination = await RestDestinationService.create(restDestination, "default", token!);
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
        title: Text("Criar Novo Destino Rest",
          style: TextStyle(color: Colors.white, fontSize: 15),),
        backgroundColor: Color(0xffb667978),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 15)),
            Text("Criar Novo Destino Rest",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffb667978), ),),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  labelText: "Guid",
                  labelStyle: TextStyle(color: Color(0xffb667978), fontSize: 14),
                  hintText: "digite o guid do destino Rest"
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
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  labelText: "Nome",
                  labelStyle: TextStyle(color: Color(0xffb667978), fontSize: 14),
                  hintText: "digite o nome do destino Rest"
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
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  labelText: "Método",
                  labelStyle: TextStyle(color: Color(0xffb667978), fontSize: 14),
                  hintText: "digite o método do destino Rest"
              ),
              style: TextStyle(fontSize: 14),
              controller: this._methodController,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  labelText: "URI do Serviço",
                  labelStyle: TextStyle(color: Color(0xffb667978), fontSize: 14),
                  hintText: "digite a URI do serviço do destino Rest"
              ),
              style: TextStyle(fontSize: 14),
              controller: this._serviceURIController,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  labelText: "Nome de Usuário do Serviço",
                  labelStyle: TextStyle(color: Color(0xffb667978), fontSize: 14),
                  hintText: "digite o nome de usuário do serviço do destino Rest"
              ),
              style: TextStyle(fontSize: 14),
              controller: this._serviceUsernameController,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  labelText: "Senha de Usuário do Serviço",
                  labelStyle: TextStyle(color: Color(0xffb667978), fontSize: 14),
                  hintText: "digite a senha de usuário do serviço do destino Rest"
              ),
              style: TextStyle(fontSize: 14),
              controller: this._servicePasswordController,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  labelText: "Tipo do Destino Rest",
                  labelStyle: TextStyle(color: Color(0xffb667978), fontSize: 14),
                  hintText: "digite o tipo do destino Rest"
              ),
              style: TextStyle(fontSize: 14),
              controller: this._typeController,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10,1,10,1),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb667978), width: 2),
                  ),
                  labelText: "Corpo da Mensagem",
                  labelStyle: TextStyle(color: Color(0xffb667978), fontSize: 14),
                  hintText: "digite o corpo da mensagem"
              ),
              style: TextStyle(fontSize: 14),
              controller: this._bodyController,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            RaisedButton.icon(
                onPressed: _createRestDestination,
                padding: EdgeInsets.fromLTRB(25,10,25,10),
                color: Color(0xffb667978),
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
