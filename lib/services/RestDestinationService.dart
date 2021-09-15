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
}