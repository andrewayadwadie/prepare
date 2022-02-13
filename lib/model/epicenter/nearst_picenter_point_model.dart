class NearstEpicenterModel {
  final int id;
  final int number;
  final String name;
  final String insectName;
  final String temperature;
  final String lat;
  final String long;
  final String date;
  final String districtName;
  final String cityName;
  final String humidity;
  final String windSpeed;
  final String recommendation;

  NearstEpicenterModel({
    required this.id,
    required this.number,
    required this.name,
    required this.insectName,
    required this.temperature,
    required this.lat,
    required this.long,
    required this.date,
    required this.districtName,
    required this.cityName,
    required this.humidity,
    required this.windSpeed,
    required this.recommendation,
  });

  factory NearstEpicenterModel.fromJson(Map<String, dynamic> jsonData) {
    return NearstEpicenterModel(
      id: jsonData['id'],
      name: jsonData['name'],
      insectName: jsonData['insectName'],
      temperature: jsonData['temperature'],
      lat: jsonData['lat'],
      long: jsonData['long'],
      date: jsonData['date'],
      districtName: jsonData['districtName'],
      cityName: jsonData['cityName'],
      number: jsonData['number'],
      humidity: jsonData['humidity'],
      recommendation: jsonData['recommendation'],
      windSpeed: jsonData['windSpeed'],
    );
  }
}
