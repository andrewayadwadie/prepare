class DistrictModel {
  final int id;
  final String name;
  final String lat;
  final String long;

  DistrictModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> jsonData) {
    return DistrictModel(
      id: jsonData['id'],
      name: jsonData['name'],
      lat: jsonData['lat'],
      long: jsonData['long'],
    );
  }
}
