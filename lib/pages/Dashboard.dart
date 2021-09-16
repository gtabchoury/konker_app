import 'package:flutter/material.dart';
import 'package:konker_app/components/MyCard.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/models/EventRoute.dart';
import 'package:konker_app/models/Gateway.dart';
import 'package:konker_app/pages/Login.dart';
import 'package:konker_app/services/DeviceService.dart';
import 'package:konker_app/services/GatewayService.dart';
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
    String _userEmail = "";

    int _totalDevices = 0;
    int _totalRoutes = 0;
    int _totalGateways = 0;

    Future<void> _logout() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("token");
      prefs.remove("email");
      prefs.remove("name");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
      );
    }

    Future<String> loadUser() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      _userName = prefs.getString("name")!;
      _userEmail = prefs.getString("email")!;

      String? token = prefs.getString("token");

      if (token!=null){
        try{
          List<Device> devices = await DeviceService.getAll("default", token);
          List<EventRoute> routes = await RouteService.getAll("default", token);
          List<Gateway> gateways = await GatewayService.getAll("default", token);

          _totalDevices = devices.length;
          _totalRoutes = routes.length;
          _totalGateways = gateways.length;

        } on Exception catch (_) {
          _logout();
        }
      }else{
        _logout();
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
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xffb051435),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Konker', style: TextStyle(color: Colors.white, fontSize: 20)),
                          Padding(padding: EdgeInsets.only(top: 80)),
                          Text('$_userEmail', style: TextStyle(color: Colors.white, fontSize: 15))
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(children: [
                        Icon(Icons.account_circle),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text("Conta e Perfil")
                      ],),
                      onTap: () {
                        Navigator.pushNamed(context, "/profile");
                      },
                    ),ListTile(
                      title: Row(children: [
                        Icon(Icons.logout),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text("Sair")
                      ],),
                      onTap: () {
                        _logout();
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
                height: 450,
                width: 450,
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
                            icon: Icon(Icons.alt_route, size: 40, color: Colors.white),
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
                        GestureDetector(
                          child: MyCard(
                            icon: Icon(Icons.router, size: 40, color: Colors.white),
                            color: Color(0xffbe54182),
                            title: "GATEWAYS",
                            count: _totalGateways,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/gateways");
                          },
                        ),
                        MyCard(
                          icon: Icon(Icons.vpn_lock, size: 40, color: Colors.white),
                          color: Color(0xffb667978),
                          title: "DESTINOS REST",
                          count: 2,
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
