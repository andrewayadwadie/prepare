class ProjectModel {
  final int id;
  final String name;
  final String startDate;
  final String endDate;
  final String districtName;
  final String districtLat;
  final String districtLong;
  final String cityName;
  final String cityLat;
  final String cityLong;

  ProjectModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.districtName,
    required this.districtLat,
    required this.districtLong,
    required this.cityName,
    required this.cityLat,
    required this.cityLong,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> jsonData) {
    return ProjectModel(
      id: jsonData['id'],
      name: jsonData['name'],
      cityLat: jsonData['cityLat'],
      cityLong: jsonData['cityLong'],
      districtLat: jsonData['districtLat'],
      cityName: jsonData['cityName'],
      districtLong: jsonData['districtLong'],
      districtName: jsonData['districtName'],
      startDate: jsonData['startDate'],
      endDate: jsonData['endDate'],
    );
  }
}
