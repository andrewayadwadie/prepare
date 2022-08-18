class FlyTypeModel {
  final int id;
  final String name;
  final String code;
  FlyTypeModel({
    required this.id,
    required this.name,
    required this.code
  });

  factory FlyTypeModel.fromJson(Map<String, dynamic> jsonData) {
    return FlyTypeModel(
      id: jsonData['id'],
      name: jsonData['name'],
      code: jsonData['code'],
    );
  }
}
