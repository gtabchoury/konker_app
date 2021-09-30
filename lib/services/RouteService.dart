import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:konker_app/models/EventRoute.dart';
import 'package:konker_app/utils/Constants.dart';

class RouteService {

  static Future<List<EventRoute>> getAll(String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken'
    };

    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/routes/'),
        headers: headers
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['result'];
      return List<EventRoute>.from(l.map((model)=> EventRoute.fromJson(model)));
    } else {
      throw Exception("Erro ao obter roteadores de eventos");
    }
  }

  static Future<bool> delete(String eventRouteUuid, String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken',
    };

    http.Response response = await http.delete(
      Uri.parse('${Constants.BASE_API_URL}/$applicationName/routes/$eventRouteUuid'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Erro ao remover roteador de evento: "+json.decode(response.body)['error_description']);
    }
  }
}