class AllEpicenterModel {
  final int id;
  final String name;
  final String insectName;
  final String insectDensity;
  final String lat;
  final String long;
  final String date;
  final String districtName;
  final String cityName;

  AllEpicenterModel({
    required this.id,
    required this.name,
    required this.insectName,
    required this.insectDensity,
    required this.lat,
    required this.long,
    required this.date,
    required this.districtName,
    required this.cityName,
  });

  factory AllEpicenterModel.fromJson(Map<String, dynamic> jsonData) {
    return AllEpicenterModel(
      id: jsonData['id'],
      name: jsonData['name'],
      insectName: jsonData['insectName'],
      insectDensity: jsonData['insectDensity'],
      lat: jsonData['lat'],
      long: jsonData['long'],
      date: jsonData['date'],
      districtName: jsonData['districtName'],
      cityName: jsonData['cityName'],
    );
  }
}
