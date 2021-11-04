import 'package:flutter/material.dart';
import 'package:konker_app/models/RestDestination.dart';
import 'package:konker_app/pages/AddDevice.dart';
import 'package:konker_app/pages/AddGateway.dart';
import 'package:konker_app/pages/AddRestDestination.dart';
import 'package:konker_app/pages/Dashboard.dart';
import 'package:konker_app/pages/Devices.dart';
import 'package:konker_app/pages/DevicesEvents.dart';
import 'package:konker_app/pages/Gateways.dart';
import 'package:konker_app/pages/Login.dart';
import 'package:konker_app/pages/Profile.dart';
import 'package:konker_app/pages/EventRoutes.dart';
import 'package:konker_app/pages/RestDestinations.dart';

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
        "/routes": (_) => EventRoutesPage(),
        "/profile": (_) => ProfilePage(),
        "/gateways": (_) => GatewayPage(),
        "/rest-destinations": (_) => RestDestinationsPage(),
        "/new-device": (_) => AddDevicePage(),
        "/new-gateway": (_) => AddGatewayPage(),
        "/new-rest-destination": (_) => AddRestDestinationPage(),
        "/new-event-route": (_) => AddRestDestinationPage(),
      },
    );
  }
}
