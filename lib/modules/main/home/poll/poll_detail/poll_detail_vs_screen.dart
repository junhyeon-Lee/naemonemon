import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/calculator.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/share_link.dart';
import 'package:shovving_pre/util/sundry_widget/indicator/indicator.dart';
import 'pollDetail_calculator.dart';
import 'poll_detail_widget.dart';
import 'poll_detail_item_images_screen.dart';

class PollDetailVSScreen extends StatelessWidget {
  final int index;
  final int type;

  const PollDetailVSScreen({Key? key, required this.index, required this.type}) : super(key: key);

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
      onWillPop: () async {

        if(Get.find<PollDetailController>().isAddCartMode){
          Get.find<PollDetailController>().closeAddCartMode();
          return Future(() => false);
        }else{
          Get.find<PollDetailController>().pollDetailOut(2);
          return Future(() => true);
        }


      },
      child: GetBuilder<PollDetailController>(
          init: PollDetailController(),
          builder: (pollDetailController) {
            return Stack(
              children: [
                Scaffold(
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
                                CIconPath.pollDetailBase05,
                                fit: BoxFit.fill,
                              )),



                          Positioned(
                            top: 121.h,
                            left: 10.w,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(ItemImageViewScreen(
                                  imageList: fullImageList,
                                  selectedIndex: 0,
                                  imageListLength: imageListLength,
                                  splitPoint: splitPoint,
                                ));
                              },
                              child: ClipPath(
                                clipper: VSDetailImage(),
                                child: SizedBox(
                                  width: 183.w,
                                  height: 220.h,
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
                          ),
                          Positioned(
                            top: 121.h,
                            right: 10.w,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(ItemImageViewScreen(
                                  imageList: fullImageList,
                                  selectedIndex: 1,
                                  imageListLength: imageListLength,
                                  splitPoint: splitPoint,
                                ));
                              },
                              child: ClipPath(
                                clipper: VSDetailSecondImage(),
                                child: SizedBox(
                                  width: 183.w,
                                  height: 220.h,
                                  child: CachedNetworkImage(
                                    imageUrl: pollData.items[1].image ?? '',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: CColor.gray.withOpacity(0.3),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 64.h, //121.w+220.w+6.w,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    height: 42.w,
                                    child: pollData.items[0].title == 'poll item'
                                        ? Text(
                                      '직접 추가 한 이미지 입니다.',
                                      style: CTextStyle.heavy14.copyWith(height: 18 / 14, color: CColor.gray),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                        : GestureDetector(
                                      onTap: (){
                                        pollDetailController.seeDetailUrl(pollData.items[0].url);
                                      },
                                      child: Text(
                                        pollData.items[0].title ?? pollData.items[0].url,
                                        style: CTextStyle.heavy14.copyWith(height: 18 / 14, decoration: TextDecoration.underline),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  SizedBox(
                                    width: 160.w,
                                    height: 42.w,
                                    child: pollData.items[1].title == 'poll item'
                                        ? Text(
                                      '직접 추가 한 이미지 입니다.',
                                      style: CTextStyle.heavy14.copyWith(height: 18 / 14, color: CColor.gray),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                        : GestureDetector(
                                      onTap: (){
                                        pollDetailController.seeDetailUrl(pollData.items[1].url);
                                      },
                                      child: Text(
                                        pollData.items[1].title ?? pollData.items[1].url,
                                        style: CTextStyle.heavy14.copyWith(height: 18 / 14, decoration: TextDecoration.underline),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
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
                                        await pollDetailController.showDeleteBottomSheet(pollData);
                                      } else {
                                        pollDetailController.openAddCartMode();
                                      }
                                    },
                                    child: menuButton(1, 0, isMine, false,

                                        checkInMyCart(pollData.items[0].url)&&checkInMyCart(pollData.items[1].url)

                                    )),

                                // GestureDetector(
                                //     onTap: (){
                                //       pollDetailController.likeStateLocalAction(pollData.like, pollData.likeLength, pollData.id, index,type, 2);
                                //     },
                                //     child: menuButton(2, pollData.likeLength, isMine, pollData.like, false)),
                                Heart(like: pollData.like, likeCount: pollData.likeLength, pollId: pollData.id, index: index, type: type, type2: 2,),


                                GestureDetector(
                                    onTap: (){
                                      pollDetailController.changeCommentSheetState(1);
                                    },
                                    child: menuButton(3, pollData.comments.length, isMine, false, false)),
                              ],
                            ),
                          ),

                        ],
                      ),
                      //뒤로가기
                      Positioned(
                          top: 59.h,
                          left: 25.w,
                          child: GestureDetector(
                            onTap: () {

                              pollDetailController.pollDetailOut(2);
                              Get.back();

                            },
                            child: SvgPicture.asset(
                              CIconPath.back26p,
                              color: Colors.black,
                              width: 26,
                            ),
                          )),

                      if (pollData.finalChoice != null) isFinishedWidget(),



                      //메뉴 바


                      Positioned(
                        top: 468.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
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
                                          pollController.finalChoice(pollData, index, 0);
                                        }
                                      },
                                      child:
                                      mineJoinButton('A', pollData.finalChoice == null ? false : true)):
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
                                      child: vsJoinButton(true, pollData.joins, true)),




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
                                          pollController.finalChoice(pollData, index, 0);
                                        }
                                      },
                                      child:
                                      mineJoinButton('A', pollData.finalChoice == null ? false : true)):
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

                                          await pollDetailController.joinSocialPoll(pollData.id, tempJoinData, index,pollData.joins??[]);
                                        }
                                      },
                                      child: vsJoinButton(false, pollData.joins, true)),
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              CIconPath.pollDetailVSText,
                              width: 50.w,
                            ),
                          ],
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
                              color: pollData.numberOfVotes.reduce((a, b) => a + b) == 0 ? const Color(0xffFDDE6A) : CColor.brightGray,
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
                                            color: CColor.lavender,
                                          ),
                                          Container(
                                            width: (Get.width - 40.w) / pollData.numberOfVotes.reduce((a, b) => a + b) * pollData.numberOfVotes[1],
                                            height: 20.h,
                                            color: const Color(0xff71C587),
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

                      ///댓글   state 0: 보이지 않는 상태, staet:1 중간까지 보이는 상태, state:2 완전히 보이는 상태
                      GeneralCommentSheet(commentDataList: pollData.comments, itemImageList: itemsImageList, type: 2, index:index),
                      //vsCommentSheet(pollData.comments, itemsImageList),

                      ///댓글 입려창
                      if (pollDetailController.commentSheetState != 0&& pollDetailController.commentExtraSheetState==false
                      ) commentTextField(pollData, joinData, index, isMine, type),
                    ],
                  ),
                ),

                if(pollDetailController.isAddCartMode)
                Container(
                  width: Get.width, height: Get.height,
                  color: Colors.white.withOpacity(0.6),),

                if(pollDetailController.isAddCartMode)
                Positioned(
                  top: 121.h,
                  left: 10.w,
                  child: GestureDetector(
                    onTap: () {
                      checkInMyCart(pollData.items[0].url)?pollDetailController.alreadyInMyCart():
                      pollDetailController.addCartItem(pollData.items[0].url);
                      pollDetailController.closeAddCartMode();
                    },
                    child: ClipPath(
                      clipper: VSDetailImage(),
                      child: Stack(alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 183.w,
                            height: 220.h,
                            child: CachedNetworkImage(
                              imageUrl: pollData.items[0].image ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: CColor.gray.withOpacity(0.3),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          Container(width: 60, height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              border: Border.all(
                                  width: 4, color: checkInMyCart(pollData.items[0].url)?Colors.white.withOpacity(0.25):Colors.white),
                              color: checkInMyCart(pollData.items[0].url)?Colors.black.withOpacity(0.25):Colors.white.withOpacity(0.8),
                            ),
                            child: Center(
                              child: SvgPicture.asset(CIconPath.download30p),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                if(pollDetailController.isAddCartMode)
                Positioned(
                  top: 121.h,
                  right: 10.w,
                  child: GestureDetector(
                    onTap: () {
                      checkInMyCart(pollData.items[1].url)?pollDetailController.alreadyInMyCart():
                      pollDetailController.addCartItem(pollData.items[1].url);
                      pollDetailController.closeAddCartMode();
                    },
                    child: ClipPath(
                      clipper: VSDetailSecondImage(),
                      child: Stack(alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 183.w,
                            height: 220.h,
                            child: CachedNetworkImage(
                              imageUrl: pollData.items[1].image ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: CColor.gray.withOpacity(0.3),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(width: 60, height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                    border: Border.all(
                                        width: 4, color: checkInMyCart(pollData.items[1].url)?Colors.white.withOpacity(0.25):Colors.white),
                                  color: checkInMyCart(pollData.items[1].url)?Colors.black.withOpacity(0.25):Colors.white.withOpacity(0.8),



                                ),
                                child: Center(
                                  child: SvgPicture.asset(CIconPath.download30p),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                if(pollDetailController.isAddCartMode)
                Positioned(
                    top: 59.h,
                    left: 25.w,
                    child: GestureDetector(
                      onTap: () {
                          pollDetailController.closeAddCartMode();
                      },
                      child: SvgPicture.asset(
                        CIconPath.back26p,
                        color: Colors.black,
                        width: 26,
                      ),
                    )),


                if (indicatorController.isLoading) myIndicator()

              ],
            );
          }),
    );
  }
}

class VSDetailImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, 60.h)
      ..arcToPoint(Offset(60.h, 0), radius: const Radius.circular(60), largeArc: false)
      ..lineTo(size.width - 60.h, 0)
      ..arcToPoint(Offset(size.width, 70.h), radius: const Radius.circular(60), largeArc: false)
      ..lineTo(size.width - 12.h, size.height - 50.h)
      ..arcToPoint(Offset(115.h, size.height), radius: const Radius.circular(60), largeArc: false)
      ..lineTo(60.h, size.height)
      ..arcToPoint(Offset(0, size.height - 60.h), radius: const Radius.circular(60), largeArc: false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class VSDetailSecondImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width - 60.h, 0)
      ..arcToPoint(Offset(size.width, 60.h), radius: const Radius.circular(60), largeArc: false)
      ..lineTo(size.width, size.height - 60.h)
      ..arcToPoint(Offset(size.width - 60.h, size.height), radius: const Radius.circular(60), largeArc: false)
      ..lineTo(60.h, size.height)
      ..arcToPoint(Offset(0, size.height - 70.h), radius: const Radius.circular(60), largeArc: false)
      ..lineTo(12.h, 50.h)
      ..arcToPoint(Offset(70.h, 0), radius: const Radius.circular(60), largeArc: false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
