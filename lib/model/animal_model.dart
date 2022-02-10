class AnimalModel {
  final int id;
  final String street;
  final String image1;
  final String image2;
  final String lat;
  final String long;
  final String date;
  final String districtName;
  final String cityName;

  AnimalModel({
    required this.id,
    required this.street,
    required this.image1,
    required this.image2,
    required this.lat,
    required this.long,
    required this.date,
    required this.districtName,
    required this.cityName,
  });

  factory AnimalModel.fromJson(Map<String, dynamic> jsonData) {
    return AnimalModel(
      id: jsonData['id'],
      street: jsonData['street'],
      image1: jsonData['image1'],
      image2: jsonData['image2'],
      lat: jsonData['lat'],
      long: jsonData['long'],
      date: jsonData['date'],
      districtName: jsonData['districtName'],
      cityName: jsonData['cityName'],
    );
  }
}
