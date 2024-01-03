import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

import 'poll/feed_screen/feed_controller.dart';
class HomeController extends GetxController {
  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    appbarScrollController = ScrollController();
    cartScrollController = ScrollController();
    feedScrollController = ScrollController()..addListener(feedController.getNextFeed);
    joinedListScrollController = ScrollController()..addListener(pollController.getNextJoinedList);
    super.onInit();
  }





  bool exposureAppBar = true;
  late final PageController pageController;
  late final ScrollController appbarScrollController;
  late final ScrollController cartScrollController;
  late final ScrollController feedScrollController;
  late final ScrollController joinedListScrollController;


  String modeSate = 'main';

  bool isScreenPosition = true;







  void moveRight() {
    safePrint('우측 이동');
    exposureAppBar = true;
    update();
    isScreenPosition = false;
    update();
    pageController
        .animateTo(
      pageController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );

    appbarScrollController
        .animateTo(
      pageController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    )
        .then((value) {

      update();
    });
  }

  void moveLeft() {
    exposureAppBar = true;
    update();
    isScreenPosition = true;
    update();
    pageController
        .animateTo(
      pageController.position.minScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );

    appbarScrollController
        .animateTo(
      pageController.position.minScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    )
        .then((value) {
      update();
    });
  }



  void changeMode(String mode) {
    modeSate = mode;
    update();
  }

  bool isLoading = false;
  void openLoading(){
    isLoading = true;
    update();
  }
  void closeLoading(){
    isLoading = false;
    update();
  }

  bool isClipBoardUrl = false;
  String clipBoardUrl = '';


}
