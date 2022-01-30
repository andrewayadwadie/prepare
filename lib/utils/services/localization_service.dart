import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/services/storage_service.dart';

class SupportedLocales {
  static List<Locale> all = [const Locale("en"), const Locale("ar")];

  static Locale english = const Locale("en");
  static Locale arabic = const Locale("ar");
}

class LocalizationService extends GetxService {
  LocalizationService(this._activeLocale);

  final Locale _activeLocale;

  Locale get activeLocale => _activeLocale;

  static LocalizationService init() {
    //Get active local from storage
    Locale activeLocale = Get.find<StorageService>().activeLocale;
    return LocalizationService(activeLocale);
  }

  void toggleLocale() {
    final Locale newLocale = _activeLocale == SupportedLocales.arabic
        ? SupportedLocales.english
        : SupportedLocales.arabic;
    //in storage
    Get.find<StorageService>().activeLocale = newLocale;

    //in Getx
    Get.updateLocale(newLocale);
  }
}
