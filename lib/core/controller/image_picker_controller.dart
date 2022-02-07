import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class ImagePickerController extends GetxController {
    File  image = File("");
   File  image2 = File("");
  List<Asset> images = <Asset>[];
  String errorr = 'No Error Dectected';

  Future pickImageFromCam() async {
    try {
      final imagefromCamera =
          await ImagePicker().pickImage(source: ImageSource.camera);

      final imageTemproray =imagefromCamera !=null ? File(imagefromCamera.path):File("");

      image = imageTemproray;
      update();
    } on PlatformException catch (e) {
      log("failed pick image $e");
    }
  }

  Future pickImageFromCam2() async {
    try {
      final imagefromCamera2 =
          await ImagePicker().pickImage(source: ImageSource.camera);

      final imageTemproray2 =imagefromCamera2 !=null ? File(imagefromCamera2.path):File("");

      image2 = imageTemproray2;
      update();
    } on PlatformException catch (e) {
      log("failed pick image2 $e");
    }
  }

  Future pickImageFromGallrey() async {
    try {
      final imagefromGallery =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemproray =imagefromGallery != null ?  File(imagefromGallery.path):File("");

      image = imageTemproray;
      update();
    } on PlatformException catch (e) {
      log("failed pick image $e");
    }
  }

  Future pickImageFromGallrey2() async {
    try {
      final imagefromGallery2 =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemproray2 =imagefromGallery2 != null ?  File(imagefromGallery2.path):File("");

      image2 = imageTemproray2;
      update();
    } on PlatformException catch (e) {
      log("failed pick image $e");
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    images = resultList;
    errorr = error;
    update();
  }
}
