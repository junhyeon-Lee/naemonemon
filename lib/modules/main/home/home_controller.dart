import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  @override
  void onInit() {
    scrollController = ScrollController(initialScrollOffset: Get.width-40,);
    super.onInit();
  }

  late final ScrollController scrollController;
  final ScrollController appbarScrollController = ScrollController(initialScrollOffset:0);


  bool pollMode = false;
  bool editGroupMode = false;
  bool mainMode =true;
  bool allItemMode = false;

  void swipeRight(){
    if(scrollController.offset==Get.width-40){
      scrollRightEnd();
    }else if(scrollController.offset== scrollController.position.minScrollExtent){
      scrollLeft();
    }else if(scrollController.offset== scrollController.position.maxScrollExtent){
      return ;
    }else{
      scrollMiddle();
    }
  }
  void swipeLeft(){
    if(scrollController.offset==Get.width-40){
      scrollLeft();
    }
    else if(scrollController.offset== Get.width-100){
      return ;
    }
    else if(scrollController.offset== scrollController.position.minScrollExtent){
      return ;
    }
    else{
      scrollMiddle();
    }
  }
  void openEditGroup(){
    scrollLeftEnd();
  }
  void closeEditGroup(){
    scrollLeft();
  }

  void scrollRightEnd() {
    scrollController.animateTo(
        scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    ).then((value){update();});
    appbarScrollController.animateTo(
      appbarScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    editGroupMode =false;
    allItemMode =false;
    mainMode =false;
    pollMode =true;
    update();
  }
  void scrollMiddle() {
    scrollController.animateTo(
      Get.width-40,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    ).then((value){update();});
    appbarScrollController.animateTo(
        appbarScrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    editGroupMode =false;
    allItemMode =false;
    mainMode =true;
    pollMode =false;
    update();
  }
  void scrollLeftEnd() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    ).then((value) {
      update();
    });
    editGroupMode =true;
    allItemMode =false;
    mainMode =false;
    pollMode =false;
    update();
  }
  void scrollLeft () {
    scrollController.animateTo(
      Get.width-100,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    ).then((value){update();});
    editGroupMode =false;
    allItemMode =true;
    mainMode =false;
    pollMode =false;
    update();
  }

  void updateHomeController()=>update();

}



