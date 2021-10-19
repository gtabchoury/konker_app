import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/RestDestination.dart';
import 'package:konker_app/pages/RestDestinations.dart';
import 'package:konker_app/services/RestDestinationService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditRestDestinationPage extends StatefulWidget {
  String guid;

  EditRestDestinationPage({required this.guid});

  @override
  _EditRestDestinationPageState createState() => _EditRestDestinationPageState();
}

class _EditRestDestinationPageState extends State<EditRestDestinationPage> {

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _methodController = new TextEditingController();
  TextEditingController _serviceURIController = new TextEditingController();
  TextEditingController _serviceUsernameController = new TextEditingController();
  TextEditingController _servicePasswordController = new TextEditingController();
  TextEditingController _typeController = new TextEditingController();
  TextEditingController _bodyController = new TextEditingController();

  bool? debug = false;
  bool? active = false;

  Future<void> _editRestDestination() async {
      try{
        RestDestination restDestination = new RestDestination(
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

        await RestDestinationService.edit(restDestination, widget.guid, "default", token!);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Destino Rest atualizado com sucesso!"),
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

  Future<RestDestination> loadRestDestination() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    RestDestination restDestination = await RestDestinationService.getByGuid(widget.guid, "default", token!);

    _nameController.text = restDestination.name;
    _methodController.text = restDestination.method;
    _serviceURIController.text = restDestination.serviceURI;
    _serviceUsernameController.text = restDestination.serviceUsername!;
    _servicePasswordController.text = restDestination.servicePassword!;
    _typeController.text = restDestination.type;
    _bodyController.text = restDestination.body!;

    setState(() {

    });
    return restDestination;
  }

  @override
  void initState() {
    super.initState();
    loadRestDestination();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Destino Rest",
          style: TextStyle(color: Colors.white, fontSize: 15),),
        backgroundColor: Color(0xffb667978),
      ),
      body: Container(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: 15)),
                Text("Editar Destino Rest",
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
                    onPressed: _editRestDestination,
                    padding: EdgeInsets.fromLTRB(25,10,25,10),
                    color: Color(0xffb667978),
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
