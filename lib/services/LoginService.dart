import 'dart:convert';

import 'package:konker_app/models/AuthTokenResponse.dart';
import 'package:http/http.dart' as http;
import 'package:konker_app/models/NewUser.dart';
import 'package:konker_app/utils/Constants.dart';

class LoginService {

  static Future<AuthTokenResponse> login(String username, String password) async{
    String encoded = base64Encode(utf8.encode('$username:$password'));

    var headers = {
      'Authorization': 'Basic $encoded'
    };

    Map<String, String> body = new Map();
    body["grant_type"] = "client_credentials";

    http.Response response = await http.post(
      Uri.parse('${Constants.BASE_API_URL}/oauth/token'),
      headers: headers,
      body: body
    );

    if (response.statusCode == 200) {
      AuthTokenResponse tokenResponse = new AuthTokenResponse.fromJson(jsonDecode(response.body));
      return tokenResponse;
    } else {
      throw Exception("Invalid credentials");
    }
  }

  static Future<bool> createAccount(NewUser newUser) async{
    var headers = {
      'Content-Type': 'application/json'
    };

    var jsonBody = jsonEncode(newUser.toJson());

    http.Response response = await http.post(
        Uri.parse('${Constants.BASE_API_URL}/userSubscription'),
        headers: headers,
        body: jsonBody
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception(response.body.toString());
    }
  }
}