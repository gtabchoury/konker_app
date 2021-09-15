class EventRoute {
  String name;
  String? description;
  bool active;
  String? guid;

  EventRoute({
      required this.name,
      this.description,
      required this.active,
      this.guid
  });


  factory EventRoute.fromJson(Map<String, dynamic> parsedJson){
    return EventRoute(
      name: parsedJson['name'],
      description: parsedJson ['description'] ?? null,
      active: parsedJson ['active'] ?? false,
      guid: parsedJson ['guid'] ?? null
    );
  }
}