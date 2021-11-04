import 'package:flutter/material.dart';
import 'package:konker_app/components/MyCard.dart';
import 'package:konker_app/components/MyCardHelp.dart';
import 'package:konker_app/components/MyLoading.dart';
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/models/EventRoute.dart';
import 'package:konker_app/models/Gateway.dart';
import 'package:konker_app/pages/Login.dart';
import 'package:konker_app/services/DeviceService.dart';
import 'package:konker_app/services/GatewayService.dart';
import 'package:konker_app/services/RouteService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DevicesEvents extends StatefulWidget {
  const DevicesEvents({Key? key}) : super(key: key);

  @override
  _DevicesEventsState createState() => _DevicesEventsState();
}

class _DevicesEventsState extends State<DevicesEvents> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
