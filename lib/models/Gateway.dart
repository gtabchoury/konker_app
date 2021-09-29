class Gateway {
  String name;
  String? description;
  String? locationName;
  bool active;
  String? guid;

  Gateway({
      required this.name,
      this.description,
      this.locationName,
      required this.active,
      this.guid,
  });


  factory Gateway.fromJson(Map<String, dynamic> parsedJson){
    return Gateway(
        name: parsedJson['name'],
        description: parsedJson ['description'] ?? null,
        active: parsedJson ['active'] ?? false,
        guid: parsedJson ['guid'] ?? null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'description': description,
        'locationName': locationName,
        'active': active,
      };
}