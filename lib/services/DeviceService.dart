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

  static Future<Device> create(Device device, String applicationName, String authToken) async{
    var headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };

    var jsonBody = jsonEncode(device.toJson());

    print(jsonBody);

    http.Response response = await http.post(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/devices/'),
        headers: headers,
        body: jsonBody
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Device.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao cadastrar dispositivo: "+json.decode(response.body)['error_description']);
    }
  }
}