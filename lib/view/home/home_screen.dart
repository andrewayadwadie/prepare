import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:prepare/core/controller/app_lang_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/home/widgets/home_body.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: GetBuilder<AppLanguage>(
          init: AppLanguage(),
          builder: (lang) {
            return HawkFabMenu(
                openIcon: Icons.translate,
                blur: 0.5,
                fabColor: Colors.yellow,
                iconColor: primaryColor,
                closeIcon: Icons.close,
                items: [
                  HawkFabMenuItem(
                      label: 'arabic language'.tr,
                      ontap: () {
                        lang.changeLanguage("ar");
                        Get.updateLocale(const Locale("ar"));
                      },
                      icon: const Icon(Icons.language),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'english language'.tr,
                      ontap: () {
                        lang.changeLanguage("en");
                        Get.updateLocale(const Locale("en"));
                      },
                      icon: const Icon(Icons.language),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                ],
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const HeaderWidget(arrow: false),
                        const SizedBox(
                          height: 10,
                        ),
                     /*
                        GetBuilder<AppLanguage>(
                            init: AppLanguage(),
                            builder: (lang) {
                              return DropdownButton(
                                items: const [
                                  DropdownMenuItem(
                                    child: Text('en'),
                                    value: 'en',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('ar'),
                                    value: 'ar',
                                  ),
                                ],
                                value: lang.appLocale,
                                onChanged: (String? val) {
                                  lang.changeLanguage(val);
                                  Get.updateLocale(Locale(val!));
                                },
                              );
                            }),
                            */
                        HomeBodyWidget()
                      ],
                    ),
                  ),
                ));
          }
        ));
  }
}
