import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

class FeedController extends GetxController {
  late PageController feedPageController;

  @override
  void onInit() {
    feedPageController = PageController(initialPage: 0);

    update();

    feedPageController.addListener(() {
      int currentPage = feedPageController.page!.round();
      if (beforePage != currentPage) {
        update();
      }
      beforePage = currentPage;
    });
    super.onInit();
  }

  PollRepository pollRepository = PollRepository();
  List<Poll> feedList = [];

  int feedSkip = 0;

  setFeedList() async {
    List<Poll> tempFeedList = await pollRepository.getFeedList(feedSkip) ?? [];
    for (int i = 0; i < tempFeedList.length; i++) {
      feedList.add(tempFeedList[i]);
    }
  }

  refreshFeedList() async {
    indicatorController.nowLoading();
    update();
    feedSkip = 0;
    List<Poll> tempFeedList = await pollRepository.getFeedList(feedSkip) ?? [];
    feedList = [];
    for (int i = 0; i < tempFeedList.length; i++) {
      feedList.add(tempFeedList[i]);
    }
    update();
  }

  int beforePage = 0;

  int nowFeedPosition() {
    return feedPageController.page?.toInt() ?? 0;
  }

  String scrollMode = 'list';
  ScrollPhysics listViewPhysics = const ClampingScrollPhysics();

  changeScrollerMode(String mode) {
    scrollMode = mode;
    getScrollMode();
  }

  getScrollMode() {
    if (scrollMode == 'list') {
      listViewPhysics = const ClampingScrollPhysics();
    } else if (scrollMode.substring(0, 4) == 'page') {
      listViewPhysics = const NeverScrollableScrollPhysics();
    }
    update();
  }

  bool isFeedLoading = false;

  getNextFeed() async {
    if (homeController.feedScrollController.position.extentAfter < 100 && isFeedLoading == false) {
      isFeedLoading = true;
      feedSkip += 30;
      update();
      homeController.update();

      List<Poll> tempFeedList = await pollRepository.getFeedList(feedSkip) ?? [];
      for (int i = 0; i < tempFeedList.length; i++) {
        feedList.add(tempFeedList[i]);
      }

      isFeedLoading = false;
      update();
      homeController.update();
    }
  }

  forceGetNextFeed() async {
    isFeedLoading = true;
    feedSkip += 30;
    update();
    homeController.update();

    List<Poll> tempFeedList = await pollRepository.getFeedList(feedSkip) ?? [];
    for (int i = 0; i < tempFeedList.length; i++) {
      feedList.add(tempFeedList[i]);
    }

    isFeedLoading = false;
    update();
    homeController.update();
  }


}
