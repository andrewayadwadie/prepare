import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../core/db/auth_shared_preferences.dart';
import '../../../utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../../utils/style.dart';
import '../../auth/login_screen.dart';
import '../model/task_model.dart';

class TaskService {
  static Future getTasks() async {
    String url = "${apiUrl}DistrictLocations/GetTasks";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getTokenValue()}',
      },
    );

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      List  taks = jsonData.map((element) {
        return TaskModel.fromJson(element);
      }).toList();

      return taks;
    } else if (res.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
    } else if (res.statusCode == 500 ||res.statusCode == 501 ||res.statusCode == 504 ||res.statusCode == 502) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Server Error",
        onConfirm: () => Get.back(),
        confirmTextColor: whiteColor,
        buttonColor: redColor,
        backgroundColor: whiteColor,
      );
    } else if(res.statusCode == 400) {
      var errorData = jsonDecode(res.body);
       Get.defaultDialog(
        title: "Error",
        middleText: "${errorData['errors'][0][0]}",
        onConfirm: () => Get.back(),
        confirmTextColor: whiteColor,
        buttonColor: redColor,
        backgroundColor: whiteColor,
      );
    }else{
      log("something went wrong Status code from api is : ${res.statusCode}");
      Get.defaultDialog(
        title: "Error",
        middleText: "something went wrong",
        onConfirm: () => Get.back(),
        confirmTextColor: whiteColor,
        buttonColor: redColor,
        backgroundColor: whiteColor,
      );
    }
  }
}
