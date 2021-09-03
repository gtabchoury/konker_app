import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/models/AuthTokenResponse.dart';
import 'package:konker_app/models/User.dart';
import 'package:konker_app/services/LoginService.dart';
import 'package:konker_app/services/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _loginController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  Future<void> _executeLogin() async {
    try{
      AuthTokenResponse authToken = await LoginService.login(_loginController.text, _passwordController.text);

      User user = await UserService.getUserDetails(_loginController.text, authToken.access_token);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', authToken.access_token);
      prefs.setString('email', user.email);
      prefs.setString('name', user.name);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login realizado com sucesso!"),
        backgroundColor: Colors.green,
      ));

      Navigator.pushNamed(context, "/dashboard");

    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Credenciais inválidas"),
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
              Text("Welcome to Konker Platform!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.only(bottom: 30)),
              Image.asset("imagens/logo.jpg", height: 200,),
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
                    labelText: "Login",
                    labelStyle: TextStyle(color: Color(0xffb062c61), fontSize: 16),
                    hintText: "enter your e-mail"
                ),
                style: TextStyle(fontSize: 16, color: Color(0xffb062c61)),
                controller: this._loginController,
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
                    labelText: "Password",
                    labelStyle: TextStyle(color: Color(0xffb062c61), fontSize: 16),
                    hintText: "enter your password"
                ),
                style: TextStyle(fontSize: 16, color: Color(0xffb062c61)),
                controller: this._passwordController,
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              Row(children: [
                Text("Forgot password?",
                  style: TextStyle(color: Color(0xffb062c61), fontSize: 15),)
              ], mainAxisAlignment: MainAxisAlignment.end,),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              RaisedButton.icon(
                  onPressed: (){
                    _executeLogin();
                  },
                  padding: EdgeInsets.fromLTRB(40,15,40,15),
                  color: Color(0xffb062c61),
                  textColor: Colors.white,
                  icon: Icon(Icons.lock_outline),
                  label: Text("LOGIN", style: TextStyle(fontSize: 16),)
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              RaisedButton(
                  onPressed: (){},
                  padding: EdgeInsets.fromLTRB(40,15,40,15),
                  color: Colors.white,
                  textColor: Color(0xffb062c61),
                  child: Text("Create Account", style: TextStyle(fontSize: 16),),
              ),
          ]),),
        )
      )
    );
  }
}