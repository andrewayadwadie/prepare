class CitiesModel {
  final int id;
  final String name;
  // final String lat;
  // final String long;

  CitiesModel({
    required this.id,
    required this.name,
    // required this.lat,
    // required this.long,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> jsonData) {
    return CitiesModel(
      id: jsonData['id'],
      name: jsonData['name'],
      // lat: jsonData['lat'],
      // long: jsonData['long'],
    );
  }
}
