


import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class ImagePickerController extends GetxController{
  
   File? image;

    List<Asset> images = <Asset>[];
     String errorr = 'No Error Dectected';

  Future pickImageFromCam() async {
    try {
    final  imagefromCamera =
         await ImagePicker().pickImage(source: ImageSource.camera);

    final imageTemproray =  File(imagefromCamera!.path);
      
        image = imageTemproray;
     update();

    } on PlatformException catch (e) {
      log("failed pick image $e");
    }
  }

  Future pickImageFromGallrey() async {
    
    try {
      final   imagefromGallery =
         await ImagePicker().pickImage(source: ImageSource.gallery);

      

      final imageTemproray =  File(imagefromGallery!.path);
      
        image = imageTemproray;
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
        materialOptions:const MaterialOptions(
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