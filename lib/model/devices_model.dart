class DevicesModel {
  final int id;
  final String name;
  final String date;
  final String brand;
  final String countryName;
  final int tankSize;
  DevicesModel({
    required this.countryName,
    required this.tankSize,
    required this.id,
    required this.name,
    required this.date,
    required this.brand,
  });

  factory DevicesModel.fromJson(Map<String, dynamic> jsonData) {
    return DevicesModel(
      id: jsonData['id'],
      name: jsonData['name'],
      date: jsonData['date'],
      brand: jsonData['brand'],
      countryName: jsonData['countryName'],
      tankSize: jsonData['tankSize'],
    );
  }
}
