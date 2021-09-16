import 'package:flutter/material.dart';
import 'package:konker_app/pages/Dashboard.dart';
import 'package:konker_app/pages/Devices.dart';
import 'package:konker_app/pages/Gateways.dart';
import 'package:konker_app/pages/Login.dart';
import 'package:konker_app/pages/Profile.dart';
import 'package:konker_app/pages/Routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        "/dashboard": (_) => DashBoardPage(),
        "/login": (_) => LoginPage(),
        "/devices": (_) => DevicesPage(),
        "/routes": (_) => RoutesPage(),
        "/profile": (_) => ProfilePage(),
        "/gateways": (_) => GatewayPage(),
      },
    );
  }
}