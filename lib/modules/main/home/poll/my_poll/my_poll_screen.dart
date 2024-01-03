import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/modules/main/home/poll/my_poll/poll_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_screen.dart';
import 'package:shovving_pre/ui_helper/common_widget/common_appbar.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/indicator/indicator.dart';

import '../../../../../ui_helper/common_ui_helper.dart';
import 'my_poll_detail_screen.dart';

class MyPollScreen extends StatelessWidget {
  const MyPollScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PollController>(
        builder: (pollController) {
      return Stack(
        children: [
          Scaffold(
            appBar: CommonAppbar(
              title: '내 투표',
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                if (pollController.isMyPoll) ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: pollController.myPollList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: index == 0
                                ? const EdgeInsets.only(top: 90)
                                : index == (pollController.myPollList?.length ?? 0) - 1
                                    ? const EdgeInsets.only(bottom: 50, top: 10)
                                    : const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    ///투표 상세로 이동하기
                                    pollController.setMyPollPageIndex(index);




                                    Get.to( PollDetailScreen(selectedIndex: index, type: 1,));
                                  },
                                  child: Container(
                                    width: Get.width - 40,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(30)), border: Border.all(color: CColor.brightGray, width: 1)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 36, right: 26, top: 30),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${(pollController.myPollList?[index]?.numberOfVotes.reduce((value, element) => value + element) ?? 0)}명 참여',
                                                style: CTextStyle.regular16,
                                              ),
                                              Container(
                                                  width: 80,
                                                  height: 26,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                    color: pollController.myPollList?[index]?.finalChoice ==null?CColor.lavender:CColor.brightGray,
                                                  ),
                                                  child: Center(child:
                                                  pollController.myPollList?[index]?.finalChoice ==null?
                                                  Text('진행중',style: CTextStyle.light14.copyWith(color: Colors.white),):
                                                  Text('종료',style: CTextStyle.light14.copyWith(color: CColor.deepBlueBlack),)

                                                  )),
                                            ],
                                          ),
                                        ),
                                        if (pollController.myPollList?[index]?.pollComment != null && pollController.myPollList?[index]?.pollComment != '')
                                          Padding(
                                            padding: const EdgeInsets.only(left: 36, right: 26, top: 4),
                                            child: Text(
                                              pollController.myPollList![index]!.pollComment!,
                                              style: CTextStyle.heavy24.copyWith(
                                                height: 36 / 24,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 36,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    CIconPath.like,
                                                    width: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    (pollController.myPollList?[index]?.likeLength??0).toString(),
                                                    style: CTextStyle.bold10.copyWith(color: Colors.black),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    CIconPath.comment,
                                                    width: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                      (pollController.myPollList?[index]?.comments.length??0).toString(),
                                                    style: CTextStyle.bold10.copyWith(color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 18, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: Get.width - 90,
                                                height: 160,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                    border: Border.all(color: const Color(0xffF7F6F9))),
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                  child:

                                                      PageView.builder(
                                                        physics: BouncingScrollPhysics(),
                                                        itemCount: pollController.myPollList![index]!.items.length,
                                                        itemBuilder: (BuildContext context, int idx) {
                                                          return
                                                          CachedNetworkImage(
                                                            imageUrl: pollController.myPollList![index]!.items[idx].image!,
                                                            fit: BoxFit.cover,
                                                            placeholder: (context, url) => Container(
                                                              color: CColor.gray.withOpacity(0.3),
                                                            ),
                                                          );
                                                        },

                                                      )






                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })


                else RefreshIndicator(
                    onRefresh: ()async{
                      pollController.refreshJoinedList();
                    },
                    child: ListView.builder(
                    controller: homeController.joinedListScrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: pollController.joinedPollList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(top: 90)
                              : index == (pollController.joinedPollList?.length ?? 0) - 1
                              ? const EdgeInsets.only(bottom: 50, top: 10)
                              : const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  ///투표 상세로 이동하기
                                  pollController.setMyPollPageIndex(index);




                                  Get.to( PollDetailScreen(selectedIndex: index, type: 3,));
                                },
                                child: Container(
                                  width: Get.width - 40,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(30)), border: Border.all(color: CColor.brightGray, width: 1)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 36, right: 26, top: 30),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${(pollController.joinedPollList?[index]?.numberOfVotes.reduce((value, element) => value + element) ?? 0)}명 참여',
                                              style: CTextStyle.regular16,
                                            ),
                                            Container(
                                                width: 80,
                                                height: 26,
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                  color: pollController.joinedPollList?[index]?.finalChoice ==null?CColor.lavender:CColor.brightGray,
                                                ),
                                                child: Center(child:
                                                pollController.joinedPollList?[index]?.finalChoice ==null?
                                                Text('진행중',style: CTextStyle.light14.copyWith(color: Colors.white),):
                                                Text('종료',style: CTextStyle.light14.copyWith(color: CColor.deepBlueBlack),)

                                                )),
                                          ],
                                        ),
                                      ),
                                      if (pollController.joinedPollList?[index]?.pollComment != null && pollController.joinedPollList?[index]?.pollComment != '')
                                        Padding(
                                          padding: const EdgeInsets.only(left: 36, right: 26, top: 4),
                                          child: Text(
                                            pollController.joinedPollList![index]!.pollComment!,
                                            style: CTextStyle.heavy24.copyWith(
                                              height: 36 / 24,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 36,
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  CIconPath.like,
                                                  width: 20,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  (pollController.joinedPollList?[index]?.likeLength??0).toString(),
                                                  style: CTextStyle.bold10.copyWith(color: Colors.black),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  CIconPath.comment,
                                                  width: 20,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  (pollController.joinedPollList?[index]?.comments.length??0).toString(),
                                                  style: CTextStyle.bold10.copyWith(color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: Get.width - 90,
                                              height: 160,
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                  border: Border.all(color: const Color(0xffF7F6F9))),
                                              child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                  child:

                                                  PageView.builder(
                                                    physics: BouncingScrollPhysics(),
                                                    itemCount: pollController.joinedPollList![index]!.items.length,
                                                    itemBuilder: (BuildContext context, int idx) {
                                                      return
                                                        CachedNetworkImage(
                                                          imageUrl: pollController.joinedPollList![index]!.items[idx].image!,
                                                          fit: BoxFit.cover,
                                                          placeholder: (context, url) => Container(
                                                            color: CColor.gray.withOpacity(0.3),
                                                          ),
                                                        );
                                                    },

                                                  )






                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  ) ,










                Positioned(
                    top: 20,
                    child: Container(
                      width: Get.width - 40,
                      height: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(36)),
                        color: Colors.black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              pollController.changeLeft();
                            },
                            child: Container(
                              width: (Get.width - 100) / 2,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(36)),
                                  color: pollController.isMyPoll ? Colors.white : CColor.deepBlueBlack),
                              child: Center(
                                child: Text(
                                  '내가 만든 투표',
                                  style: CTextStyle.bold14.copyWith(color: pollController.isMyPoll ? Colors.black : Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              pollController.refreshJoinedList();
                              pollController.changeRight();
                            },
                            child: Container(
                              width: (Get.width - 100) / 2,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(36)),
                                  color: pollController.isMyPoll ? CColor.deepBlueBlack : Colors.white),
                              child: Center(
                                child: Text(
                                  '내가 참여한 투표',
                                  style: CTextStyle.bold14.copyWith(color: pollController.isMyPoll ? Colors.white : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          if(indicatorController.isLoading)
          myIndicator()
        ],
      );
    });
  }
}
