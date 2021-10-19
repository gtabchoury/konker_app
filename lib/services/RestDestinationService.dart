import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:konker_app/models/RestDestination.dart';
import 'package:konker_app/utils/Constants.dart';

class RestDestinationService {

  static Future<List<RestDestination>> getAll(String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken'
    };

    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/restDestinations/'),
        headers: headers
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['result'];
      return List<RestDestination>.from(l.map((model)=> RestDestination.fromJson(model)));
    } else {
      throw Exception("Erro ao obter destinos Rest");
    }
  }

  static Future<RestDestination> getByGuid(String guid, String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken'
    };

    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/restDestinations/$guid/'),
        headers: headers
    );

    if (response.statusCode == 200) {
      return RestDestination.fromJson(json.decode(response.body)['result']);
    } else {
      throw Exception("Erro ao obter destino Rest");
    }
  }

  static Future<RestDestination> create(RestDestination restDestination, String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };

    var jsonBody = jsonEncode(restDestination.toJson());

    print(jsonBody);

    http.Response response = await http.post(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/restDestinations/'),
        headers: headers,
        body: jsonBody
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return RestDestination.fromJson(json.decode(response.body)['result']);
    } else {
      throw Exception("Erro ao cadastrar destino Rest: "+response.body);
    }
  }

  static Future<bool> edit(RestDestination restDestination, String guid, String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };

    var jsonBody = jsonEncode(restDestination.toJson());
    http.Response response = await http.put(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/restDestinations/$guid/'),
        headers: headers,
        body: jsonBody
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Erro ao atualizar destino Rest: "+response.body);
    }
  }

  static Future<bool> delete(String restDestinationGuid, String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken',
    };

    http.Response response = await http.delete(
      Uri.parse('${Constants.BASE_API_URL}/$applicationName/restDestinations/$restDestinationGuid'),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception("Erro ao remover destino Rest: "+response.body);
    }
  }

}