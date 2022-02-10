import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/service/animal_services.dart';

class AnimalController extends GetxController {
  List<dynamic> animal = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getAnimalCount();
    super.onInit();
  }

  String animalText = "إختر بؤرة الكلاب الضالة";

  int animalId = 0;

  void onTapSelected(BuildContext con, int id, int index) {
    animalId = id;
    Navigator.pop(con);

    animalText = animal[index].street;

    update();
  }

  bool get loading => _loading.value;
  dynamic getAnimalCount() {
    if (_loading.value == true) {
      AnimalServices.getAnimal().then((value) {
        animal = value;
        _loading.value = false;
        update();
      });
    }
    return animal;
  }
}
