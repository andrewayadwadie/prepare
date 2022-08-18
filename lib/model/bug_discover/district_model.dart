class DistrictModel {
  final int id;
  final String name;

  DistrictModel({
    required this.id,
    required this.name,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> jsonData) {
    return DistrictModel(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
}
