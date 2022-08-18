class TaskModel {
  final int routeNumber;
  final int districtId;
  final String districtName;
  final List districtLocations;

  TaskModel({
    required this.routeNumber,
    required this.districtId,
    required this.districtName, 
    required this.districtLocations,
  });

  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      routeNumber: jsonData['routeNumber'],
      districtName: jsonData['districtName'],
      districtLocations: jsonData['districtLocations'],
      districtId: jsonData['districtId'],
    );
  }
}

class DistrictLocationsModel {
  final int id;
  final int routeNumber;
  final int districtId;
  final double lat;
  final double long;
  final String description;

  DistrictLocationsModel({
    required this.id,
    required this.routeNumber,
    required this.districtId,
    required this.lat,
    required this.long,
    required this.description,
  });

  factory DistrictLocationsModel.fromJson(Map<String, dynamic> jsonData) {
    return DistrictLocationsModel(
      id: jsonData['id'],
      routeNumber: jsonData['routeNumber'],
      lat: jsonData['lat'],
      long: jsonData['long'],
      districtId: jsonData['districtId'],
      description: jsonData['description'] ?? "",
    );
  }
}
