import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../core/controller/click_controller.dart';
import '../../core/controller/image_picker_controller.dart';
import '../../core/controller/internet_connectivity_controller.dart';
import '../../core/service/animal_services.dart';
import '../../utils/style.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';
import '../shared_widgets/header_widget.dart';
import '../shared_widgets/images_widget.dart';
import '../shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class VisitAnimalScreen extends StatelessWidget {
  VisitAnimalScreen({Key? key, required this.id}) : super(key: key);
  final _visitAnimalFormKey = GlobalKey<FormState>();
  final int id;
////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ImagePickerController>(
            init: ImagePickerController(),
            builder: (imgCtrl) {
              return HawkFabMenu(
                body: SafeArea(
                    child: SingleChildScrollView(
                        child: Form(
                            key: _visitAnimalFormKey,
                            child: Column(
                              children: <Widget>[
                                const HeaderWidget(arrow: true),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                ),
                                 AutoSizeText(
                                  'Visit stray dog ​​site' .tr,
                                  style:const TextStyle(
                                      color: lightPrimaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const LineDots(),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.68,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  padding: const EdgeInsets.all(5),
                                  child: ListView(
                                    children: [
                                      //       const AllAnimalWidget(),
                                      //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                      ImagesWidget(
                                          path1: imgCtrl.image.path,
                                          path2: imgCtrl.image2.path,
                                          file1: imgCtrl.image,
                                          file2: imgCtrl.image2),
                                    ],
                                  ),
                                ),
                                GetBuilder<InternetController>(
                                    init: InternetController(),
                                    builder: (net) {
                                      return GetBuilder<ClickController>(
                                          init: ClickController(),
                                          builder: (clk) {
                                            return InkWell(
                                              onTap: () async {
                                                if (_visitAnimalFormKey
                                                    .currentState!
                                                    .validate()) {
                                                  _visitAnimalFormKey
                                                      .currentState!
                                                      .save();
                                                  net
                                                      .checkInternet()
                                                      .then((val) {
                                                    if (val) {
                                                      if (clk.clicked ==
                                                          false) {
                                                        // code here
                                                        AnimalServices
                                                            .sendVisitAnimalFormData(
                                                          strayDogId: id,
                                                          imge: imgCtrl
                                                              .image, // صورة 1
                                                          imge2: imgCtrl
                                                              .image2, // صورة 2
                                                        ).then((value) {
                                                          if (value == 400) {
                                                            toast(
                                                               'there is an error in sending'.tr,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (value ==
                                                              401) {
                                                            Get.offAll(
                                                                const LoginScreen());
                                                          } else if (value ==
                                                              200) {
                                                            Get.offAll(() =>
                                                                const HomeScreen());
                                                            CoolAlert.show(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              type:
                                                                  CoolAlertType
                                                                      .success,
                                                              title:
                                                                  'sent succesfully'.tr,
                                                              confirmBtnText:
                                                                  "ok".tr,
                                                              confirmBtnColor:
                                                                  primaryColor,
                                                              backgroundColor:
                                                                  primaryColor,
                                                               confirmBtnTextStyle: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.normal),
                                                              onConfirmBtnTap:
                                                                  () {
                                                                Get.back();
                                                              },

                                                            );
                                                          }
                                                        });
                                                      }
                                                      clk.changeClick();
                                                    }
                                                  });
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    17,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                decoration: clk.clicked == false
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        gradient:
                                                            const LinearGradient(
                                                                colors: [
                                                                  lightPrimaryColor,
                                                                  primaryColor,
                                                                ],
                                                                begin:
                                                                    FractionalOffset(
                                                                        0.0,
                                                                        0.0),
                                                                end:
                                                                    FractionalOffset(
                                                                        1.0,
                                                                        0.0),
                                                                stops: [
                                                                  0.0,
                                                                  1.0
                                                                ],
                                                                tileMode:
                                                                    TileMode
                                                                        .clamp),
                                                      )
                                                    : BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                                  Colors.grey
                                                                      .shade300,
                                                                  Colors.grey,
                                                                ],
                                                                begin:
                                                                    const FractionalOffset(
                                                                        0.0,
                                                                        0.0),
                                                                end: const FractionalOffset(
                                                                    1.0, 0.0),
                                                                stops: const [
                                                                  0.0,
                                                                  1.0
                                                                ],
                                                                tileMode:
                                                                    TileMode
                                                                        .clamp),
                                                      ),
                                                child: clk.clicked == false
                                                    ?  Text(
                                                       'Add Visit stray dog ​​site'.tr,
                                                        style:const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    : const CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                              ),
                                            );
                                          });
                                    })
                              ],
                            )))),
                items: [
                  HawkFabMenuItem(
                      label: 'add first picture'.tr,
                      ontap: () {
                        imgCtrl.pickImageFromGallrey();
                      },
                      icon: const Icon(Icons.image),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'pick first picture'.tr,
                      ontap: () {
                        imgCtrl.pickImageFromCam();
                      },
                      icon: const Icon(Icons.add_a_photo),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'add second picture'.tr,
                      ontap: () {
                        imgCtrl.pickImageFromGallrey2();
                      },
                      icon: const Icon(Icons.image),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'pick second picture'.tr,
                      ontap: () {
                        imgCtrl.pickImageFromCam2();
                      },
                      icon: const Icon(Icons.add_a_photo),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                ],
                openIcon: Icons.add_photo_alternate,
                blur: 0.5,
                fabColor: Colors.yellow,
                iconColor: primaryColor,
                closeIcon: Icons.close,
              );
            }));
  }
}
