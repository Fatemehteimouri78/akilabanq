import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class InformationOnboardingController extends GetxController{
  int currentIndex=0;
  PageController pageController =PageController();
  List<CameraDescription>? cameras;
   late CameraController cameraController;

  void nextPage(){
    pageController.nextPage(duration: const Duration(milliseconds: 700), curve: Curves.linear);
    currentIndex++;
    update();
  }


  Future<void> availablecamera()async{
    cameras = await availableCameras().then((value) {
      return null;
    

    });

    initCamera();
    update();

  }

  Future<void> initCamera() async {
    var cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController.initialize().then((value) {

    });
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    availablecamera();
    super.onInit();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    cameraController.dispose();

    super.dispose();
  }

}