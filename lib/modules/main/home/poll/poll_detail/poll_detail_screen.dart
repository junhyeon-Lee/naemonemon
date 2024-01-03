import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/modules/main/home/poll/my_poll/poll_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_general_screen.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_vs_screen.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_yn_screen.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/indicator/indicator.dart';
import 'package:shovving_pre/util/sundry_widget/web_view/web_view_screen.dart';

class PollDetailScreen extends StatelessWidget {
  const PollDetailScreen({Key? key, required this.selectedIndex, required this.type}) : super(key: key);

  final int selectedIndex;
  final int type;

  ///type 1 = 내 투표  type 2 = 피드

  @override
  Widget build(BuildContext context) {
    List<Poll> pollList = [];
    if (type == 1) {
      pollList = pollController.myPollList;
    } else if (type == 2) {
      pollList = feedController.feedList;
    } else if (type == 3) {
      pollList = pollController.joinedPollList;
    }

    PageController pageController = PageController(initialPage: selectedIndex);

    return GetBuilder<PollDetailController>(
        init: PollDetailController(),
        builder: (pollDetailController) {
          return Scaffold(
            backgroundColor: CColor.brightGray,
            body: Stack(
              children: [
                PageView.builder(
                  itemCount: pollList.length,
                  controller: pageController,
                  onPageChanged: (page) async {
                    if (page == feedController.feedList.length - 1) {
                      await feedController.forceGetNextFeed();
                      pollDetailController.update();
                    }

                    pollDetailController.commentExtraRiveState = false;
                    pollDetailController.isExpanded = false;
                    pollDetailController.imageListPageController.jumpToPage(0);
                    pollDetailController.selectItem(0);

                  },
                  scrollDirection: Axis.vertical,
                  physics: pollDetailController.isExpanded
                      ? const NeverScrollableScrollPhysics()
                      : pollDetailController.isAddCartMode
                          ? const NeverScrollableScrollPhysics()
                          : pollDetailController.commentSheetState == 0
                              ? const BouncingScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (pollList[index].items.length == 1) {
                      return SizedBox(
                        width: Get.width,
                        height: Get.height,
                        child: PollDetailYNScreen(
                          index: index,
                          type: type,
                        ),
                      );
                    } else if (pollList[index].items.length == 2) {
                      return SizedBox(
                        width: Get.width,
                        height: Get.height,
                        child: PollDetailVSScreen(
                          index: index,
                          type: type,
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: Get.width,
                        height: Get.height,
                        child: PollDetailGeneralScreen(
                          index: index,
                          type: type,
                        ),
                      );
                    }
                  },
                ),
                if (indicatorController.isLoading) myIndicator()
              ],
            ),
          );
        });
  }
}
