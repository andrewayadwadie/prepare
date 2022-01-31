class ProjectModel {
  final int id;
  final String name;
  final String startDate;
  final String endDate;
  final String cost;
  final List tools;
  final List exterminators;
  final List devices;
  final List vehicles;
  final List teams;
  final List cities;

  ProjectModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.cost,
    required this.tools,
    required this.exterminators,
    required this.devices,
    required this.vehicles,
    required this.teams,
    required this.cities,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> jsonData) {
    return ProjectModel(
      id: jsonData['id'],
      name: jsonData['name'],
      cost: jsonData['cost'],
      startDate: jsonData['startDate'],
      endDate: jsonData['endDate'],
      cities: jsonData['cities'],
      devices: jsonData['devices'],
      exterminators: jsonData['exterminators'],
      teams: jsonData['teams'],
      tools: jsonData['tools'],
      vehicles: jsonData['vehicles'],
    );
  }
}
