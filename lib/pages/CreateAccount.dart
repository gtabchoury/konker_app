import 'dart:collection';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:konker_app/models/AuthTokenResponse.dart';
import 'package:konker_app/models/NewUser.dart';
import 'package:konker_app/models/User.dart';
import 'package:konker_app/pages/Dashboard.dart';
import 'package:konker_app/pages/Login.dart';
import 'package:konker_app/services/LoginService.dart';
import 'package:konker_app/services/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({ Key? key }) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();
  TextEditingController _companyController = new TextEditingController();
  TextEditingController _jobTitleController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _executeCreateAccount() async {
    try{

      String error = "";

      if (_confirmPasswordController.text.isEmpty){
        error = "Confirmação da Senha é obrigatório";
      }

      if (_passwordController.text.isEmpty){
        error = "Senha é obrigatória";
      }

      if (_emailController.text.isEmpty){
        error = "E-mail é obrigatório";
      }

      if (_nameController.text.isEmpty){
        error = "Nome é obrigatório";
      }

      if (_passwordController.text != _confirmPasswordController.text){
        error = "Senhas não coincidem";
      }

      if (error != ""){
        await confirm(
          context,
          title: Text("Erro ao criar conta"),
          content: Text(error),
          textOK: Text('Ok'),
        );

        return;
      }

      NewUser newUser = new NewUser(
          name: _nameController.text,
          company: _companyController.text,
          email: _emailController.text,
          password: _passwordController.text,
          jobTitle: _jobTitleController.text,
          phoneNumber: _phoneNumberController.text);

      await LoginService.createAccount(newUser);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Conta criada com sucesso!"),
        backgroundColor: Colors.green,
      ));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
      );

    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erro ao criar conta: "+_.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
            child: Column(children: [
              Text("Crie sua conta!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.only(bottom: 30)),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    labelText: "Nome",
                    labelStyle: TextStyle(color: Color(0xffb062c61), fontSize: 16),
                    hintText: "digite seu nome"
                ),
                style: TextStyle(fontSize: 16, color: Color(0xffb062c61)),
                controller: this._nameController,
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    labelText: "E-mail",
                    labelStyle: TextStyle(color: Color(0xffb062c61), fontSize: 16),
                    hintText: "digite seu e-mail"
                ),
                style: TextStyle(fontSize: 16, color: Color(0xffb062c61)),
                controller: this._emailController,
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Color(0xffb062c61), fontSize: 16),
                    hintText: "Digite sua senha"
                ),
                style: TextStyle(fontSize: 16, color: Color(0xffb062c61)),
                controller: this._passwordController,
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    labelText: "Confirme sua senha",
                    labelStyle: TextStyle(color: Color(0xffb062c61), fontSize: 16),
                    hintText: "digite sua senha novamente"
                ),
                style: TextStyle(fontSize: 16, color: Color(0xffb062c61)),
                controller: this._confirmPasswordController,
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    labelText: "Empresa",
                    labelStyle: TextStyle(color: Color(0xffb062c61), fontSize: 16),
                    hintText: "digite o nome da sua empresa"
                ),
                style: TextStyle(fontSize: 16, color: Color(0xffb062c61)),
                controller: this._companyController,
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    labelText: "Cargo",
                    labelStyle: TextStyle(color: Color(0xffb062c61), fontSize: 16),
                    hintText: "digite seu cargo"
                ),
                style: TextStyle(fontSize: 16, color: Color(0xffb062c61)),
                controller: this._jobTitleController,
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffb062c61), width: 2),
                    ),
                    labelText: "Telefone",
                    labelStyle: TextStyle(color: Color(0xffb062c61), fontSize: 16),
                    hintText: "digite seu telefone"
                ),
                style: TextStyle(fontSize: 16, color: Color(0xffb062c61)),
                controller: this._phoneNumberController,
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              RaisedButton.icon(
                  onPressed: (){
                    _executeCreateAccount();
                  },
                  padding: EdgeInsets.fromLTRB(40,15,40,15),
                  color: Color(0xffb062c61),
                  textColor: Colors.white,
                  icon: Icon(Icons.lock_outline),
                  label: Text("CRIAR CONTA", style: TextStyle(fontSize: 16),)
              ),
          ]),),
        )
      )
    );
  }
}