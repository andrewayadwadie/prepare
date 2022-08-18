import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/db/auth_shared_preferences.dart';
import '../../all_projects/all_projects_screen.dart';
import '../../animal/animal_main_screen.dart';
import '../../bug_discover/bug_discover_main_screen.dart';
import '../../daily_work/daily_work_main_screen.dart';
import '../../epicenter/epicenter_main_screen.dart';
import '../../workers_evaluation/contractors_list_screen.dart';

class RoleController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    userType();
  }

  List<String> titles = [];

  List<Widget> screens = [];

  void userType() {
    //! for test all feature 
    if (SharedPref.getRoleValue() == "Admin") {
      titles.addAll([
        'preparation screen'.tr,
        'insect exploration'.tr,
        'density measurement'.tr,
        'stray dogs'.tr,
        'daily tasks'.tr,
        'contractor evaluation'.tr
      ]);
      screens.addAll([
        const AllProjectsScreen(),
        BugDiscoverMainScreen(),
        EpicCenterMainScreen(),
        AnimalMainScreen(),
        const DailyWorkMainScreen(),
        const ContractorsListScreen()
      ]);
    } else if (SharedPref.getRoleValue() == "Driver") {
      titles.addAll([
        'daily tasks'.tr,
      ]);
      screens.addAll([
        const DailyWorkMainScreen(),
      ]);
    } else if (SharedPref.getRoleValue() == "ExplorationTechnician") {
      titles.addAll([
        'insect exploration'.tr,
        'density measurement'.tr,
      ]);
      screens.addAll([
        BugDiscoverMainScreen(),
        EpicCenterMainScreen(),
      ]);
    } else if (SharedPref.getRoleValue() == "StrayDogsTechnician") {
      titles.addAll([
        'stray dogs'.tr,
      ]);
      screens.addAll([
        AnimalMainScreen(),
      ]);
    } else if (SharedPref.getRoleValue() == "QualityController") {
      titles.addAll([
        'preparation screen'.tr,
      ]);
      screens.addAll([
        const AllProjectsScreen(),
      ]);
    } else if (SharedPref.getRoleValue() == "QualityProject") {
      titles.addAll(['contractor evaluation'.tr]);
      screens.addAll([const ContractorsListScreen()]);
    }
  }
}
