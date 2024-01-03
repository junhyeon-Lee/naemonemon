import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/modules/main/home/poll/feed_screen/feed_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_repository.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/calculator.dart';
import 'package:shovving_pre/util/sundry_widget/indicator/indicator.dart';
import '../../../../../models/api_model/social/comment.dart';
import 'pollDetail_calculator.dart';
import 'poll_detail_controller.dart';
import 'poll_result_screen.dart';

Widget pollComment(Poll pollData, type, index) {

  TextEditingController pollCommentController = TextEditingController();
  pollCommentController.text = pollData.pollComment??'';

  return GetBuilder<PollDetailController>(builder: (pollDetailController) {
    bool isMine = pollData.userId == userInfoController.usersInfo?.id ? true : false;
    return GestureDetector(
      onTap: () {
        if (pollDetailController.isExpanded) {
          pollDetailController.pollCommentClose();
        } else {
          pollDetailController.pollCommentExpanded();
        }
      },
      child: AnimatedContainer(
        width: Get.width - 40,
        height: pollDetailController.isExpanded ? Get.height - 558.h - 19.h + 56.h : 62.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: CColor.brightGray,
        ),
        duration: const Duration(milliseconds: 100),
        child: pollDetailController.isExpanded
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          pollDetailController.pollCommentClose();
                          pollDetailController.pollReportState = false;
                          pollDetailController.update();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          height: pollDetailController.isExpanded ? Get.height - 558.h - 19.h + 56.h : 62.h,
                          child: Column(
                            children: [
                              ///54.h
                              Padding(
                                padding: EdgeInsets.fromLTRB(20.h, 20.h, 20.h, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (isMine)
                                      GestureDetector(
                                        onTap: () {
                                          pollDetailController.pollCommentClose();
                                          Get.bottomSheet(
                                            isScrollControlled:true,
                                            SizedBox(
                                              child: GestureDetector(
                                                onTap: (){
                                                  Get.back();
                                                },
                                                child: Container(height: Get.height-1, color: Colors.black.withOpacity(0.01),
                                                  child: Stack(alignment: Alignment.bottomCenter,
                                                    children: [
                                                      Container(width: Get.width, height: Get.height, color:Colors.black.withOpacity(0.01),
                                                      ),

                                                      Positioned(bottom: 66,
                                                        child: Container(

                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                                                              border: Border.all(width: 10, color: CColor.brightGray)
                                                          ),

                                                          width: Get.width-40, height: 256,
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                            child: TextField(
                                                              autofocus: true,
                                                              controller: pollCommentController,
                                                              maxLines: 11,
                                                              style: CTextStyle.light12.copyWith(color: Colors.black,height: 20/12),
                                                              decoration: const InputDecoration(
                                                                isDense: true,
                                                                border: InputBorder.none,
                                                              ),
                                                            ),
                                                          ),),
                                                      ),

                                                      Positioned(bottom: 10,
                                                        child: GestureDetector(

                                                          onTap: () async {
                                                            indicatorController.nowLoading();
                                                            pollDetailController.update();
                                                            Get.back();
                                                            PollRepository pollRepository = PollRepository();

                                                            await pollRepository.patchPollComment(pollData.id!, pollCommentController.text);
                                                            // Poll? patchedPoll = await pollRepository.getPollById(id);
                                                            if(type == 1){
                                                              pollController.myPollList[index] = pollController.myPollList[index].copyWith(
                                                                pollComment: pollCommentController.text,
                                                              );
                                                            }
                                                            else if(type == 2){
                                                              feedController.feedList[index] = feedController.feedList[index].copyWith(
                                                                pollComment: pollCommentController.text,
                                                              );
                                                            }
                                                            else if(type == 3){
                                                              pollController.joinedPollList[index] = pollController.joinedPollList[index].copyWith(
                                                                pollComment: pollCommentController.text,
                                                              );
                                                            }
                                                            indicatorController.completeLoading();
                                                            pollDetailController.update();
                                                            homeController.update();
                                                          },

                                                          child: Container(
                                                            width: Get.width-80, height: 46,

                                                            decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(36)),
                                                              color: Color(0xffF8408D),
                                                            ),

                                                            child: Center(
                                                              child: Text('수정하기',style: CTextStyle.eHeader20,),
                                                            ),

                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )

                                          );




                                        },
                                        child: Container(
                                          width: 120.w,
                                          height: 34.h,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(36)), color: Colors.black.withOpacity(0.8)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                CIconPath.edit,
                                                width: 26.w,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Text(
                                                '수정하기',
                                                style: CTextStyle.bold14.copyWith(height: 1, color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    else
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          SizedBox(
                                            width: Get.width - 120,
                                            height: 34.h,
                                          ),
                                          Positioned(
                                            left: 40,
                                            child: Text(
                                              pollData.user?.nickName ?? '',
                                              style: CTextStyle.bold14.copyWith(color: Colors.black),
                                            ),
                                          ),
                                          AnimatedContainer(
                                            width: pollDetailController.pollReportState ? Get.width - 120 : 34.h,
                                            height: 34.h,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(36)),
                                              color: Colors.black.withOpacity(0.8),
                                            ),
                                            duration: const Duration(milliseconds: 200),
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                if (pollDetailController.pollReportState)
                                                  SvgPicture.asset(
                                                    CIconPath.siren26P,
                                                    width: 26,
                                                  ),
                                                if (pollDetailController.pollReportState) const SizedBox(width: 4),
                                                if (pollDetailController.pollReportState)
                                                  GestureDetector(
                                                      onTap: () {
                                                        reportBottomSheet(pollData.userId, pollData.id, 2);
                                                        pollDetailController.pollReportState = false;
                                                      },
                                                      child: Text(
                                                        '신고하기',
                                                        style: CTextStyle.bold14.copyWith(color: Colors.white),
                                                      )),
                                              ],
                                            )),
                                          ),

                                          ///여기에 신고하기 걸기 타입 수정하기
                                          GestureDetector(
                                            onTap: () {
                                              safePrint('신고하기');
                                              pollDetailController.pollReportState
                                                  ? pollDetailController.pollReportState = false
                                                  : pollDetailController.pollReportState = true;
                                              pollDetailController.update();
                                            },
                                            child: Container(
                                              width: 34.h,
                                              height: 34.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(28.h)),
                                                border: Border.all(width: 2, color: Colors.white),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: pollData.user?.profileImage ?? '',
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => Container(
                                                  color: CColor.gray.withOpacity(0.3),
                                                ),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    Text(
                                      timeCalculator(pollData.createAt),
                                      style: CTextStyle.regular12.copyWith(color: const Color(0xff525252), height: 1),
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(
                                width: Get.width - 80,
                                height: Get.height - 558.h - 19.h + 56.h - 84.h,
                                child: Text(
                                  pollData.pollComment == '' ? '작성자가 본문 내용을 작성하지 않은 투표입니다.' : pollData.pollComment,
                                  style: CTextStyle.bold12.copyWith(color: pollData.pollComment == '' ? CColor.gray : Colors.black, height: 20 / 12),
                                ),
                              ),

                              ///30.h
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: GestureDetector(
                                  onTap: () {
                                    pollDetailController.pollCommentClose();
                                  },
                                  child: SizedBox(
                                    width: 60.w,
                                    height: 20.h,
                                    child: SvgPicture.asset(CIconPath.arrowUp20w),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: ExtendedText(
                    pollData.pollComment == '' ? '작성자가 본문 내용을 작성하지 않은 투표입니다.' : pollData.pollComment,
                    style: CTextStyle.bold12.copyWith(color: pollData.pollComment == '' ? CColor.gray : Colors.black, height: 20 / 12),
                    overflowWidget: TextOverflowWidget(
                      position: TextOverflowPosition.end,
                      child: SelectionContainer.disabled(
                        child: InkWell(
                          child: Text(
                            '...더 보기',
                            style: CTextStyle.bold12.copyWith(color: const Color(0xff525252), height: 20 / 12),
                          ),
                        ),
                      ),
                    ),
                    maxLines: pollDetailController.isExpanded ? null : 2,
                  ),
                ),
              ),
      ),
    );
  });
}

Widget joinButton(int type, bool isLeft, bool isJoin, int selectedIndex) {
  return Container(
    width: 160.w,
    height: 46.h,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(36)),
      color: isJoin ? Colors.white : const Color(0xffFEDB07),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isJoin
            ? SvgPicture.asset(
                CIconPath.checkItem,
                color: Colors.red,
                width: 36,
              )
            : Container(
                width: 20.h,
                height: 20.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(36)),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    alphabetList[selectedIndex],
                    style: CTextStyle.heavy10,
                  ),
                )),
        SizedBox(
          width: 12.w,
        ),
        isJoin
            ? Text(
                '내 선택',
                style: CTextStyle.bold20.copyWith(color: Colors.black),
              )
            : Text(
                '투표하기',
                style: CTextStyle.bold20,
              )
      ],
    ),
  );
}

Widget vsJoinButton(bool isLeft, List<int>? joins, bool isSelected) {
  bool myChoice = false;

  List<int> joinList = joins ?? [];
  if (joinList.length == 2) {
    if (isLeft) {
      if (joinList[0] == 1) {
        myChoice = true;
      }
    } else {
      if (joinList[1] == 1) {
        myChoice = true;
      }
    }
  }

  if (joinList.length == 2) {
    return Container(
      width: 160.w,
      height: 46.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(36)),
        color: myChoice ? Colors.white : CColor.brightGray,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (myChoice)
            SvgPicture.asset(
              CIconPath.checkItem,
              color: const Color(0xffFF2E7E),
              width: 36,
            ),
          if (myChoice)
            SizedBox(
              width: 12.w,
            ),
          Text(
            myChoice ? '내 선택' : '선택 안 함',
            style: CTextStyle.bold20.copyWith(color: myChoice ? Colors.black : CColor.gray),
          )
        ],
      ),
    );
  } else {
    return Container(
      width: 160.w,
      height: 46.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(36)),
        color: isLeft ? CColor.mainPurple : const Color(0xff71C587),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 20.h,
              height: 20.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  isLeft ? 'A' : 'B',
                  style: CTextStyle.heavy10,
                ),
              )),
          SizedBox(
            width: 12.w,
          ),
          joinList.length == 2
              ? //myChoice
              Text(
                  myChoice ? '내 선택' : '선택 안 함',
                  style: CTextStyle.bold20,
                )
              : Text(
                  '투표하기',
                  style: CTextStyle.bold20,
                )
        ],
      ),
    );
  }
}

Widget ynJoinButton(bool isLeft, List<int>? joins) {
  bool myChoice = false;

  List<int> joinList = joins ?? [];
  if (joinList.length == 2) {
    if (isLeft) {
      if (joinList[0] == 1) {
        myChoice = true;
      }
    } else {
      if (joinList[1] == 1) {
        myChoice = true;
      }
    }
  }

  if (joinList.length == 2) {
    return Container(
      width: 160.w,
      height: 46.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(36)),
        color: myChoice ? Colors.white : CColor.brightGray,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (myChoice)
            SvgPicture.asset(
              CIconPath.checkItem,
              color: const Color(0xffFF2E7E),
              width: 36,
            ),
          if (myChoice)
            SizedBox(
              width: 12.w,
            ),
          Text(
            myChoice ? '내 선택' : '선택 안 함',
            style: CTextStyle.bold20.copyWith(color: myChoice ? Colors.black : CColor.gray),
          )
        ],
      ),
    );
  } else {
    return Container(
      width: 160.w,
      height: 46.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(36)),
        color: isLeft ? const Color(0xff19E4D0) : const Color(0xff7080FC),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 20.h,
              height: 20.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  isLeft ? 'A' : 'B',
                  style: CTextStyle.heavy10,
                ),
              )),
          SizedBox(
            width: 12.w,
          ),
          joinList.length == 2
              ? //myChoice
              Text(
                  myChoice ? '내 선택' : '선택 안 함',
                  style: CTextStyle.bold20,
                )
              : Text(
                  isLeft ? '산다' : '안 산다',
                  style: CTextStyle.bold20,
                )
        ],
      ),
    );
  }
}

Widget mineJoinButton(String item, bool isFinished) {
  return Container(
    width: 160.w,
    height: 46.h,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(36)),
      color: isFinished ? CColor.brightGray : const Color(0xffF8408D),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isFinished == false)
          Container(
              width: 20.h,
              height: 20.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  item,
                  style: CTextStyle.heavy10,
                ),
              )),
        if (isFinished == false)
          SizedBox(
            width: 12.w,
          ),
        Text(
          isFinished ? '종료 됨' : '최종 선택',
          style: CTextStyle.bold20.copyWith(color: isFinished ? CColor.gray : Colors.white),
        )
      ],
    ),
  );
}

Widget rightMenuButton(int index, int data, bool isMine, bool like, bool isAlreadyCart) {
  List<String> tagList = ['공유하기', isMine ? '투표삭제' : '카드담기'];
  List<String> tagPath = [
    CIconPath.share30p,
    isMine ? CIconPath.delete : CIconPath.download30p,
    like ? CIconPath.heartOn30p : CIconPath.heartOff30p,
    CIconPath.comment30p
  ];

  String tag = '';
  String path = '';
  path = tagPath[index];
  switch (index) {
    case 0:
      tag = tagList[index];
      break;
    case 1:
      tag = tagList[index];
      break;
    case 2:
      tag = data.toString();
      break;
    case 3:
      tag = data.toString();
      break;
  }

  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: SizedBox(
      width: 50,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              path,
              width: 30,
              color: like
                  ? const Color(0xffFF2E7E)
                  : isAlreadyCart
                      ? Colors.black.withOpacity(0.25)
                      : Colors.black,
            ),
            Text(
              tag,
              style: CTextStyle.bold10.copyWith(height: 12 / 10),
            )
          ],
        ),
      ),
    ),
  );
}

Widget menuButton(int index, int data, bool isMine, bool like, bool isAlreadyCart) {
  List<String> tagList = ['공유하기', isMine ? '투표삭제' : '카드담기'];
  List<String> tagPath = [
    CIconPath.share30p,
    isMine ? CIconPath.delete : CIconPath.download30p,
    like ? CIconPath.heartOn30p : CIconPath.heartOff30p,
    CIconPath.comment30p
  ];

  String tag = '';
  String path = '';
  path = tagPath[index];
  switch (index) {
    case 0:
      tag = tagList[index];
      break;
    case 1:
      tag = tagList[index];
      break;
    case 2:
      tag = data.toString();
      break;
    case 3:
      tag = data.toString();
      break;
  }

  return Padding(
    padding: EdgeInsets.only(right: 10.w),
    child: SizedBox(
      width: 50.w,
      height: 50.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              path,
              width: 30,
              color: like
                  ? const Color(0xffFF2E7E)
                  : isMine
                      ? Colors.black
                      : isAlreadyCart
                          ? Colors.black.withOpacity(0.25)
                          : Colors.black,
            ),
            Text(
              tag,
              style: CTextStyle.bold10.copyWith(height: 12 / 10),
            )
          ],
        ),
      ),
    ),
  );
}

class Heart extends StatefulWidget {
  const Heart(
      {Key? key, required this.like, required this.likeCount, required this.pollId, required this.index, required this.type, required this.type2})
      : super(key: key);

  final bool like;
  final int likeCount;

  final int pollId;
  final int index;
  final int type;
  final int type2;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  /// Is the animation currently playing?

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final pollDetailController = Get.find<PollDetailController>();
        if (widget.like) {
          pollDetailController.likeRiveState = false;
        } else {
          pollDetailController.likeRiveState = true;
        }
        pollDetailController.update();
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PollDetailController>(builder: (pollDetailController) {
      if (pollDetailController.likeRiveState) {
        return GestureDetector(
          onTap: () async {
            safePrint('heart');
            pollDetailController.likeRiveState = false;
            pollDetailController.update();
            pollDetailController.likeStateLocalAction(widget.like, widget.likeCount, widget.pollId, widget.index, widget.type, widget.type2);
          },
          child: SizedBox(
            width: 50.w,
            height: 50.w,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(CIconPath.heartOff30p,width: 30.w,),
                  Text(
                    widget.likeCount.toString(),
                    style: CTextStyle.bold10.copyWith(height: 12 / 10),
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return GestureDetector(
          onTap: () async {
            safePrint('heartOff');

              pollDetailController.likeRiveState = true;
              pollDetailController.update();

            pollDetailController.likeStateLocalAction(widget.like, widget.likeCount, widget.pollId, widget.index, widget.type, widget.type2);
          },
          child: SizedBox(
            width: 50.w,
            height: 50.w,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(CIconPath.heartOn30p,width: 30.w,),
                  Text(
                    widget.likeCount.toString(),
                    style: CTextStyle.bold10.copyWith(height: 12 / 10),
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}

Widget commentBlind() {
  return SizedBox(
    width: Get.width,
    height: 188.h,
    child: Stack(
      children: [
        SvgPicture.asset(
          CIconPath.pollDetailBase04,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(45, 69, 45, 0),
          child: Text(
            '투표에 참여하시면 결과와 대글을 확인하실 수 있어요.',
            style: CTextStyle.bold19.copyWith(color: CColor.gray),
          ),
        )
      ],
    ),
  );
}

class GeneralCommentSheet extends StatefulWidget {
  const GeneralCommentSheet({Key? key, required this.commentDataList, required this.itemImageList, required this.type, required this.index})
      : super(key: key);

  final List<Comment> commentDataList;
  final List<String> itemImageList;
  final int type;
  final int index;

  @override
  State<GeneralCommentSheet> createState() => _GeneralCommentSheetState();
}

class _GeneralCommentSheetState extends State<GeneralCommentSheet> {
  // 1: general 2: vs 3:yn
  List<Comment> commentData = [];
  List<bool> commentExpandedOrigin = [];

  @override
  void initState() {
    if (commentData.isEmpty) {
      for (int i = 0; i < widget.commentDataList.length; i++) {
        commentData.add(widget.commentDataList[i]);
        commentData[i] = commentData[i].copyWith(like: myStateCommentLike(commentData[i].likes), likeLength: commentData[i].likes.length);
        commentExpandedOrigin.add(false);
      }
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PollDetailController>(builder: (pollDetailController) {
      double state1Height = 502.h;
      if (widget.type != 1) {
        state1Height = 453.h;
      }

      if (commentData.isEmpty || commentData.length != widget.commentDataList.length) {
        safePrint('함수가 돈다');
        commentData = [];
        commentExpandedOrigin = [];
        for (int i = 0; i < widget.commentDataList.length; i++) {
          commentData.add(widget.commentDataList[i]);
          commentData[i] = commentData[i].copyWith(like: myStateCommentLike(commentData[i].likes), likeLength: commentData[i].likes.length);
          commentExpandedOrigin.add(false);
        }
      }

      return AnimatedPositioned(
        duration: const Duration(milliseconds: 150),
        top: pollDetailController.commentSheetState == 0
            ? Get.height
            : pollDetailController.commentSheetState == 1
                ? state1Height
                : pollDetailController.commentSheetState == 2
                    ? 90.h
                    : null,
        child: GestureDetector(
          onPanUpdate: (details) {
            // Swiping in right direction.
            if (details.delta.dy > 10) {
              pollDetailController.changeCommentSheetState(0);
            }

            // Swiping in left direction.
            if (details.delta.dy < -10) {
              pollDetailController.changeCommentSheetState(2);
            }
          },
          child: Container(
            width: Get.width,
            height: Get.height - 90.h,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 60.w,
                  height: 6.h,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: Get.width,
                      ),
                      Text(
                        '댓글',
                        style: CTextStyle.light20.copyWith(height: 26 / 20),
                      ),
                      if (widget.commentDataList.isNotEmpty && widget.type != 1)
                        Positioned(
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () async {
                                pollDetailController.openExtraSheet();
                                if (pollDetailController.commentExtraRiveState) {
                                    pollDetailController.commentExtraRiveState = false;
                                    pollDetailController.update();
                                } else {
                                    pollDetailController.commentExtraRiveState = true;
                                    pollDetailController.update();
                                }
                              },
                              child: pollDetailController.commentExtraRiveState
                                  ?
                              SvgPicture.asset(CIconPath.commentModeE,width: 74,):
                              SvgPicture.asset(CIconPath.commentModeG,width: 74,)
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                pollDetailController.commentExtraSheetState == false
                    ? SizedBox(
                        width: Get.width,
                        height: Get.height - 106.h - 36 - MediaQuery.of(context).viewInsets.bottom,
                        child: commentData.isEmpty
                            ? Column(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 100),
                                    height: pollDetailController.commentSheetState == 2 ? (Get.height - 106.h - 36 - 56) / 2 : 70,
                                  ),
                                  const SizedBox(height: 56, child: Text('아직 댓글이 없어요.\n첫 댓글의 주인공이 되어 보세요!')),
                                ],
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: ScrollConfiguration(
                                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: commentData.length,
                                      itemBuilder: (BuildContext ctx, int index) {
                                        ///조인을 가지고 그거를 해야하지요

                                        List<String> sideString = commentData[index].side.split(',');
                                        List<int> side = [];

                                        for (int i = 0; i < sideString.length; i++) {
                                          if (sideString[i] == '1') {
                                            side.add(i);
                                          }
                                        }

                                        return Padding(
                                          padding: index == 0 ? const EdgeInsets.fromLTRB(30, 10, 30, 10) : const EdgeInsets.fromLTRB(30, 0, 30, 10),
                                          child: Container(
                                            height: 79,
                                            color: Colors.white,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  right: 0,
                                                  top: 7,
                                                  child: SizedBox(
                                                    width: 174,
                                                    height: 36,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          right: 46,
                                                          child: Text(
                                                            timeCalculator(
                                                              commentData[index].createdAt,
                                                            ),
                                                            style: CTextStyle.regular12.copyWith(height: 20 / 12, color: CColor.gray),
                                                          ),
                                                        ),
                                                        if (side.contains(1) && widget.type != 3)
                                                          CommentExpandedWidget(
                                                            side: side,
                                                            itemImageList: widget.itemImageList,
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Stack(
                                                  alignment: Alignment.centerLeft,
                                                  children: [

                                                    AnimatedContainer(
                                                      width: commentExpandedOrigin[index] ? Get.width - 100 : 34,
                                                      height: 34,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(36)),
                                                        color: Colors.black.withOpacity(0.8),
                                                      ),
                                                      duration: const Duration(milliseconds: 200),
                                                      child: Center(
                                                          child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          if (commentExpandedOrigin[index])
                                                            SvgPicture.asset(
                                                              CIconPath.siren26P,
                                                              width: 26,
                                                            ),
                                                          const SizedBox(width: 4),
                                                          if (commentExpandedOrigin[index])
                                                            GestureDetector(
                                                                onTap: () {
                                                                  reportBottomSheet(commentData[index].user.id, commentData[index].id, 1);

                                                                  ///확장 초기화
                                                                  commentExpandedOrigin = [];
                                                                  for (int i = 0; i < widget.commentDataList.length; i++) {
                                                                    commentExpandedOrigin.add(false);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  '신고하기',
                                                                  style: CTextStyle.bold14.copyWith(color: Colors.white),
                                                                )),
                                                        ],
                                                      )),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          commentExpandedOrigin[index]
                                                              ? commentExpandedOrigin[index] = false
                                                              : commentExpandedOrigin[index] = true;
                                                          setState(() {});
                                                        },
                                                        child: profileImageCircle(commentData[index].user.profileImage ?? '')),
                                                  ],
                                                ),
                                                Positioned(left: 40, top: 9, child: Text(commentData[index].user.nickName ?? '')),
                                                Positioned(left: 10, top: 40, child: Text(commentData[index].comment)),

                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 3),
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              if (commentData[index].like == null) {
                                                                commentData[index] = commentData[index]
                                                                    .copyWith(like: true, likeLength: commentData[index].likeLength! + 1);
                                                              } else if (commentData[index].like!) {
                                                                commentData[index] = commentData[index]
                                                                    .copyWith(like: false, likeLength: commentData[index].likeLength! - 1);
                                                              } else {
                                                                commentData[index] = commentData[index]
                                                                    .copyWith(like: true, likeLength: commentData[index].likeLength! + 1);
                                                              }

                                                              pollDetailController.update();
                                                              pollDetailController.commentLike(commentData[index].id);
                                                            },
                                                            child: SvgPicture.asset(
                                                              commentData[index].like ?? false ? CIconPath.heartOn30p : CIconPath.heartOff30p,
                                                              width: 20,
                                                            )),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        commentData[index].likeLength.toString(),
                                                        style: CTextStyle.bold10,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                      )
                    : widget.type == 2
                        ? vsCommentSheet(widget.commentDataList, widget.itemImageList)
                        : ynCommentSheet(widget.commentDataList, widget.itemImageList),
              ],
            ),
          ),
        ),
      );
    });
  }
}

///추후 추가할 소트버전 제너럴의 안에 이들을 추가할 예정
Widget vsCommentSheet(List<Comment> commentData, List<String> itemImageList) {
  return GetBuilder<PollDetailController>(builder: (pollDetailController) {
    ///코멘트 데이터 분할
    List<Comment> leftComment = [];
    List<Comment> rightComment = [];

    for (int i = 0; i < commentData.length; i++) {
      if (commentData[i].side == '1,0') {
        leftComment.add(commentData[i]);
      } else {
        rightComment.add(commentData[i]);
      }
    }

    return GestureDetector(
      onPanUpdate: (details) {
        // Swiping in right direction.
        if (details.delta.dy > 10) {
          pollDetailController.changeCommentSheetState(0);
        }

        // Swiping in left direction.
        if (details.delta.dy < -10) {
          pollDetailController.changeCommentSheetState(2);
        }
      },
      child: Container(
        width: Get.width,
        height: Get.height - 106.h - 36,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            if (pollDetailController.commentSheetState == 2)
              SizedBox(
                width: Get.width,
                height: 124,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 59),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: CColor.lemon,
                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                  border: Border.all(width: 4, color: CColor.lemon)),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                                child: CachedNetworkImage(
                                  imageUrl: itemImageList[0],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: CColor.gray.withOpacity(0.3),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: Get.width - 160 - 59 - 59,
                                height: 2,
                                color: CColor.lemon,
                              ),
                              SvgPicture.asset(
                                CIconPath.pollDetailVSText,
                                width: 50.w,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 59),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: CColor.lemon,
                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                  border: Border.all(width: 4, color: CColor.lemon)),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                                child: CachedNetworkImage(
                                  imageUrl: itemImageList[1],
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
                  ],
                ),
              ),
            if (commentData.isEmpty)
              Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: pollDetailController.commentSheetState == 2 ? (Get.height - 106.h - 36 - 56) / 2 : 70,
                  ),
                  const SizedBox(height: 56, child: Text('아직 댓글이 없어요.\n첫 댓글의 주인공이 되어 보세요!')),
                ],
              )
            else
              Row(
                children: [
                  SizedBox(
                    width: (Get.width) / 2,
                    height: Get.height - 106.h - 36 - 124,
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: leftComment.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(12, 10, 5, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                    color: CColor.lavender,
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(20, 50, 10, 34),
                                            child: Text(leftComment[index].comment),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 10,
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            profileImageCircle(leftComment[index].user.profileImage ?? ''),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(leftComment[index].user.nickName ?? ''),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: 0,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 3),
                                              child: SvgPicture.asset(
                                                CIconPath.heartOff30p,
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              leftComment[index].likes.length.toString(),
                                              style: CTextStyle.bold10,
                                            ),
                                            const SizedBox(width: 16),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: index == 0 ? const EdgeInsets.fromLTRB(22, 10, 15, 10) : const EdgeInsets.fromLTRB(22, 0, 15, 10),
                                child: Container(
                                  color: Colors.white,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 40, 10, 24),
                                            child: Text(leftComment[index].comment),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          profileImageCircle(leftComment[index].user.profileImage ?? ''),
                                          Text(leftComment[index].user.nickName ?? ''),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 3),
                                              child: SvgPicture.asset(
                                                CIconPath.heartOff30p,
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              leftComment[index].likes.length.toString(),
                                              style: CTextStyle.bold10,
                                            ),
                                            const SizedBox(width: 6),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                  SizedBox(
                    width: (Get.width) / 2,
                    height: Get.height - 106.h - 36 - 124,
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: rightComment.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 12, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                    color: CColor.grassGreen,
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(20, 50, 10, 34),
                                            child: Text(rightComment[index].comment),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 10,
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            profileImageCircle(rightComment[index].user.profileImage ?? ''),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(rightComment[index].user.nickName ?? ''),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: 0,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 3),
                                              child: SvgPicture.asset(
                                                CIconPath.heartOff30p,
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              rightComment[index].likes.length.toString(),
                                              style: CTextStyle.bold10,
                                            ),
                                            const SizedBox(width: 16),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 22, 10),
                                child: Container(
                                  color: Colors.white,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 40, 10, 24),
                                            child: Text(rightComment[index].comment),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          profileImageCircle(rightComment[index].user.profileImage ?? ''),
                                          Text(rightComment[index].user.nickName ?? ''),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 3),
                                              child: SvgPicture.asset(
                                                CIconPath.heartOff30p,
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              rightComment[index].likes.length.toString(),
                                              style: CTextStyle.bold10,
                                            ),
                                            const SizedBox(width: 6),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  });
}

Widget ynCommentSheet(List<Comment> commentData, List<String> itemImageList) {
  return GetBuilder<PollDetailController>(builder: (pollDetailController) {
    ///코멘트 데이터 분할
    List<Comment> leftComment = [];
    List<Comment> rightComment = [];

    for (int i = 0; i < commentData.length; i++) {
      if (commentData[i].side == '1,0' || commentData[i].side == '1') {
        leftComment.add(commentData[i]);
      } else {
        rightComment.add(commentData[i]);
      }
    }

    return GestureDetector(
      onPanUpdate: (details) {
        // Swiping in right direction.
        if (details.delta.dy > 10) {
          pollDetailController.changeCommentSheetState(0);
        }

        // Swiping in left direction.
        if (details.delta.dy < -10) {
          pollDetailController.changeCommentSheetState(2);
        }
      },
      child: Container(
        width: Get.width,
        height: Get.height - 106.h - 36,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SizedBox(
                        width: (Get.width - 34) / 2,
                        height: 54,
                        child: CustomPaint(
                          size: Size((Get.width - 34) / 2, 54),
                          painter: const YnPopularCommentPainter(Color(0xff19E4D0), true),
                        ),
                      ),
                      Container(
                        width: (Get.width - 34) / 2 / 2,
                        height: 54 - 16,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                          left: ((Get.width - 34) / 4 - 38) / 2,
                          child: SizedBox(
                              width: 38,
                              height: 36,
                              child: Center(
                                  child: Text(
                                '산다',
                                style: CTextStyle.bold20.copyWith(color: Colors.black),
                              )))),
                      Positioned(
                          right: 10,
                          top: 8,
                          child: Text(
                            '${(leftComment.length / (leftComment.length + rightComment.length) * 100).ceil()}%',
                            style: CTextStyle.bold22.copyWith(color: const Color(0xff19E4D0), height: 24 / 22),
                          ))
                    ],
                  ),
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      SizedBox(
                        width: (Get.width - 34) / 2,
                        height: 54,
                        child: CustomPaint(
                          size: Size((Get.width - 34) / 2, 54),
                          painter: const YnPopularCommentPainter(Color(0xff7080FC), false),
                        ),
                      ),
                      Container(
                        width: (Get.width - 34) / 2 / 2,
                        height: 54 - 16,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                          right: ((Get.width - 34) / 4 - 62) / 2,
                          child: SizedBox(
                              width: 62,
                              height: 36,
                              child: Center(
                                  child: Text(
                                '안 산다',
                                style: CTextStyle.bold20.copyWith(color: Colors.black),
                              )))),
                      Positioned(
                          left: 10,
                          top: 8,
                          child: Text(
                            '${(rightComment.length / (leftComment.length + rightComment.length) * 100).ceil()}%',
                            style: CTextStyle.bold22.copyWith(color: const Color(0xff7080FC), height: 24 / 22),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            if (commentData.isEmpty)
              Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: pollDetailController.commentSheetState == 2 ? (Get.height - 106.h - 36 - 56) / 2 : 70,
                  ),
                  const SizedBox(height: 56, child: Text('아직 댓글이 없어요.\n첫 댓글의 주인공이 되어 보세요!')),
                ],
              )
            else
              Row(
                children: [
                  SizedBox(
                    width: (Get.width) / 2,
                    height: Get.height - 106.h - 36 - 54 - 24,
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: leftComment.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            if (index == 0) {
                              return Padding(
                                padding: index == 0 ? const EdgeInsets.fromLTRB(12, 0, 5, 10) : const EdgeInsets.fromLTRB(22, 0, 5, 10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xff19E4D0),
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(20, 40, 10, 34),
                                            child: Text(leftComment[index].comment),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          profileImageCircle(leftComment[index].user.profileImage ?? ''),
                                          Text(leftComment[index].user.nickName ?? ''),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: 0,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 3),
                                              child: SvgPicture.asset(
                                                CIconPath.heartOff30p,
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              leftComment[index].likes.length.toString(),
                                              style: CTextStyle.bold10,
                                            ),
                                            const SizedBox(width: 6),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: index == 0 ? const EdgeInsets.fromLTRB(22, 10, 5, 10) : const EdgeInsets.fromLTRB(22, 0, 15, 10),
                                child: Container(
                                  color: Colors.white,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 40, 10, 24),
                                            child: Text(leftComment[index].comment),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          profileImageCircle(leftComment[index].user.profileImage ?? ''),
                                          Text(leftComment[index].user.nickName ?? ''),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 3),
                                              child: SvgPicture.asset(
                                                CIconPath.heartOff30p,
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              leftComment[index].likes.length.toString(),
                                              style: CTextStyle.bold10,
                                            ),
                                            const SizedBox(width: 6),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                  SizedBox(
                    width: (Get.width) / 2,
                    height: Get.height - 106.h - 36 - 54 - 24,
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: rightComment.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            if (index == 0) {
                              return Padding(
                                padding: index == 0 ? const EdgeInsets.fromLTRB(5, 0, 12, 10) : const EdgeInsets.fromLTRB(5, 0, 22, 10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xff7080FC),
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(20, 40, 10, 34),
                                            child: Text(rightComment[index].comment),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          profileImageCircle(rightComment[index].user.profileImage ?? ''),
                                          Text(rightComment[index].user.nickName ?? ''),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: 0,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 3),
                                              child: SvgPicture.asset(
                                                CIconPath.heartOff30p,
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              rightComment[index].likes.length.toString(),
                                              style: CTextStyle.bold10,
                                            ),
                                            const SizedBox(width: 6),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: index == 0 ? const EdgeInsets.fromLTRB(5, 10, 22, 10) : const EdgeInsets.fromLTRB(15, 0, 22, 10),
                                child: Container(
                                  color: Colors.white,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 40, 10, 24),
                                            child: Text(rightComment[index].comment),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          profileImageCircle(rightComment[index].user.profileImage ?? ''),
                                          Text(rightComment[index].user.nickName ?? ''),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 3),
                                              child: SvgPicture.asset(
                                                CIconPath.heartOff30p,
                                                width: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              rightComment[index].likes.length.toString(),
                                              style: CTextStyle.bold10,
                                            ),
                                            const SizedBox(width: 6),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  });
}

Widget commentTextField(Poll pollData, List<int> joinData, index, bool isMine, int pollType) {
  //pollType 1: 마이, 2:피드 3: 조인드
  final focusNode = FocusScopeNode();
  FocusNode textFocus = FocusNode();
  safePrint('@@@@@@@@@@@@@');
  safePrint('조인은 항상 존재하는가');
  safePrint(joinData);
  safePrint('@@@@@@@@@@@@@');

  Color buttonColor = const Color(0xffFDDE6A);

  if(joinData.length>2){
    ///제너럴이면 오렌지
    buttonColor = const Color(0xffF8A940);
  }else{

    if(pollData.items.length==1){
      //ox라면
      if(joinData.contains(1)){
        if(joinData[0]==1){
          buttonColor = const Color(0xff19E4D0);
        }else{
          buttonColor = const Color(0xff7080FC);
        }
      }


    }else{
      //vs라면
      if(joinData.contains(1)){

        if(joinData[0]==1){
          buttonColor = CColor.lavender;
        }else{
          buttonColor = CColor.grassGreen;
        }

      }

    }

  }



  return GetBuilder<PollDetailController>(builder: (pollDetailController) {
    return Positioned(
        bottom: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: Get.width - 40,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              border: Border.all(width: 1, color: const Color(0xffE0E0E0)),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: Get.width - 40 - 10 - 20 - 20 - 24,
                    child: FocusScope(
                      node: focusNode,
                      child: TextField(
                        focusNode: textFocus,
                        controller: pollDetailController.commentTextController,
                        style: CTextStyle.light12.copyWith(color: const Color(0xff525252)),
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: '댓글 작성 하기',
                          hintStyle: CTextStyle.light12.copyWith(color: const Color(0xff525252)),
                        ),
                        onTap: () {
                          pollDetailController.changeCommentSheetState(2);
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () async {
                      pollDetailController.postComment(pollData.id, pollDetailController.commentTextController.text, joinData, index, pollType);
                      pollDetailController.commentTextController.clear();
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(color: buttonColor, borderRadius: const BorderRadius.all(Radius.circular(34))),
                      child: Center(
                          child: SvgPicture.asset(
                        CIconPath.arrowRight24p,
                        width: 24,
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  });
}

Widget profileImageCircle(String imageUrl) {
  return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.white), borderRadius: const BorderRadius.all(Radius.circular(34))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: SizedBox(
          width: 30.w,
          height: 30.w,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: CColor.gray.withOpacity(0.3),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ));
}

Widget isFinishedWidget() {
  return Positioned(
      top: 59.h,
      left: Get.width / 2 - 45,
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: 90,
          height: 26,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            border: Border.all(width: 1, color: Colors.black),
            color: Colors.black.withOpacity(0.8),
          ),
          child: Center(
              child: Text(
            '종료 됨',
            style: CTextStyle.bold16.copyWith(color: Colors.white, height: 1),
          )),
        ),
      ));
}

Widget commentNavigator(int index, int type, bool isMine) {
  Poll? tempPoll;
  if (type == 1) {
    tempPoll = pollController.myPollList[index];
  } else if (type == 2) {
    tempPoll = feedController.feedList[index];
  } else if (type == 3) {
    tempPoll = pollController.joinedPollList[index];
  }

  Poll pollData = tempPoll!;

  return GetBuilder<FeedController>(builder: (feedControllear) {
    return Positioned(
      bottom: 0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: Get.width,
            height: 216.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
              color: CColor.brightGray,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.find<PollDetailController>().changeCommentSheetState(1);
                    },
                    child: pollData.comments.isEmpty
                        ?

                        ///댓글 없음 위젯
                        Container(
                            width: (Get.width - 50) / 2,
                            height: 168.h,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(60)),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Text(
                                  '아직 댓글이 없어요. 첫 댓글의 주인공이 되어 보세요!',
                                  style: CTextStyle.light14.copyWith(height: 28 / 14, decoration: TextDecoration.underline),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        :

                        ///인기댓글 위젯
                        Container(
                            width: (Get.width - 50) / 2,
                            height: 168.h,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(60)),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  '인기 댓글',
                                  style: CTextStyle.heavy16,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 28.h,
                                      height: 28.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(28.h)),
                                        border: Border.all(width: 2, color: Colors.white),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: pollData.comments[0].user.profileImage ?? '',
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(
                                          color: CColor.gray.withOpacity(0.3),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Text(
                                      pollData.comments[0].user.nickName ?? '',
                                      style: CTextStyle.bold12.copyWith(color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      pollData.comments[0].comment ?? '',
                                      style: CTextStyle.light12.copyWith(color: Colors.black, height: 14 / 12),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      CIconPath.heartOff30p,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 6.h,
                                    ),
                                    Text(
                                      '37',
                                      style: CTextStyle.bold12.copyWith(color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                              ],
                            ),
                          ),
                  ),
                  if (mostVotes(pollData.numberOfVotes) == null)
                    Container(
                      width: (Get.width - 50) / 2,
                      height: 168.h,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Text(
                            '아직 투표가 없어요. 첫 투표로 당신의\n센스를 보여주세요!',
                            style: CTextStyle.light14.copyWith(
                              height: 28 / 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        pollResultScreen(pollData);
                      },
                      child: Container(
                        width: (Get.width - 50) / 2,
                        height: 168.h,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              '최다 투표',
                              style: CTextStyle.heavy16,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(25)),
                              child: SizedBox(
                                width: 72.w,
                                height: 72.w,
                                child: CachedNetworkImage(
                                  imageUrl: pollData.items.length == 1
                                      ? pollData.items[0].image ?? ''
                                      : pollData.items[mostVotes(pollData.numberOfVotes)!].image ?? '',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: CColor.gray.withOpacity(0.3),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  CIconPath.crown,
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 6.h,
                                ),
                                Text(
                                  pollData.numberOfVotes[mostVotes(pollData.numberOfVotes)!].toString(),
                                  style: CTextStyle.bold12.copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          if (commentBlindChecker(pollData.joins!, pollData.finalChoice, isMine)) commentBlind()
        ],
      ),
    );
  });
}

class YnPopularCommentPainter extends CustomPainter {
  const YnPopularCommentPainter(
    this.color,
    this.isLeft,
  );

  final Color color;
  final bool isLeft;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    isLeft ? canvas.drawPath(leftPath(size.width, size.height), paint) : canvas.drawPath(rightPath(size.width, size.height), paint);
  }

  Path leftPath(double x, double y) {
    Path path = Path()
      // ..moveTo(0, y)
      ..moveTo(0, 16)
      ..arcToPoint(
        const Offset(16, 0),
        radius: const Radius.circular(16),
      )
      ..lineTo(x / 2 - 16, 0)
      ..arcToPoint(Offset(x / 2, 16), radius: const Radius.circular(16))
      ..lineTo(x - 16, y - 16)
      ..arcToPoint(Offset(x, y), radius: const Radius.circular(16))
      ..lineTo(0, y)
      ..close();

    return path;
  }

  Path rightPath(double x, double y) {
    Path path = Path()
      ..moveTo(x / 2, 16)
      ..arcToPoint(
        Offset(x / 2 + 16, 0),
        radius: const Radius.circular(16),
      )
      ..lineTo(x - 16, 0)
      ..arcToPoint(Offset(x, 16), radius: const Radius.circular(16))
      ..lineTo(x, y)
      ..lineTo(0, y)
      ..arcToPoint(Offset(16, y - 16), radius: const Radius.circular(16))
      ..lineTo(x / 2 - 16, y - 16)
      ..close();

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CommentExpandedWidget extends StatefulWidget {
  const CommentExpandedWidget({Key? key, required this.side, required this.itemImageList}) : super(key: key);

  final List<int> side;
  final List<String> itemImageList;

  @override
  State<CommentExpandedWidget> createState() => _CommentExpandedWidgetState();
}

class _CommentExpandedWidgetState extends State<CommentExpandedWidget> {
  bool isExpanded = false;
  List<String> alphabetList = List.generate(26, (index) {
    String alphabet = String.fromCharCode(65 + index);
    return alphabet;
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          width: 174,
          height: 36,
        ),
        GestureDetector(
          onTap: () {
            isExpanded = false;
            setState(() {});
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isExpanded ? Colors.black : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Center(
                child: SvgPicture.asset(
              CIconPath.close,
              color: Colors.white,
              width: 32,
            )),
          ),
        ),
        AnimatedPositioned(
            left: isExpanded == false
                ? 138
                : widget.side.length == 2
                    ? 46
                    : 0,
            duration: const Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: () {
                if (isExpanded == false && widget.side.length > 2) {
                  isExpanded = true;
                  setState(() {});
                }
              },
              child: SizedBox(
                width: widget.side.length > 2 ? 138 : null,
                height: 36,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: widget.side.length,
                    itemBuilder: (BuildContext ctx, int idx) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xffE0E0E0),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 34,
                                    height: 34,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.itemImageList[widget.side[idx]],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        color: CColor.gray.withOpacity(0.3),
                                      ),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                  if (isExpanded)
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        color: Color(0xffF8A940),
                                      ),
                                      child: Center(
                                          child: Text(
                                        alphabetList[widget.side[idx]],
                                        style: CTextStyle.bold10.copyWith(color: Colors.white),
                                      )),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            )),
      ],
    );
  }
}

void reportBottomSheet(int reportedUserId, int reportedItemId, int type) {
  final pollDetailController = Get.find<PollDetailController>();
  pollDetailController.reportReason = -1;
  pollDetailController.reportReasonController.clear();
  Get.bottomSheet(isScrollControlled: true, GetBuilder<PollDetailController>(builder: (pollDetailController) {
    return SizedBox(
      child: ListView(
        children: [
          Container(
            width: Get.width,
            height: Get.height - 40,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: Get.width,
                  height: 702,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          '신고',
                          style: CTextStyle.light20.copyWith(height: 22 / 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            '내모네몬은 보다 클린한 서비스 환경을 위해 회원님의 신고 제보를 받아, 관련 법 또는 운영정책을 기준으로 불량 사용자에 대한 대응을 하고 있어요\n\n어떤 사유로 신고를 하게 되셨나요?',
                            style: CTextStyle.light14.copyWith(height: 20 / 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            width: Get.width - 70,
                            height: 234,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(width: 1, color: const Color(0xffE0E0E0)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 40),
                                      GestureDetector(
                                        onTap: () {
                                          pollDetailController.reportReason = 0;
                                          pollDetailController.update();
                                        },
                                        child: Container(
                                          width: 26,
                                          height: 26,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                                              border: Border.all(
                                                  width: 2, color: pollDetailController.reportReason == 0 ? Colors.black : CColor.subLightGray)),
                                          child: Visibility(
                                              visible: pollDetailController.reportReason == 0, child: SvgPicture.asset(CIconPath.check20p)),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '광고, 스팸, 사기',
                                        style: CTextStyle.light14,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15.5,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 40),
                                      GestureDetector(
                                        onTap: () {
                                          pollDetailController.reportReason = 1;
                                          pollDetailController.update();
                                        },
                                        child: Container(
                                          width: 26,
                                          height: 26,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                                              border: Border.all(
                                                  width: 2, color: pollDetailController.reportReason == 1 ? Colors.black : CColor.subLightGray)),
                                          child: Visibility(
                                              visible: pollDetailController.reportReason == 1, child: SvgPicture.asset(CIconPath.check20p)),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '욕설, 비방, 폭력적 위협',
                                        style: CTextStyle.light14,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15.5,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 40),
                                      GestureDetector(
                                        onTap: () {
                                          pollDetailController.reportReason = 2;
                                          pollDetailController.update();
                                        },
                                        child: Container(
                                          width: 26,
                                          height: 26,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                                              border: Border.all(
                                                  width: 2, color: pollDetailController.reportReason == 2 ? Colors.black : CColor.subLightGray)),
                                          child: Visibility(
                                              visible: pollDetailController.reportReason == 2, child: SvgPicture.asset(CIconPath.check20p)),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '희롱, 괴롭힘, 선정성',
                                        style: CTextStyle.light14,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15.5,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 40),
                                      GestureDetector(
                                        onTap: () {
                                          pollDetailController.reportReason = 3;
                                          pollDetailController.update();
                                        },
                                        child: Container(
                                          width: 26,
                                          height: 26,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                                              border: Border.all(
                                                  width: 2, color: pollDetailController.reportReason == 3 ? Colors.black : CColor.subLightGray)),
                                          child: Visibility(
                                              visible: pollDetailController.reportReason == 3, child: SvgPicture.asset(CIconPath.check20p)),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '명의도용, 사생활 침해',
                                        style: CTextStyle.light14,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15.5,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 40),
                                      GestureDetector(
                                        onTap: () {
                                          pollDetailController.reportReason = 4;
                                          pollDetailController.update();
                                        },
                                        child: Container(
                                          width: 26,
                                          height: 26,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                                              border: Border.all(
                                                  width: 2, color: pollDetailController.reportReason == 4 ? Colors.black : CColor.subLightGray)),
                                          child: Visibility(
                                              visible: pollDetailController.reportReason == 4, child: SvgPicture.asset(CIconPath.check20p)),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '기타',
                                        style: CTextStyle.light14,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            '보다 원활한 제재조치를 위해 좀 더 자세한 상황을 알려주실 수 있나요?(선택사항)',
                            style: CTextStyle.light14.copyWith(height: 20 / 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            width: Get.width - 70,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(width: 1, color: const Color(0xffE0E0E0)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                width: Get.width - 90,
                                height: 100,
                                child: TextField(
                                  controller: pollDetailController.reportReasonController,
                                  textAlign: TextAlign.start,
                                  maxLines: 5,
                                  style: CTextStyle.light12.copyWith(height: 20 / 12, color: const Color(0xff525252)),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      alignLabelWithHint: true,
                                      hintText: '여기에 자세한 신고 사유를 적어주세요. 반복된 허위 신고는 게정에 제재조치가 취해질 수 있어요.',
                                      hintStyle: CTextStyle.light12.copyWith(height: 20 / 12, color: const Color(0xff525252))),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                width: 160,
                                height: 46,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(36)),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black, width: 1)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      CIconPath.close,
                                      width: 32,
                                    ),
                                    Text(
                                      '취소',
                                      style: CTextStyle.bold14.copyWith(color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (pollDetailController.reportReason != -1) {
                                  pollDetailController.reportComment(reportedUserId, reportedItemId, type);
                                  Get.back();
                                  Get.bottomSheet(Container(
                                    height: 266,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 52),
                                          child: Container(
                                            width: 60,
                                            height: 6,
                                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 40),
                                          child: Text(
                                            '신고하기가 정상적으로 완료되었습니다.\n접수된 내용은 내부 검토 후에 대응할 예정입니다.\n\n반복적인 허위 신고는 서비스 이용 정지 사유가 되오니, 참고하시기 바랍니다.',
                                            style: CTextStyle.light14.copyWith(height: 15 / 14),
                                          ),
                                        ),
                                        const SizedBox(height: 45),
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            width: 200,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(36)),
                                                color: Colors.white,
                                                border: Border.all(color: Colors.black, width: 1)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  CIconPath.close,
                                                  width: 32,
                                                ),
                                                Text(
                                                  '취소',
                                                  style: CTextStyle.bold14.copyWith(color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                                }
                              },
                              child: Container(
                                width: 160,
                                height: 46,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(36)),
                                  color: pollDetailController.reportReason == -1 ? Colors.black.withOpacity(0.3) : Colors.black,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      CIconPath.siren26P,
                                      width: 32,
                                    ),
                                    Text(
                                      '신고하기',
                                      style: CTextStyle.bold14.copyWith(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }));
}
