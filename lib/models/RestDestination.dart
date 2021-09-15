import 'package:konker_app/models/RestDestination.dart';

class RestDestination {
  String? guid;
  String name;
  String method;
  //HeadersInline
  String serviceURI;
  String? serviceUsername;
  String? servicePassword;
  String type;
  String? body;

  RestDestination({
    this.guid,
    required this.name,
    required this.method,
    //HeadersInline
    required this.serviceURI,
    this.serviceUsername,
    this.servicePassword,
    required this.type,
    this.body,
  });

  factory RestDestination.fromJson(Map<String, dynamic> parsedJson){
    return RestDestination(
        guid: parsedJson['result']['guid']?? null,
        name: parsedJson['result']['name'],
        method: parsedJson['result']['method'],
        //HeadersInline
        serviceURI: parsedJson['result']['serviceURI'],
        serviceUsername: parsedJson['result']['serviceUsername']?? null,
        servicePassword: parsedJson['result']['servicePassword']?? null,
        type: parsedJson['result']['type'],
        body: parsedJson['result']['body']?? null);
  }

}
