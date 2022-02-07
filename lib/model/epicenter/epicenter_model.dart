class EpiCenterModel {
  final int id;
  final String name;
  final String code;
 

  EpiCenterModel({
    required this.id,
    required this.name,
    required this.code,
 
  });

  factory EpiCenterModel.fromJson(Map<String, dynamic> jsonData) {
    return EpiCenterModel(
      id: jsonData['id'],
      name: jsonData['name'],
      code: jsonData['code'],
 
    );
  }
}
