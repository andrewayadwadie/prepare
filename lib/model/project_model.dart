class ProjectModel {
  final int id;
  final String name;
  final int status;
  //final List tools;
  final List exterminators;
  final List devices;
  final List vehicles;
  final List teams;

  ProjectModel(
      {required this.id,
      required this.name,
      required this.status,
   //   required this.tools,
      required this.devices,
      required this.exterminators,
      required this.teams,
      required this.vehicles});

  factory ProjectModel.fromJson(Map<String, dynamic> jsonData) {
    return ProjectModel(
      id: jsonData['id'],
      name: jsonData['name'],
      status: jsonData['status'],
   //   tools: jsonData['tools'],
      exterminators: jsonData['exterminators'],
      devices: jsonData['devices'],
      vehicles: jsonData['vehicles'],
      teams: jsonData['teams'],
    );
  }
}
