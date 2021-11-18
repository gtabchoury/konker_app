import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:konker_app/models/Device.dart';
import 'package:konker_app/utils/Constants.dart';

class DeviceService {
  static Future<List<Device>> getAll(String applicationName,
      String authToken) async {
    var headers = {'Authorization': 'Bearer $authToken'};

    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/devices/'),
        headers: headers);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['result'];
      return List<Device>.from(l.map((model) => Device.fromJson(model)));
    } else {
      throw Exception("Erro ao obter dispositivos");
    }
  }

  static Future<Device> getByGuid(String guid, String applicationName,
      String authToken) async {
    var headers = {'Authorization': 'Bearer $authToken'};

    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/devices/$guid/'),
        headers: headers);

    if (response.statusCode == 200) {
      return Device.fromJson(json.decode(response.body)['result']);
    } else {
      throw Exception("Erro ao obter dispositivo");
    }
  }

  static Future<Device> create(Device device, String applicationName,
      String authToken) async {
    var headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };

    var jsonBody = jsonEncode(device.toJson());

    http.Response response = await http.post(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/devices/'),
        headers: headers,
        body: jsonBody);

    print("BODY: " + response.body);
    print("STATUS: " + response.statusCode.toString());

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Device.fromJson(json.decode(response.body)['result']);
    } else {
      throw Exception("Erro ao cadastrar dispositivo: " + response.body);
    }
  }

  static Future<bool> edit(Device device, String guid, String applicationName,
      String authToken) async {
    var headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };

    var jsonBody = jsonEncode(device.toJson());
    http.Response response = await http.put(
        Uri.parse('${Constants.BASE_API_URL}/$applicationName/devices/$guid/'),
        headers: headers,
        body: jsonBody);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Erro ao atualizar dispositivo: " + response.body);
    }
  }

  static Future<bool> delete(String deviceGuid, String applicationName,
      String authToken) async {
    var headers = {
      'Authorization': 'Bearer $authToken',
    };

    http.Response response = await http.delete(
      Uri.parse(
          '${Constants.BASE_API_URL}/$applicationName/devices/$deviceGuid'),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception("Erro ao remover dispositivo: " + response.body);
    }
  }

  static Future<List<dynamic>> getEvents(String applicationName,
      String authToken, String device, String att, String dateFrom,
      String dateTo) async {
    var headers = {'Authorization': 'Bearer $authToken'};

    if (dateFrom.isNotEmpty)
      dateFrom = " timestamp:>$dateFrom";
    else
      dateFrom = "";

    if (dateTo.isNotEmpty)
      dateTo = " timestamp:<$dateTo";
    else
      dateTo = "";

    http.Response response = await http.get(
        Uri.parse(
            '${Constants
                .BASE_API_URL}/$applicationName/incomingEvents?q=device:$device$dateFrom$dateTo'),
        headers: headers);

    if (response.statusCode == 200) {
      print(response.body);
      List<Map<dynamic, dynamic>> result = [];
      Iterable l = json.decode(response.body)['result'];

      for (final model in l) {
        Map<dynamic, dynamic> event = model["payload"];
        event["timestamp"] = model["timestamp"];
        result.add(event);
      }

      return result;
    } else {
      throw Exception("Erro ao obter eventos do dispositivo");
    }
  }
}
