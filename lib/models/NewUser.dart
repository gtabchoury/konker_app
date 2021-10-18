class NewUser {
  String name;
  String company;
  String email;
  String password;
  String jobTitle;
  String phoneNumber;

  NewUser({
      required this.name,
      required this.company,
      required this.email,
      required this.password,
      required this.jobTitle,
      required this.phoneNumber,
    });

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'company': company,
        'email': email,
        'password': password,
        'passwordType': 'PASSWORD',
        'jobTitle': jobTitle,
        'phoneNumber': phoneNumber,
      };
}