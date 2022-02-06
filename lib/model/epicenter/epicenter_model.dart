class EpiCenterModel {
  final int id;
  final String name;
  final String density;
 

  EpiCenterModel({
    required this.id,
    required this.name,
    required this.density,
 
  });

  factory EpiCenterModel.fromJson(Map<String, dynamic> jsonData) {
    return EpiCenterModel(
      id: jsonData['id'],
      name: jsonData['name'],
      density: jsonData['density'],
 
    );
  }
}
