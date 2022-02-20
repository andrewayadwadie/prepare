import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/model/bug_discover/cities_model.dart';
import 'package:prepare/model/bug_discover/district_model.dart';
import 'package:prepare/model/bug_discover/fly_note_model.dart';
import 'package:prepare/model/bug_discover/fly_sample_type_model.dart';
import 'package:prepare/model/bug_discover/fly_type_model.dart';
import 'package:prepare/model/bug_discover/insect_explorations_model.dart';
// ignore: implementation_imports
import 'package:async/src/delegate/stream.dart';
import 'package:path/path.dart';
import 'package:prepare/model/bug_discover/neast_point_model.dart';

import 'package:prepare/utils/constants.dart';
import 'package:http/http.dart' as http;

class BugDiscoverServices {
  static Future getAllCities() async {
    String url = "${apiUrl}Cities/GetAllCities";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    log("status code is : ${res.statusCode}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List cities = jsonData.map((element) {
        return CitiesModel.fromJson(element);
      }).toList();

      return cities;
    } else if (res.statusCode == 401) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }

//===============================================
  static Future getAllDistrict(int id) async {
    log("district id is : $id");
    String url = "${apiUrl}Districts/GetCityDistricts/$id";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    //   log("token is : ${TokenPref.getTokenValue()}");
    log("district status code is : ${res.statusCode}");

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List district = jsonData.map((element) {
        return DistrictModel.fromJson(element);
      }).toList();

      return district;
    } else if (res.statusCode == 401) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }

//===============================================
  static Future getAllFlyTypes() async {
    String url = "${apiUrl}FlyTypes/GetAllFlyTypes";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    //   log("token is : ${TokenPref.getTokenValue()}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List flyType = jsonData.map((element) {
        return FlyTypeModel.fromJson(element);
      }).toList();

      return flyType;
    } else if (res.statusCode == 401) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }
//========================================================

  static Future getBugDiscoverCode(int flyTypeId, int cityId) async {
    String url =
        "${apiUrl}InsectExplorations/GetInsectExplorationCode/$cityId/$flyTypeId";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    log("status code is : ${res.statusCode}");
    if (res.statusCode == 200 || res.statusCode == 201) {
      var data = res.body;

      return data;
    } else if (res.statusCode == 401 || res.statusCode == 403) {
      return "عير مصرح للمستخدم";
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return "يوجد مشكلة ";
    } else if (res.statusCode == 400) {
      var errorMsg = jsonDecode(res.body);

      return errorMsg['errors'][0][0];
    }
  }

//<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>//
//===============================================
  static Future getAllFlySampleTypes() async {
    String url = "${apiUrl}FlySampleTypes/GetAllFlySampleTypes";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    //   log("token is : ${TokenPref.getTokenValue()}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List flySample = jsonData.map((element) {
        return FlySampleTypeModel.fromJson(element);
      }).toList();

      return flySample;
    } else if (res.statusCode == 401) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }

//===============================================
  static Future getAllFlyNotes() async {
    String url = "${apiUrl}FlyNotes/GetAllFlyNotes";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    //   log("token is : ${TokenPref.getTokenValue()}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List flyNotes = jsonData.map((element) {
        return FlyNoteModel.fromJson(element);
      }).toList();

      return flyNotes;
    } else if (res.statusCode == 401) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }

//===============================================
  static Future getInsectExploration(int id) async {
    String url = "${apiUrl}InsectExplorations/GetInsectExploration/$id";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    //   log("token is : ${TokenPref.getTokenValue()}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List insectExploration = jsonData.map((element) {
        return InsectExplorationsModel.fromJson(element);
      }).toList();

      return insectExploration;
    } else if (res.statusCode == 401) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }

//===============================================
  static Future getAllInsectExploration() async {
    String url = "${apiUrl}InsectExplorations/GetUserInsectExplorations";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    //   log("token is : ${TokenPref.getTokenValue()}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List insectExploration = jsonData.map((element) {
        return InsectExplorationsModel.fromJson(element);
      }).toList();

      return insectExploration;
    } else if (res.statusCode == 401) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }

//===============================================
  static Future sendFormData({
    required street,
    required temperature,
    required windSpeed,
    required humidity,
    required recommendation,
    required waving,
    required ph,
    required districtId,
    required flyTypeId,
    required flyNoteId,
    required flySampleTypeId,
    required File imge,
    required File imge2,
    required lat,
    required long,
    required code,
  }) async {
    final Uri url =
        Uri.parse('${apiUrl}InsectExplorations/AddInsectExploration');

    // ignore: deprecated_member_use

    var headers = <String, String>{
      "Content-type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
    };

    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(headers);
    if (imge.path != "") {
      // ignore: deprecated_member_use
      var stream = http.ByteStream(DelegatingStream.typed(imge.openRead()));
      // ignore: deprecated_member_use

      var length = await imge.length();

      var multipartFile1 = http.MultipartFile('Image1', stream, length,
          filename: basename(imge.path));

      request.files.add(multipartFile1);
    }
    if (imge2.path != "") {
      // ignore: deprecated_member_use
      var stream2 = http.ByteStream(DelegatingStream.typed(imge2.openRead()));

      var length2 = await imge2.length();

      var multipartFile2 = http.MultipartFile('Image2', stream2, length2,
          filename: basename(imge2.path));

      request.files.add(multipartFile2);
    }
    request.fields["Lat"] = "$lat";
    request.fields["Long"] = "$long";
    request.fields["Street"] = "$street";
    request.fields["Temperature"] = "$temperature";
    request.fields["WindSpeed"] = "$windSpeed";
    request.fields["Humidity"] = "$humidity";
    request.fields["Recommendation"] = "$recommendation";
    request.fields["Waving"] = "$waving";
    request.fields["Ph"] = "$ph";
    request.fields["DistrictId"] = "$districtId";
    request.fields["FlyTypeId"] = "$flyTypeId";
    request.fields["FlyNoteId"] = "$flyNoteId";
    request.fields["FlySampleTypeId"] = "$flySampleTypeId";
    request.fields["Code"] = "$code";

    var response = await request.send();

    if (response.statusCode == 400) {
      return 400;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      return 201;
    }
  }

//================================================================

  static Future sendVisitFormData(
      {required temperature, // String
      required windSpeed, // String
      required humidity, // String
      required recommendation, // String
      required waving, // String
      required ph, // String
      required isNegative, // true or false
      required File imge, // File
      required File imge2, // File
      required insectExplorationId // int

      }) async {
    final Uri url = Uri.parse(
        '${apiUrl}InsectExplorationsVisits/AddInsectExplorationVisit');

    // ignore: deprecated_member_use

    var headers = <String, String>{
      "Content-type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
    };

    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(headers);
    if (imge.path != "") {
      // ignore: deprecated_member_use
      var stream = http.ByteStream(DelegatingStream.typed(imge.openRead()));
      // ignore: deprecated_member_use

      var length = await imge.length();

      var multipartFile1 = http.MultipartFile('Image1', stream, length,
          filename: basename(imge.path));

      request.files.add(multipartFile1);
    }
    if (imge2.path != "") {
      // ignore: deprecated_member_use
      var stream2 = http.ByteStream(DelegatingStream.typed(imge2.openRead()));

      var length2 = await imge2.length();

      var multipartFile2 = http.MultipartFile('Image2', stream2, length2,
          filename: basename(imge2.path));

      request.files.add(multipartFile2);
    }

    request.fields["Temperature"] = "$temperature";
    request.fields["WindSpeed"] = "$windSpeed";
    request.fields["Humidity"] = "$humidity";
    request.fields["Recommendation"] = "$recommendation";
    request.fields["Waving"] = "$waving";
    request.fields["Ph"] = "$ph";
    request.fields["InsectExplorationId"] = "$insectExplorationId";
    request.fields["IsNegative"] = "$isNegative";

    var response = await request.send();

    if (response.statusCode == 400) {
      return 400;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      return 200;
    }
  }

//<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>//

  static Future getNearstBugDiscoverVisit(double lat, double long) async {
    String url =
        "${apiUrl}InsectExplorations/GetClosestInsectExplorations/$lat/$long";
    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    //   log("token is : ${TokenPref.getTokenValue()}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List closeBugDiscoverVisit = jsonData.map((element) {
        return NearstBugDiscoverPointModel.fromJson(element);
      }).toList();

      return closeBugDiscoverVisit;
    } else if (res.statusCode == 401) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }
}
