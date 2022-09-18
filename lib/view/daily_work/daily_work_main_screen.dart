import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/controller/internet_connectivity_controller.dart';
import '../../utils/style.dart';
import '../shared_widgets/custom_loader.dart';
import '../shared_widgets/custom_no_data.dart';
import '../shared_widgets/header_widget.dart';
import '../shared_widgets/line_dot.dart';
import 'controller/task_controller.dart';
import 'daily_controller/daily_work_audio_controller.dart';
import 'daily_work_screen.dart';

class DailyWorkMainScreen extends StatelessWidget {
  const DailyWorkMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<DailyWorkAudioController>(
              init: DailyWorkAudioController(),
              builder: (audio) {
                return const HeaderWidget(arrow: true);
              }
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Text(
              'daily tasks'.tr,
              style: const TextStyle(
                  color: primaryColor, fontSize: 20, fontFamily: 'hanimation'),
            ),
            const LineDots(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height / 1.5,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )),
                child: GetX<TaskController>(
                    init: TaskController(),
                    builder: (taskCtrl) {
                      return taskCtrl.loading.value == true
                          ? const LoaderWidget()
                          : taskCtrl.noData.value == "No Data"
                              ? const NoDataWidget()
                              : ListView.builder(
                                  itemCount: taskCtrl.tasks.length,
                                  itemBuilder: (context, index) {
                                    List allTasksData = taskCtrl.tasks;

                                    return GetBuilder<InternetController>(
                                        init: InternetController(),
                                        builder: (net) {
                                          return InkWell(
                                            onTap: () {
                                              net.checkInternet().then((value) {
                                                if (value) {
                                                  Get.to(() => DailyWorkScreen(
                                                        districtLocations:
                                                            allTasksData[index]
                                                                .districtLocations,
                                                        districtId :   allTasksData[index]
                                                                .districtId , 
                                                        routeId:    allTasksData[index]
                                                                .routeNumber,
                                                      ));
                                                }
                                              });
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 16, right: 5, left: 5),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  10,
                                              decoration: BoxDecoration(
                                                color: offwhiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.6),
                                                    spreadRadius: 2,
                                                    blurRadius: 4,
                                                    offset: const Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.9,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AutoSizeText(
                                                          "${'District'.tr} :  ${allTasksData[index].districtName}",
                                                          style: const TextStyle(
                                                              color:
                                                                  lightPrimaryColor,
                                                              fontFamily:
                                                                  "hanimation",
                                                              fontSize: 15),
                                                        ),
                                                        AutoSizeText(
                                                          "${'path number'.tr} :  ${allTasksData[index].routeNumber}",
                                                          style: const TextStyle(
                                                              color:
                                                                  lightPrimaryColor,
                                                              fontFamily:
                                                                  "hanimation",
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        primaryColor,
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  });
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
