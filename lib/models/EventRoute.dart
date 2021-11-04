class EventRoute {
  String name;
  String? description;
  bool? active;
  String? guid;
  String? incomingType;
  String? outgoingType;

  EventRoute({
      required this.name,
      this.description,
      required this.active,
      this.guid,
      this.incomingType,
      this.outgoingType
  });


  factory EventRoute.fromJson(Map<String, dynamic> parsedJson){
    return EventRoute(
        name: parsedJson['name'],
        description: parsedJson ['description'] ?? null,
        active: parsedJson ['active'] ?? false,
        guid: parsedJson ['guid'] ?? null,
        incomingType: parsedJson ['incoming']['type'] ?? null,
        outgoingType: parsedJson ['outgoing']['type'] ?? null
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'description': description,
        'active': active,
        'guid': guid,
        'incoming': { 'type': incomingType },
        'outgoing': { 'type': outgoingType },
      };
}
