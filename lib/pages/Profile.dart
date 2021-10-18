import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/User.dart';
import 'package:konker_app/services/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    TextEditingController _emailController = new TextEditingController();
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _phoneController = new TextEditingController();

    User _user;
    String _token = "";

    List<DataRow> _rows = <DataRow>[];

    Future<void> _saveProfile() async{
      try{
        await UserService.updateProfile(_emailController.text, _nameController.text, _phoneController.text, _token);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Perfil atualizado com sucesso!"),
          backgroundColor: Colors.green,
        ));

        Navigator.popAndPushNamed(context,'/profile');
      } on Exception catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      }
    }

    Future<bool> loadProfile() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      _token = prefs.getString("token")!;

      _user = await UserService.getUserDetails(prefs.getString("email")!, _token);

      _emailController.text = _user.email;
      _nameController.text = _user.name;
      _phoneController.text = _user.phone;

      return true;
    }

    return FutureBuilder<bool>(
        future: loadProfile(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xffb051435),
                  title: Text("Conta e Perfil",
                    style: TextStyle(color: Colors.white, fontSize: 15),),
                ),
                body: Container(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Conta", style: TextStyle(fontSize: 22),),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        TextField(
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1),
                            ),
                            labelText: "E-mail",
                            labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          controller: _emailController,
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffb062c61), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffb062c61), width: 1),
                            ),
                            labelText: "Nome",
                            labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          style: TextStyle(fontSize: 16, color: Color(0xffb062c61)),
                          controller: _nameController,
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffb062c61), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffb062c61), width: 1),
                              ),
                              labelText: "Telefone",
                              labelStyle: TextStyle(color: Colors.black, fontSize: 18)
                          ),
                          style: TextStyle(fontSize: 16, color: Color(0xffb062c61)),
                          controller: _phoneController,
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        RaisedButton.icon(
                            onPressed: (){
                              _saveProfile();
                            },
                            padding: EdgeInsets.fromLTRB(15,10,15,10),
                            color: Color(0xffb062c61),
                            textColor: Colors.white,
                            icon: Icon(Icons.save),
                            label: Text("Salvar alterações", style: TextStyle(fontSize: 16),)
                        ),
                      ],)),
                )
            );
          } else {
            return MyLoading(color: Color(0xffb051435),);
          }
        }
    );
  }
}


