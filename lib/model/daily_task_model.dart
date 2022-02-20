class DailyTaskModel {
  final int id;
  final int vehicleId;
  final String speed;
  final String lat;
  final String long;
  final String date;
  final String vehicleNumber;

  DailyTaskModel({
    required this.vehicleId,
    required this.id,
    required this.speed,
    required this.lat,
    required this.long,
    required this.date,
    required this.vehicleNumber,
  });

  factory DailyTaskModel.fromJson(Map<String, dynamic> jsonData) {
    return DailyTaskModel(
      id: jsonData['id'],
      vehicleId: jsonData['vehicleId'],
      speed: jsonData['speed'],
      lat: jsonData['lat'],
      long: jsonData['long'],
      date: jsonData['date'],
      vehicleNumber: jsonData['vehicleNumber'],
    );
  }
}
