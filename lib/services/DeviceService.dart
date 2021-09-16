import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/utils/Constants.dart';

class DeviceService {

  static Future<List<Device>> getAll(String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken'
    };

    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/devices/'),
        headers: headers
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['result'];
      return List<Device>.from(l.map((model)=> Device.fromJson(model)));
    } else {
      throw Exception("Erro ao obter dispositivos");
    }
  }
}