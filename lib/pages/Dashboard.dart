import 'package:flutter/material.dart';
import 'package:konker_app/components/MyCard.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/models/EventRoute.dart';
import 'package:konker_app/services/DeviceService.dart';
import 'package:konker_app/services/RouteService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  @override
  Widget build(BuildContext context) {

    String _userName = "Usuário";

    int _totalDevices = 0;
    int _totalRoutes = 0;

    Future<String> loadUser() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      _userName = prefs.getString("name")!;

      String? token = prefs.getString("token");

      if (token!=null){
        List<Device> devices = await DeviceService.getAll("default", token);
        List<EventRoute> routes = await RouteService.getAll("default", token);

        _totalDevices = devices.length;
        _totalRoutes = routes.length;
      }

      return _userName;
    }

    return FutureBuilder<String>(
        future: loadUser(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              drawer: Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xffb051435),
                      ),
                      child: Text('Konker', style: TextStyle(color: Colors.white, fontSize: 20),),
                    ),
                    ListTile(
                      title: Row(children: [
                        Icon(Icons.logout),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text("Logout")
                      ],),
                      onTap: () {
                        Navigator.pushNamed(context, "/login");
                      },
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                backgroundColor: Color(0xffb051435),
                title: Text("Olá, $_userName",
                  style: TextStyle(color: Colors.white, fontSize: 15),),
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(40,50,40,50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: MyCard(
                              icon: Icon(Icons.devices, size: 40, color: Colors.white),
                              color: Color(0xffb00a69c),
                              title: "DISPOSITIVOS",
                              count: _totalDevices,
                            ),
                          onTap: () {
                            Navigator.pushNamed(context, "/devices");
                          },
                        ),
                        GestureDetector(
                          child: MyCard(
                            icon: Icon(Icons.account_balance, size: 40, color: Colors.white),
                            color: Color(0xffbfbaf41),
                            title: "ROTEADOR DE EVENTOS",
                            count: _totalRoutes,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/routes");
                          },
                        )
                      ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyCard(
                          icon: Icon(Icons.login, size: 40, color: Colors.white),
                          color: Color(0xffbe54182),
                          title: "TRANSFORMAÇÕES",
                          count: 0,
                        ),
                        GestureDetector(
                          child: MyCard(
                            icon: Icon(Icons.account_balance, size: 40, color: Colors.white),
                            color: Color(0xffbfbaf41),
                            title: "DESTINOS REST",
                            count: _totalRoutes,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/restDestinations");
                          },
                        )
                      ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyCard(
                          icon: Icon(Icons.add_a_photo, size: 40, color: Colors.white,),
                          color: Color(0xffbadc9d4),
                          title: "MENSAGENS DE DEBUG",
                          count: 0,
                        ),
                        MyCard(
                          icon: Icon(Icons.airplanemode_on, size: 40, color: Colors.white),
                          color: Color(0xffbadc9d4),
                          title: "API TOKENS",
                          count: 3,
                        )
                      ],),
                  ],
                ),
              ),
            );
          } else {
            return MyLoading();
          }
        }
    );
  }
}
