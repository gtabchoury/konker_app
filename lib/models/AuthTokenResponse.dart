class AuthTokenResponse {

  AuthTokenResponse({
    required this.access_token,
    required this.token_type,
    required this.expires_in,
  });

  String access_token;
  String token_type;
  int expires_in;

  factory AuthTokenResponse.fromJson(Map<String, dynamic> parsedJson){
    return AuthTokenResponse(
        access_token: parsedJson['access_token'],
        token_type : parsedJson['token_type'],
        expires_in : parsedJson ['expires_in']
    );
  }
}