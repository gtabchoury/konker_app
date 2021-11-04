import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:konker_app/models/EventRoute.dart';
import 'package:konker_app/utils/Constants.dart';

class EventRouteService {

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

  static Future<EventRoute> getByGuid(String guid, String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken'
    };

    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/routes/$guid/'),
        headers: headers
    );

    if (response.statusCode == 200) {
      return EventRoute.fromJson(json.decode(response.body)['result']);
    } else {
      throw Exception("Erro ao obter roteador de Evento");
    }
  }

  static Future<bool> edit(EventRoute eventRoute, String guid, String applicationName,
      String authToken) async {
    var headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };

    var jsonBody = jsonEncode(eventRoute.toJson());
    http.Response response = await http.put(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/routes/$guid/'),
        headers: headers,
        body: jsonBody);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Erro ao atualizar roteador de eventos: " + response.body);
    }
  }

  static Future<EventRoute> create(EventRoute eventRoute, String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };

    var jsonBody = jsonEncode(eventRoute.toJson());

    print(jsonBody);

    http.Response response = await http.post(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/routes/'),
        headers: headers,
        body: jsonBody
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return EventRoute.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao cadastrar roteador de evento: "+json.decode(response.body)['error_description']);
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

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception("Erro ao remover roteador de evento: "+response.body);
    }
  }
}