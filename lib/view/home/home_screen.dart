import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

import '../../core/controller/app_lang_controller.dart';
import '../../core/db/auth_shared_preferences.dart';
import '../../utils/style.dart';
import '../auth/login_screen.dart';
import '../shared_widgets/header_widget.dart';
import 'widgets/home_body.dart';

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
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: [
                            //! Header
                            const HeaderWidget(arrow: false),
                           //! LogOut Button
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  SharedPref.clearToken();
                                  Get.offAll(const LoginScreen());
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, top: 15, bottom: 20),
                                  width:
                                      MediaQuery.of(context).size.width / 10,
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(Icons.exit_to_app,
                                      color: redColor, size: 30),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      
                        const Expanded(child: HomeBodyWidget())
                      ],
                    ),
                  ));
            }));
  }
}
