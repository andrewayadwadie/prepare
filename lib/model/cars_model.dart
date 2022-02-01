class CarsModel {
  final int id;
  final String number;
  final String color;
  final String photo;

  CarsModel({
    required this.id,
    required this.number,
    required this.color,
    required this.photo,
  });

  factory CarsModel.fromJson(Map<String, dynamic> jsonData) {
    return CarsModel(
      id: jsonData['id'],
      number: jsonData['number'],
      color: jsonData['color'],
      photo: jsonData['photo'],
    );
  }
}
