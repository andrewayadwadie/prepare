class ProjectModel {
  final int id;
  final String name;
  final int status;

  final ProjectCity projectCity;

  ProjectModel({
    required this.id,
    required this.name,
    required this.status,
    required this.projectCity,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> jsonData) {
    return ProjectModel(
      id: jsonData['id'] ?? 0,
      name: jsonData['name'] ?? '',
      status: jsonData['status'] ?? 0,
      projectCity: ProjectCity.fromJson(jsonData['projectCity']),
    );
  }
}

class ProjectCity {
  final int projectId;
  final int cityId;
  final City city;
  final List<ProjectCityTasks> projectCityTasks;
  ProjectCity({
    required this.projectId,
    required this.cityId,
    required this.city,
    required this.projectCityTasks,
  });

  factory ProjectCity.fromJson(Map<String, dynamic> jsonData) {
    return ProjectCity(
      projectId: jsonData['projectId'] ?? 0,
      cityId: jsonData['cityId'] ?? 0,
      city: City.fromJson(
        jsonData['city'],
      ),
      projectCityTasks: jsonData['projectCityTasks'] != null
          ? (jsonData['projectCityTasks'] as List)
              .map((i) => ProjectCityTasks.fromJson(i))
              .toList()
          : [],
    );
  }
}

class City {
  final int id;
  final String name;
  final String code;
  City({
    required this.id,
    required this.name,
    required this.code,
  });

  factory City.fromJson(Map<String, dynamic> jsonData) {
    return City(
      id: jsonData['id'] ?? 0,
      name: jsonData['name'] ?? "",
      code: jsonData['code'] ?? "",
    );
  }
}

class ProjectCityTasks {
  final int id;
  final String day;
  final int numberOfTeams;
  final List<ProjectTrackVehicleTypesTasks> projectTrackVehicleTypesTasks;
  ProjectCityTasks({
    required this.id,
    required this.day,
    required this.numberOfTeams,
    required this.projectTrackVehicleTypesTasks,
  });

  factory ProjectCityTasks.fromJson(Map<String, dynamic> jsonData) {
    return ProjectCityTasks(
      id: jsonData['id'] ?? 0,
      day: jsonData['day'] ?? "",
      numberOfTeams: jsonData['numberOfTeams'] ?? 0,
      projectTrackVehicleTypesTasks:
          jsonData['projectTrackVehicleTypesTasks'] != null
              ? (jsonData['projectTrackVehicleTypesTasks'] as List)
                  .map((i) => ProjectTrackVehicleTypesTasks.fromJson(i))
                  .toList()
              : [],
    );
  }
}

class ProjectTrackVehicleTypesTasks {
  final int id;
  final int trackVehicleTypeId;
  final int count;
  final int projectCityTaskId;
  final TrackVehicleType trackVehicleType;
  ProjectTrackVehicleTypesTasks({
    required this.id,
    required this.trackVehicleTypeId,
    required this.count,
    required this.projectCityTaskId,
    required this.trackVehicleType,
  });

  factory ProjectTrackVehicleTypesTasks.fromJson(
      Map<String, dynamic> jsonData) {
    return ProjectTrackVehicleTypesTasks(
      id: jsonData['id'] ?? 0,
      trackVehicleTypeId: jsonData['trackVehicleTypeId'] ?? 0,
      count: jsonData['count'] ?? 0,
      projectCityTaskId: jsonData['projectCityTaskId'] ?? 0,
      trackVehicleType: TrackVehicleType.fromJson(jsonData['trackVehicleType']),
    );
  }
}

class TrackVehicleType {
  final int id;
  final String name;

  TrackVehicleType({
    required this.id,
    required this.name,
  });

  factory TrackVehicleType.fromJson(Map<String, dynamic> jsonData) {
    return TrackVehicleType(
      id: jsonData['id'] ?? 0,
      name: jsonData['name'] ?? 0,
    );
  }
}
