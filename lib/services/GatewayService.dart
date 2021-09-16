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
}