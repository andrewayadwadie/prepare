class UserPreprationModel {
  final int id;
  final int projectId;
  final int numberOfEmployees;
  final int numberOfTools;
  final int numberOfVehicles;
  final int numberOfDevices;
  final int numberOfExterminators;
  final String creationDate;
  final String projectName;

  UserPreprationModel({
    required this.id,
    required this.creationDate,
    required this.projectName,
    required this.projectId,
    required this.numberOfEmployees,
    required this.numberOfTools,
    required this.numberOfVehicles,
    required this.numberOfDevices,
    required this.numberOfExterminators,
  });

  factory UserPreprationModel.fromJson(Map<String, dynamic> jsonData) {
    return UserPreprationModel(
      id: jsonData['id'],
      projectId: jsonData['projectId'],
      numberOfEmployees: jsonData['numberOfEmployees'],
      numberOfTools: jsonData['numberOfTools'],
      numberOfVehicles: jsonData['numberOfVehicles'],
      numberOfDevices: jsonData['numberOfDevices'],
      numberOfExterminators: jsonData['numberOfExterminators'],
      creationDate: jsonData['creationDate'],
      projectName: jsonData['projectName'],
    );
  }
}
