import 'dart:convert';

import 'package:konker_app/models/AuthTokenResponse.dart';
import 'package:http/http.dart' as http;
import 'package:konker_app/models/User.dart';
import 'package:konker_app/utils/Constants.dart';

class UserService {

  static Future<User> getUserDetails(String email, String token) async{
    var headers = {
      'Authorization': 'Bearer $token'
    };

    http.Response response = await http.get(
        Uri.parse('${Constants.BASE_API_URL}/users/$email'),
        headers: headers,
    );

    if (response.statusCode == 200) {
      User user = new User.fromJson(jsonDecode(response.body));
      return user;
    } else {
      throw Exception("User not found");
    }
  }

  static Future<bool> updateProfile(String email, String name, String phone, String token) async{
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.put(
      Uri.parse('${Constants.BASE_API_URL}/users/$email'),
      headers: headers,
      body: jsonEncode(<String, String>{
        "name": name,
        "phone": phone,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.body);
    }
  }

}