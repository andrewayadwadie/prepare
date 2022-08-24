 class PestSideModel{
  final int id;
  final String name;

 // final dynamic country;
 // final dynamic effectiveMaterial;

  PestSideModel({
  //  required this.effectiveMaterial,
    required this.id,
    required this.name,
   // required this.country,
  });

  factory PestSideModel.fromJson(Map<String, dynamic> jsonData) {
    return PestSideModel(
      id: jsonData['id'],
      name: jsonData['name'],
      // country: jsonData['country'],
      // effectiveMaterial: jsonData['effectiveMaterial'],
    );
  }
}
