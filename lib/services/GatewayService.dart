import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:konker_app/models/Gateway.dart';
import 'package:konker_app/utils/Constants.dart';

class GatewayService {
  static Future<List<Gateway>> getAll(
      String applicationName, String authToken) async {
    var headers = {'Authorization': 'Bearer $authToken'};

    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/gateways/'),
        headers: headers);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['result'];
      return List<Gateway>.from(l.map((model) => Gateway.fromJson(model)));
    } else {
      throw Exception("Erro ao obter gateways");
    }
  }

  static Future<Gateway> create(
      Gateway gateway, String applicationName, String authToken) async {
    var headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };

    var jsonBody = jsonEncode(gateway.toJson());

    http.Response response = await http.post(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/gateways/'),
        headers: headers,
        body: jsonBody);

    print("BODY: " + response.body);
    print("STATUS: " + response.statusCode.toString());

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Gateway.fromJson(json.decode(response.body)['result']);
    } else {
      throw Exception("Erro ao cadastrar gateway: " + response.body);
    }
  }

  static Future<bool> delete(
      String gatewayGuid, String applicationName, String authToken) async {
    var headers = {
      'Authorization': 'Bearer $authToken',
    };

    http.Response response = await http.delete(
      Uri.parse(
          '${Constants.BASE_API_URL}/$applicationName/gateways/$gatewayGuid'),
      headers: headers,
    );

    print("BODY: " + response.body);
    print("STATUS: " + response.statusCode.toString());

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception("Erro ao remover gateway: " + response.body);
    }
  }

  static Future<bool> edit(Gateway gateway, String guid, String applicationName,
      String authToken) async {
    var headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };

    var jsonBody = jsonEncode(gateway.toJson());
    http.Response response = await http.put(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/gateways/$guid/'),
        headers: headers,
        body: jsonBody);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Erro ao atualizar dispositivo: " + response.body);
    }
  }

  static Future<Gateway> getByGuid(
      String guid, String applicationName, String authToken) async {
    var headers = {'Authorization': 'Bearer $authToken'};

    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/gateways/$guid/'),
        headers: headers);

    if (response.statusCode == 200) {
      return Gateway.fromJson(json.decode(response.body)['result']);
    } else {
      throw Exception("Erro ao obter dispositivo");
    }
  }
}
