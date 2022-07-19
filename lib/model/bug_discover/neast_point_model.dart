class NearstBugDiscoverPointModel {
  final int id;
  final String street;
  final String image1;
  final String image2;
  final String temperature;
  final String lat;
  final String long;
  final String date;
  final String districtName;
  final String cityName;
  final String humidity;
  final String windSpeed;
  final String recommendation;
  final String waving;
  final String ph;
  final String flyTypeName;
  final String flyNoteName;
  final String flySampleTypeName;
  final String code;
  final int type;

  NearstBugDiscoverPointModel(
      {required this.id,
      required this.type,
      required this.street,
      required this.image1,
      required this.image2,
      required this.temperature,
      required this.lat,
      required this.long,
      required this.date,
      required this.districtName,
      required this.cityName,
      required this.humidity,
      required this.windSpeed,
      required this.recommendation,
      required this.waving,
      required this.ph,
      required this.flyTypeName,
      required this.flyNoteName,
      required this.flySampleTypeName,
      required this.code});

  factory NearstBugDiscoverPointModel.fromJson(Map<String, dynamic> jsonData) {
    return NearstBugDiscoverPointModel(
        id: jsonData['id'],
        image1: jsonData['image1'],
        image2: jsonData['image2'],
        temperature: jsonData['temperature'],
        lat: jsonData['lat'],
        long: jsonData['long'],
        date: jsonData['date'],
        districtName: jsonData['districtName'],
        cityName: jsonData['cityName'],
        street: jsonData['street'],
        humidity: jsonData['humidity'],
        recommendation: jsonData['recommendation'],
        windSpeed: jsonData['windSpeed'],
        waving: jsonData['waving'],
        ph: jsonData['ph'],
        flyTypeName: jsonData['flyTypeName'],
        flyNoteName: jsonData['flyNoteName'],
        flySampleTypeName: jsonData['flySampleTypeName'],
        code: jsonData['code'],
        type: 0
        );
  }
}
