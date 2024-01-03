import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_widget.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/calculator.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/share_link.dart';
import 'package:shovving_pre/util/sundry_widget/indicator/indicator.dart';

import 'pollDetail_calculator.dart';
import 'poll_detail_controller.dart';
import 'poll_detail_item_images_screen.dart';

class PollDetailYNScreen extends StatelessWidget {
  final int index;
  final int type;

  const PollDetailYNScreen({Key? key, required this.index, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Poll? tempPoll;
    if(type == 1){
      tempPoll = pollController.myPollList[index];
    }
    else if(type == 2){
      tempPoll = feedController.feedList[index];
    }
    else if(type == 3){
      tempPoll = pollController.joinedPollList[index];
    }
    Poll pollData = tempPoll!;

    List<String> itemsImageList = getItemImage(pollData);
    List<List<String>> fullImageList = getFullImage(pollData);
    List<int> splitPoint = getSplitPoint(pollData, fullImageList);
    int imageListLength = getFullImageLength(pollData, fullImageList);
    List<int> joinData = getJoinData(pollData);
    bool isMine = pollData.userId == userInfoController.usersInfo?.id ? true : false;

    return WillPopScope(
      onWillPop: () {
        Get.find<PollDetailController>().pollDetailOut(3);
        return Future(() => true);
      },
      child: GetBuilder<PollDetailController>(
          init: PollDetailController(),
          builder: (pollDetailController) {
            return Stack(
              children: [
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  body: Stack(
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height,
                        color: Colors.white,
                      ),
                      //배경
                      Stack(
                        children: [
                          SizedBox(
                              height: 453.h,
                              child: SvgPicture.asset(
                                CIconPath.pollDetailBase06,
                                fit: BoxFit.fill,
                              )),
                          Positioned(
                            top: 111.h,
                            left: 50.w,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(ItemImageViewScreen(
                                      imageList: fullImageList,
                                      selectedIndex: 0,
                                      imageListLength: imageListLength,
                                      splitPoint: splitPoint,
                                    ));
                                  },
                                  child: ClipPath(
                                    clipper: YNDetailImage(),
                                    child: SizedBox(
                                      width: 290.w,
                                      height: 230.w,
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
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 10.h+50.h+4.h,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 45.w),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 300.w,
                                    height: 42.w,
                                    child: GestureDetector(
                                      onTap: (){
                                        pollDetailController.seeDetailUrl(pollData.items[0].url);
                                      },
                                      child: Text(
                                        pollData.items[0].title ?? pollData.items[0].url,
                                        style: CTextStyle.heavy14.copyWith(height: 18 / 14, decoration: TextDecoration.underline),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10.h,
                            left: 80.w,
                            child: Row(
                              children: [
                                GestureDetector(
                                    onTap:(){
                                      shareLink(pollData, pollData.pollComment);
                                    },
                                    child: menuButton(0, 0, isMine, false, false)),
                                GestureDetector(
                                    onTap: () async {
                                      if (isMine) {
                                        pollDetailController.showDeleteBottomSheet(pollData);
                                      } else {
                                        checkInMyCart(pollData.items[pollDetailController.selectedItemIndex].url)?pollDetailController.alreadyInMyCart():
                                        pollDetailController.addCartItem(pollData.items[0].url);
                                      }
                                    },
                                    child: menuButton(1, 0, isMine, false,checkInMyCart(pollData.items[pollDetailController.selectedItemIndex].url)  )),
                                // GestureDetector(
                                //     onTap: (){
                                //       pollDetailController.likeStateLocalAction(pollData.like, pollData.likeLength,pollData.id, index, type,2);
                                //     },
                                //     child: menuButton(2, pollData.likeLength, isMine, pollData.like, false),),

                                Heart(like: pollData.like, likeCount: pollData.likeLength, pollId: pollData.id, index: index, type: type, type2: 2,),
                                GestureDetector(
                                    onTap: (){
                                      pollDetailController.changeCommentSheetState(1);
                                    },
                                    child: menuButton(3, pollData.comments.length, isMine, false , false)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //뒤로가기


                      if (pollData.finalChoice != null) isFinishedWidget(),

                      //메뉴 바


                      Positioned(
                        top: 468.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              isMine?
                              GestureDetector(
                                  onTap: () async {
                                    if (pollData.finalChoice == null) {
                                      pollController.finalChoice(pollData, index, 0);
                                    }
                                  },
                                  child:
                                  mineJoinButton('A', pollData.finalChoice == null ? false : true)):
                              pollData.finalChoice != null?
                              GestureDetector(
                                  onTap: () async {
                                    if (pollData.finalChoice == null) {
                                      pollController.finalChoice(pollData, index, 1);
                                    }
                                  },
                                  child:
                                  mineJoinButton('B', pollData.finalChoice == null ? false : true)):
                              GestureDetector(
                                  onTap: () async {
                                    if (pollData.joins!.isEmpty) {
                                      List<int> tempJoinData = [1, 0];

                                      ///로컬 카운트 올리기
                                      List<int> tempNov = [];
                                      for(int i=0; i<pollData.numberOfVotes.length; i++){
                                        tempNov.add(pollData.numberOfVotes[i]+tempJoinData[i]);
                                      }
                                      if(type == 1){
                                        pollController.myPollList[index] = pollController.myPollList[index].copyWith(
                                          numberOfVotes: tempNov,
                                          joins: tempJoinData,
                                        );
                                      }
                                      else if(type == 2){
                                        feedController.feedList[index] = feedController.feedList[index].copyWith(
                                          numberOfVotes: tempNov,
                                          joins: tempJoinData,
                                        );
                                      }
                                      else if(type == 3){
                                        pollController.joinedPollList[index] = pollController.joinedPollList[index].copyWith(
                                          numberOfVotes: tempNov,
                                          joins: tempJoinData,
                                        );
                                      }

                                      pollDetailController.update();

                                      await pollDetailController.joinSocialPoll(pollData.id, tempJoinData, index, pollData.joins??[]);
                                    }
                                  },
                                  child: ynJoinButton(true, pollData.joins)),
                              SizedBox(
                                width: 30.w,
                              ),
                              isMine?
                              GestureDetector(
                                  onTap: () async {
                                    if (pollData.finalChoice == null) {
                                      pollController.finalChoice(pollData, index, 1);
                                    }
                                  },
                                  child:
                                  mineJoinButton('B', pollData.finalChoice == null ? false : true)):
                              pollData.finalChoice != null?
                              GestureDetector(
                                  onTap: () async {
                                    if (pollData.finalChoice == null) {
                                      pollController.finalChoice(pollData, index, 1);
                                    }
                                  },
                                  child:
                                  mineJoinButton('B', pollData.finalChoice == null ? false : true)):
                              GestureDetector(
                                  onTap: () async {
                                    if (pollData.joins!.isEmpty) {
                                      List<int> tempJoinData = [0, 1];

                                      ///로컬 카운트 올리기
                                      List<int> tempNov = [];
                                      for(int i=0; i<pollData.numberOfVotes.length; i++){
                                        tempNov.add(pollData.numberOfVotes[i]+tempJoinData[i]);
                                      }
                                      if(type == 1){
                                        pollController.myPollList[index] = pollController.myPollList[index].copyWith(
                                          numberOfVotes: tempNov,
                                          joins: tempJoinData,
                                        );
                                      }
                                      else if(type == 2){
                                        feedController.feedList[index] = feedController.feedList[index].copyWith(
                                          numberOfVotes: tempNov,
                                          joins: tempJoinData,
                                        );
                                      }
                                      else if(type == 3){
                                        pollController.joinedPollList[index] = pollController.joinedPollList[index].copyWith(
                                          numberOfVotes: tempNov,
                                          joins: tempJoinData,
                                        );
                                      }

                                      pollDetailController.update();

                                      await pollDetailController.joinSocialPoll(pollData.id, tempJoinData, index, pollData.joins??[]);
                                    }
                                  },
                                  child: ynJoinButton(false, pollData.joins)),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 558.h - 20.h - 12.h,
                        left: 20.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: Get.width - 40.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: pollData.numberOfVotes.reduce((a, b) => a + b) == 0 ? const Color(0xffFFE7F0) : CColor.brightGray,
                            ),
                            child: pollData.numberOfVotes.reduce((a, b) => a + b) == 0
                                ? Container()
                                : Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: (Get.width - 40.w) / pollData.numberOfVotes.reduce((a, b) => a + b) * pollData.numberOfVotes[0],
                                            height: 20.h,
                                            color: const Color(0xff19E4D0),
                                          ),
                                          Container(
                                            width: (Get.width - 40.w) / pollData.numberOfVotes.reduce((a, b) => a + b) * pollData.numberOfVotes[1],
                                            height: 20.h,
                                            color: const Color(0xff7080FC),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${pollData.numberOfVotes[0].toString()} (${100 - (pollData.numberOfVotes[1] / pollData.numberOfVotes.reduce((a, b) => a + b) * 100).toInt()}%)',
                                              style: CTextStyle.bold12.copyWith(color: Colors.black),
                                            ),
                                            Text(
                                              '${pollData.numberOfVotes[1].toString()} (${(pollData.numberOfVotes[1] / pollData.numberOfVotes.reduce((a, b) => a + b) * 100).toInt()}%)',
                                              style: CTextStyle.bold12.copyWith(color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      ),

                      ///하단부 여기를 기준으로 벌어지게 할 예정입니다.
                      commentNavigator(index, type, isMine),

                   AnimatedPositioned(
                              left: 20,
                              top: pollDetailController.isExpanded ? 558.h - 56.h : 558.h,
                              duration: const Duration(milliseconds: 100),
                              child: pollComment(pollData, type, index)),

                      if (pollDetailController.commentSheetState == 2)
                        Container(
                          width: Get.width,
                          height: Get.height,
                          color: Colors.black.withOpacity(0.3),
                        ),

                      ///댓글   state 0: 보이지 않는 상태, staet:1 중간까지 보이는 상태, state:2 완전히 보이는 상태  90   410
                      GeneralCommentSheet(commentDataList: pollData.comments, itemImageList: itemsImageList, type: 3, index:index),
                      //ynCommentSheet(pollData.comments, itemsImageList),

                      ///댓글 입려창
                      if (pollDetailController.commentSheetState != 0&& pollDetailController.commentExtraSheetState==false
                      ) commentTextField(pollData, joinData, index, isMine, type),

                      Positioned(
                          top: 59.h,
                          left: 25.w,
                          child: GestureDetector(
                            onTap: () {
                              Get.find<PollDetailController>().pollDetailOut(3);
                              Get.back();
                            },
                            child: SvgPicture.asset(
                              CIconPath.back26p,
                              color: Colors.black,
                              width: 26,
                            ),
                          )),


                    ],
                  ),
                ),
                if (indicatorController.isLoading) myIndicator()
              ],
            );
          }),
    );
  }
}

class YNDetailImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(70.w, 0)
      ..lineTo(size.width - 60.w, 0)
      ..arcToPoint(Offset(size.width, 60.w), radius: const Radius.circular(60), largeArc: false)
      ..lineTo(size.width - 10, size.height - 55.w)
      ..arcToPoint(Offset(size.width - 70.w, size.height), radius: const Radius.circular(60), largeArc: false)
      ..lineTo(60.w, size.height)
      ..arcToPoint(Offset(0, size.height - 60.w), radius: const Radius.circular(60), largeArc: false)
      ..lineTo(10.w, 60.w)
      ..arcToPoint(Offset(70.w, 0), radius: const Radius.circular(60), largeArc: false)
      // ..lineTo(size.width-60.h, 0)
      // ..arcToPoint(Offset(size.width, 70.h), radius: const Radius.circular(60), largeArc: false)
      // ..lineTo(size.width-12 .h, size.height-50.h)
      // ..arcToPoint(Offset(115. h, size.height), radius: const Radius.circular(60), largeArc: false)
      // ..lineTo(60.h, size.height)
      // ..arcToPoint(Offset(0, size.height-60.h ), radius: const Radius.circular(60), largeArc: false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
