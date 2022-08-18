import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/controller/project_controller.dart';
import '../../utils/style.dart';
import '../shared_widgets/custom_loader.dart';
import '../shared_widgets/header_widget.dart';
import '../shared_widgets/line_dot.dart';
import 'model/prepare_model.dart';
import 'widgets/info_card_widget.dart';

class AllProjectsScreen extends StatelessWidget {
  const AllProjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey[200],
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HeaderWidget(arrow: true),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Text(
                'projects list'.tr,
                style: const TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontFamily: 'hanimation'),
              ),
              const LineDots(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              Expanded(
                child: GetBuilder<ProjectController>(
                    init: ProjectController(),
                    builder: (controller) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        //height: MediaQuery.of(context).size.height / 1.3,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )),
                        child: controller.loading == true
                            ? const LoaderWidget()
                            : ListView.builder(
                                itemCount: controller.projects.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  ProjectModel data =
                                      controller.projects[index];
                                  return controller.projects.isEmpty
                                      //! empty projects list
                                      ? Container(
                                          margin: const EdgeInsets.all(20),
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/empty_product_banner.c076afe7.png"),
                                                  fit: BoxFit.contain)),
                                        )
                                      : InfoCardWidget(data: data);
                                }),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
