import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:konker_app/models/Gateway.dart';
import 'package:konker_app/utils/Constants.dart';

class GatewayService {

  static Future<List<Gateway>> getAll(String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken'
    };

    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/gateways/'),
        headers: headers
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['result'];
      return List<Gateway>.from(l.map((model)=> Gateway.fromJson(model)));
    } else {
      throw Exception("Erro ao obter gateways");
    }
  }

  static Future<Gateway> create(Gateway gateway, String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };

    var jsonBody = jsonEncode(gateway.toJson());

    http.Response response = await http.post(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/gateways/'),
        headers: headers,
        body: jsonBody
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Gateway.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao cadastrar gateway: "+json.decode(response.body)['error_description']);
    }
  }

  static Future<bool> delete(String gatewayGuid, String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken',
    };

    http.Response response = await http.delete(
      Uri.parse('${Constants.BASE_API_URL}/$applicationName/gateways/$gatewayGuid'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Erro ao remover gateway: "+json.decode(response.body)['error_description']);
    }
  }
}