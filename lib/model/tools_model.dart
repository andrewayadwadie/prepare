class ToolsModel {
  final int id;
  final String name;
  final String uses;
  final String countryName;

  ToolsModel({
    required this.id,
    required this.name,
    required this.uses,
    required this.countryName,
  });

  factory ToolsModel.fromJson(Map<String, dynamic> jsonData) {
    return ToolsModel(
      id: jsonData['id'],
      name: jsonData['name'],
      uses: jsonData['uses'],
      countryName: jsonData['countryName'],
    );
  }
}
