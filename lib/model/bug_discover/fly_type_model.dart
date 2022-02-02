class FlyTypeModel {
  final int id;
  final String name;

  FlyTypeModel({
    required this.id,
    required this.name,
  });

  factory FlyTypeModel.fromJson(Map<String, dynamic> jsonData) {
    return FlyTypeModel(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
}
