class ProjectModels {
  final int id;
  final String name;
  final int status;
  final String startDate;
  final String endDate;
  final String creationDate;
  final String cost;
  final int numberOfTeams;
  final int numberOfSectorSupervisors;
  final int numberOfControlSpecialist;
  final int numberOfEmployees;
  final List<TrackVehiclesModel> trackVehicles;
  final ProjectCitiesModel projectCities;

  ProjectModels({
    required this.id,
    required this.name,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.creationDate,
    required this.cost,
    required this.numberOfTeams,
    required this.numberOfSectorSupervisors,
    required this.numberOfControlSpecialist,
    required this.numberOfEmployees,
    required this.trackVehicles,
    required this.projectCities,
  });

  factory ProjectModels.fromJson(Map<String, dynamic> jsonData) {
    return ProjectModels(
      id: jsonData['id'] ?? 0,
      name: jsonData['name'] ?? '',
      status: jsonData['status'] ?? 0,
      cost: jsonData['cost'] ?? '',
      startDate: jsonData['startDate'] ?? '',
      endDate: jsonData['endDate'] ?? '',
      creationDate: jsonData['creationDate'] ?? '',
      numberOfTeams: jsonData['numberOfTeams'] ?? 0,
      numberOfSectorSupervisors: jsonData['numberOfSectorSupervisors'] ?? 0,
      numberOfControlSpecialist: jsonData['numberOfControlSpecialist'] ?? 0,
      numberOfEmployees: jsonData['numberOfEmployees'] ?? 0,
      trackVehicles: jsonData['trackVehicles'] != null
          ? (jsonData['trackVehicles'] as List)
              .map((i) => TrackVehiclesModel.fromJson(i))
              .toList()
          : [],
      projectCities: ProjectCitiesModel.fromJson(jsonData['projectCity']),
    );
  }
}

class TrackVehiclesModel {
  final int id;
  final String name;
  final int count;

  TrackVehiclesModel({
    required this.id,
    required this.name,
    required this.count,
  });

  factory TrackVehiclesModel.fromJson(Map<String, dynamic> jsonData) {
    return TrackVehiclesModel(
      id: jsonData['id'] ?? 0,
      name: jsonData['name'] ?? '',
      count: jsonData['count'] ?? 0,
    );
  }
}

class ProjectCitiesModel {
  final int projectId;
  final int cityId;
  final CityModel city;
  ProjectCitiesModel({
    required this.projectId,
    required this.cityId,
    required this.city,
  });

  factory ProjectCitiesModel.fromJson(Map<String, dynamic> jsonData) {
    return ProjectCitiesModel(
      projectId: jsonData['projectId'] ?? 0,
      cityId: jsonData['cityId'] ?? 0,
      city: CityModel.fromJson(jsonData['city']),
    );
  }
}

class CityModel {
  final int id;
  final String name;
  final String code;

  CityModel({
    required this.id,
    required this.name,
    required this.code,
  });

  factory CityModel.fromJson(Map<String, dynamic> jsonData) {
    return CityModel(
      id: jsonData['id'] ?? 0,
      name: jsonData['name'] ?? "",
      code: jsonData['code'] ?? "",
    );
  }
}

