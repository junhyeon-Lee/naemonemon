import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/modules/main/home/poll/feed_screen/feed_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_screen.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/indicator/indicator.dart';

import '../../cart/cart_controller.dart';

double nowScroll = 0.0;
double beforeScroll = 0.0;
bool nowPageScrollDirection = true;

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final pollDetailController = Get.put(PollDetailController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(
      init: FeedController(),
      builder: (feedController) {
        return Stack(
          children: [
            GetBuilder<CartController>(
              builder: (cartController) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onPanUpdate: (details) {},
                  child: SizedBox(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          ScrollConfiguration(
                            behavior: const ScrollBehavior().copyWith(overscroll: false),
                            child: Flexible(
                              child: NotificationListener(
                                onNotification: (t) {
                                  if (homeController.isScreenPosition == false) {
                                    if (homeController.feedScrollController.position.userScrollDirection == ScrollDirection.reverse) {
                                      if (homeController.exposureAppBar) {
                                        homeController.exposureAppBar = false;
                                        homeController.update();
                                      }
                                    } else if (homeController.feedScrollController.position.userScrollDirection == ScrollDirection.forward) {
                                      if (!homeController.exposureAppBar) {
                                        homeController.exposureAppBar = true;
                                        homeController.update();
                                      }
                                    }
                                  }

                                  if (homeController.feedScrollController.position.userScrollDirection == ScrollDirection.idle) {}

                                  return true;
                                },
                                child: RefreshIndicator(
                                  onRefresh: () async{
                                    safePrint('리프래쉬');
                                    feedController.refreshFeedList();
                                  },
                                  child: GridView.builder(
                                      controller: homeController.feedScrollController,
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: feedController.feedList.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 170 / 230,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                      ),
                                      itemBuilder: (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () async {
                                              await Get.to(
                                                  PollDetailScreen(
                                                    selectedIndex: index,
                                                    type: 2,
                                                  ),
                                                  transition: Transition.downToUp);
                                            },
                                            child: feedItem(feedController.feedList[index]));
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            if(indicatorController.isLoading)
            myIndicator(),
          ],
        );
      },
    );
  }
}

Widget feedItem(Poll pollData) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(60)),
      border: Border.all(width: 1, color: CColor.brightGray),
      color: CColor.brightGray,
    ),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            child: CachedNetworkImage(
              imageUrl: pollData.items[0].image ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: CColor.gray.withOpacity(0.3),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0), Colors.black.withOpacity(0.5), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Positioned(
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                  width: (Get.width - 100 - 10 - 40) / 2,
                  child: Text(
                    pollData.pollComment,
                    style: CTextStyle.bold14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  )),
            ))
      ],
    ),
  );
}
