class EventRoute {

  EventRoute(
      this.name,
      this.description,
      this.active,
      this.guid
  );

  String name;
  String description;
  bool active;
  String guid;

  factory EventRoute.fromJson(Map<String, dynamic> parsedJson){
    return EventRoute(
        parsedJson['name'] ?? "",
        parsedJson ['description'] ?? "",
        parsedJson ['active'] ?? false,
        parsedJson ['guid'] ?? ""
    );
  }
}