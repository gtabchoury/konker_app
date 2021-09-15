import 'package:flutter/material.dart';
import 'package:konker_app/pages/Dashboard.dart';
import 'package:konker_app/pages/Login.dart';

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
        "/dashboard": (_) => new DashBoardPage(),
        "/login": (_) => LoginPage(),
        "/devices": (_) => DevicesPage(),
      },
    );
  }
}