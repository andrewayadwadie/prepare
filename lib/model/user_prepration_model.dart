class UserPreprationModel {
  final int numberOfEmployees;
 // final int numberOfTools;
  final int numberOfVehicles;
  final int numberOfDevices;
  final int quantityOfExterminator;

  UserPreprationModel({
    required this.numberOfEmployees,
  //  required this.numberOfTools,
    required this.numberOfVehicles,
    required this.numberOfDevices,
    required this.quantityOfExterminator,
  });

  factory UserPreprationModel.fromJson(Map<String, dynamic> jsonData) {
    return UserPreprationModel(
      numberOfEmployees: jsonData['numberOfEmployees'],
  //    numberOfTools: jsonData['numberOfTools'],
      numberOfVehicles: jsonData['numberOfVehicles'],
      numberOfDevices: jsonData['numberOfDevices'],
      quantityOfExterminator: jsonData['quantityOfExterminator'],
    );
  }
}
