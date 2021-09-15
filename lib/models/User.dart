class User {
    String phone;
  String name;
  String email;

    User({
      required this.phone,
      required this.name,
      required this.email,
    });

  factory User.fromJson(Map<String, dynamic> parsedJson){
    return User(
        phone: parsedJson['result']['phone'],
        name : parsedJson['result']['name'],
        email : parsedJson['result']['email']
    );
  }
}