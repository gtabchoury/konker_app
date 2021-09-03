class Device {

  Device(
      this.id,
      this.name,
      this.description,
      this.locationName,
      this.deviceModelName,
      this.active,
      this.debug,
      this.guid
  );

  String id;
  String name;
  String description;
  String locationName;
  String deviceModelName;
  bool active;
  bool debug;
  String guid;

  factory Device.fromJson(Map<String, dynamic> parsedJson){
    return Device(
        parsedJson['id'] ?? "",
        parsedJson['name'] ?? "",
        parsedJson ['description'] ?? "",
        parsedJson ['locationName'] ?? "",
        parsedJson ['deviceModelName'] ?? "",
        parsedJson ['active'] ?? false,
        parsedJson ['debug'] ?? false,
        parsedJson ['guid'] ?? ""
    );
  }
}