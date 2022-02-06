
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/epicenter/visit_epicenter_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/shared_widgets/custom_loader.dart';

class AllEpicenterWidget extends StatelessWidget {
  const AllEpicenterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GetBuilder<VisitEpicenterController>(
          init: VisitEpicenterController(),
          builder: (controller) {
            return GestureDetector(
                onTap: () {
            
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) => controller.loading == true
                        ? const LoaderWidget()
                        : SizedBox(
                            height: MediaQuery.of(context).size.height / 2.5,
                            child: ListView.builder(
                                itemCount: controller.epicenter.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      controller.onTapSelected(
                                          ctx, controller.epicenter[index].id,index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60, vertical: 15),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                12,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Text(
                                          controller.epicenter[index].name,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 7),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.centerRight,
                  // width:
                  //     MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 16,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        controller.epicenterText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            height: 1.1,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: blackColor),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: blackColor,
                        size: 30,
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}