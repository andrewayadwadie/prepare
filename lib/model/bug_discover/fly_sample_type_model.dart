class FlySampleTypeModel {
  final int id;
  final String name;

  FlySampleTypeModel({
    required this.id,
    required this.name,
  });

  factory FlySampleTypeModel.fromJson(Map<String, dynamic> jsonData) {
    return FlySampleTypeModel(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
}
