class FlyNoteModel {
  final int id;
  final String name;

  FlyNoteModel({
    required this.id,
    required this.name,
  });

  factory FlyNoteModel.fromJson(Map<String, dynamic> jsonData) {
    return FlyNoteModel(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
}
