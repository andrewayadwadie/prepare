class PestSideModel {
  final int id;
  final String name;
  final String uses;
  final dynamic country;
  final dynamic effectiveMaterial;

  PestSideModel({
    required this.effectiveMaterial,
    required this.id,
    required this.name,
    required this.uses,
    required this.country,
  });

  factory PestSideModel.fromJson(Map<String, dynamic> jsonData) {
    return PestSideModel(
      id: jsonData['id'],
      name: jsonData['name'],
      uses: jsonData['uses'],
      country: jsonData['country'],
      effectiveMaterial: jsonData['effectiveMaterial'],
    );
  }
}
