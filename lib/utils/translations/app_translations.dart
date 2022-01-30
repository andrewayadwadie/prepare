
import 'package:get/get.dart';
import 'package:prepare/utils/translations/ar.dart';
import 'package:prepare/utils/translations/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {"en": en, "ar": ar};
}
