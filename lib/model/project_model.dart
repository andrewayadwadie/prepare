class ProjectModel {
  final int id;
  final String name;
  final int status;

  ProjectModel({
    required this.id,
    required this.name,
    required this.status,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> jsonData) {
    return ProjectModel(
      id: jsonData['id'],
      name: jsonData['name'],
      status: jsonData['status'],
    );
  }
}
