class Device {
  String id;
  String name;
  String? description;
  String? locationName;
  String? deviceModelName;
  bool? active;
  bool? debug;
  String? guid;

    Device({
        required this.id,
        required this.name,
        this.description,
        this.locationName,
        this.deviceModelName,
        this.active,
        this.debug,
        this.guid
  });

  factory Device.fromJson(Map<String, dynamic> parsedJson){
    return Device(
      id: parsedJson['id'],
      name: parsedJson['name'],
      description: parsedJson['description'] ?? null,
      locationName: parsedJson['locationName'] ?? null,
      deviceModelName: parsedJson['deviceModelName'] ?? null,
      active: parsedJson['active'] ?? false,
      debug: parsedJson['debug'] ?? false,
      guid: parsedJson['guid'] ?? null,
    );
  }

}