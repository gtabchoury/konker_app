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
        guid: parsedJson['guid']?? null,
        name: parsedJson['name'],
        method: parsedJson['method'],
        //HeadersInline
        serviceURI: parsedJson['serviceURI'],
        serviceUsername: parsedJson['serviceUsername']?? null,
        servicePassword: parsedJson['servicePassword']?? null,
        type: parsedJson['type'],
        body: parsedJson['body']?? null);
  }

}
