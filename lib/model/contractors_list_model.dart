class ContractorsListModel {
  final int id;
  final int projectId;
  final String name;
  final String projectName;
  final bool isInsideScopeOfWork;
  final List phones;
 

  ContractorsListModel({
    required this.id,
    required this.name,
    required this.phones,
    required this.projectId,
    required this.projectName,
    required this.isInsideScopeOfWork,
  });

  factory ContractorsListModel.fromJson(Map<String, dynamic> jsonData) {
    return ContractorsListModel(
      id: jsonData['id'],
      name: jsonData['name'],
      phones :jsonData['phones'],
      projectId: jsonData['projectId'],
      projectName : jsonData['projectName'],
      isInsideScopeOfWork:jsonData['isInsideScopeOfWork'],
    );
  }
}
