class InsectExplorationsModel {
  final int id;
  final String street;
  final String temperature;
  final String windSpeed;
  final String humidity;
  final String lat;
  final String long;
  final String image1;
  final String image2;
  final String recommendation;
  final String waving;
  final String ph;
  final String date;
  final String districtName;
  final String cityName;
  final String flyTypeName;
  final String flyNoteName;
  final String flySampleTypeName;

  InsectExplorationsModel({
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.lat,
    required this.long,
    required this.image1,
    required this.image2,
    required this.recommendation,
    required this.waving,
    required this.ph,
    required this.date,
    required this.districtName,
    required this.cityName,
    required this.flyTypeName,
    required this.flyNoteName,
    required this.flySampleTypeName,
    required this.id,
    required this.street,
  });

  factory InsectExplorationsModel.fromJson(Map<String, dynamic> jsonData) {
    return InsectExplorationsModel(
      id: jsonData['id'],
      street: jsonData['street'],
      temperature: jsonData['temperature'],
      windSpeed: jsonData['windSpeed'],
      humidity: jsonData['humidity'],
      lat: jsonData['lat'],
      long: jsonData['long'],
      image1: jsonData['image1'],
      image2: jsonData['image2'],
      recommendation: jsonData['recommendation'],
      waving: jsonData['waving'],
      ph: jsonData['ph'],
      date: jsonData['date'],
      districtName: jsonData['districtName'],
      cityName: jsonData['cityName'],
      flyTypeName: jsonData['flyTypeName'],
      flyNoteName: jsonData['flyNoteName'],
      flySampleTypeName: jsonData['flySampleTypeName'],
    );
  }
}
