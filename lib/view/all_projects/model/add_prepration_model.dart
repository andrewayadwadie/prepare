class Preparation {
  final int projectId;
  final CityPrepration projectCityPreparation;

  Preparation({
    required this.projectId,
    required this.projectCityPreparation,
  });

  factory Preparation.fromJson(Map<String, dynamic> jsonData) {
    return Preparation(
      projectId: jsonData['ProjectId'] ?? 0,
      projectCityPreparation:
          CityPrepration.fromJson(jsonData['ProjectCityPreparation']),
    );
  }
}

class CityPrepration {
  final String numberOfSectorSupervisors;
  final String numberOfControlSpecialist;
  final String numberOfEmployees;
  final String numberOfDrivers;
  final String numberOfLiquidDevices;
  final String numberOfULVDevices;
  final String numberOfFogDevices;
  final String numberOfPumps;
  final int cityId;

  final List projectTrackVehicleTypesPreparations;
  CityPrepration({
    required this.numberOfDrivers,
    required this.numberOfLiquidDevices,
    required this.numberOfULVDevices,
    required this.numberOfFogDevices,
    required this.numberOfPumps,
    required this.cityId,
    required this.projectTrackVehicleTypesPreparations,
    required this.numberOfSectorSupervisors,
    required this.numberOfControlSpecialist,
    required this.numberOfEmployees,
  });

  factory CityPrepration.fromJson(Map<String, dynamic> jsonData) {
    return CityPrepration(
      numberOfSectorSupervisors: jsonData['NumberOfSectorSupervisors'] ?? "0",
      numberOfControlSpecialist: jsonData['NumberOfControlSpecialist'] ?? "0",
      numberOfEmployees: jsonData['NumberOfEmployees'] ?? "0",
      numberOfDrivers: jsonData['NumberOfDrivers'] ?? "0",
      numberOfLiquidDevices: jsonData['NumberOfLiquidDevices'] ?? "0",
      numberOfULVDevices: jsonData['NumberOfULVDevices'] ?? "0",
      numberOfFogDevices: jsonData['NumberOfFogDevices'] ?? "0",
      numberOfPumps: jsonData['NumberOfPumps'] ?? "0",
      cityId: jsonData['CityId'] ?? 0,
      projectTrackVehicleTypesPreparations:
          jsonData['ProjectTrackVehicleTypesPreparations'] ,
    );
  }
}


/*
class Vehicle {
  final String count;
  final int trackVehicleTypeId;

  Vehicle({
    required this.count,
    required this.trackVehicleTypeId,
  });

  factory Vehicle.fromJson(Map<String, dynamic> jsonData) {
    return Vehicle(
      count: jsonData['Count'] ?? "0",
      trackVehicleTypeId: jsonData['TrackVehicleTypeId'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
        "Count": count,
        "trackVehicleTypeId": "$trackVehicleTypeId",
      };
}
*/