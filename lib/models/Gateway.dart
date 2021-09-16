class Gateway {
  String name;
  String? description;
  bool active;
  String? guid;

  Gateway({
      required this.name,
      this.description,
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
}