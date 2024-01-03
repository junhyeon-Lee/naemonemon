import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/cart/cart_item.dart';
import 'package:shovving_pre/modules/main/home/poll/my_poll/poll_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/pollDetail_calculator.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_repository.dart';
import 'package:shovving_pre/modules/main/home/poll/social_activity/social_activity_repository.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/calculator.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/share_link.dart';
import 'package:shovving_pre/util/sundry_widget/indicator/indicator.dart';
import 'poll_detail_widget.dart';
import 'poll_detail_item_images_screen.dart';

class PollDetailGeneralScreen extends StatelessWidget {

  final int index;
  final int type;

  const PollDetailGeneralScreen({Key? key, required this.index, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    Poll? tempPoll;
    if(type == 1){
      tempPoll = pollController.myPollList[index];
    }
    else if(type == 2){
      safePrint('폴 다시 업데이트 합니다');
      tempPoll = feedController.feedList[index];

    }
    else if(type == 3){
      tempPoll = pollController.joinedPollList[index];
    }

    Poll pollData = tempPoll!;
    safePrint('댓글 길이 ${pollData.comments.length}');

    List<String> itemsImageList = getItemImage(pollData);
    List<List<String>> fullImageList = getFullImage(pollData);
    List<int> splitPoint = getSplitPoint(pollData, fullImageList);
    int imageListLength = getFullImageLength(pollData, fullImageList);
    List<int> joinData = getJoinData(pollData);

    bool isMine = pollData.userId == userInfoController.usersInfo?.id ? true : false;
    return WillPopScope(
      onWillPop: () async {
        Get.find<PollDetailController>().pollDetailOut(1);
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
                      SizedBox(
                          height: MediaQuery.of(context).padding.top + 380,
                          child: SvgPicture.asset(
                            CIconPath.pollDetailBase01,
                            fit: BoxFit.fill,
                          )),
                      //뒤로가기
                      Positioned(
                          top: 59.h,
                          left: 25.w,
                          child: GestureDetector(
                            onTap: () {
                              pollDetailController.pollDetailOut(1);
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
                        right: 20.w,
                        top: 112.h,
                        child: Column(
                          children: [

                            GestureDetector(
                                onTap:(){
                                  shareLink(pollData, pollData.pollComment);
                                },
                                child: rightMenuButton(0, 0, isMine, false, false)),

                            GestureDetector(
                                onTap: () async {
                                  if (isMine) {
                                    await pollDetailController.showDeleteBottomSheet(pollData);
                                  } else {
                                    checkInMyCart(pollData.items[pollDetailController.selectedItemIndex].url)?pollDetailController.alreadyInMyCart():
                                    pollDetailController.addCartItem(pollData.items[pollDetailController.selectedItemIndex].url);
                                  }
                                },
                                child: rightMenuButton(1, 0, isMine, false, checkInMyCart(pollData.items[pollDetailController.selectedItemIndex].url))),
                            Heart(like: pollData.like, likeCount: pollData.likeLength, pollId: pollData.id, index: index, type: type, type2: 2,),
                            GestureDetector(
                                onTap: (){
                                 pollDetailController.changeCommentSheetState(1);
                                },
                                child: rightMenuButton(3, pollData.comments.length, isMine, false, false)),
                          ],
                        ),
                      ),
                      //상품이미지
                      Positioned(
                          top: 98.h,
                          left: 20.w,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(60)),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(ItemImageViewScreen(
                                    imageList: fullImageList,
                                    selectedIndex: pollDetailController.selectedItemIndex,
                                    imageListLength: imageListLength,
                                    splitPoint: splitPoint,
                                  ));
                                },
                                child: Container(
                                    width: 280.w,
                                    height: 280.w,
                                    decoration: BoxDecoration(
                                      color: CColor.brightGray,
                                    ),
                                    child: ScrollConfiguration(
                                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                                      child: PageView.builder(
                                        controller: pollDetailController.imageListPageController,
                                          itemCount: imageListLength,
                                          onPageChanged: (page){
                                            pollDetailController.selectItem(imageListCalculator(page, splitPoint)[0]);
                                          },
                                          itemBuilder: (BuildContext context, int index) {
                                            return CachedNetworkImage(
                                              imageUrl: fullImageList[imageListCalculator(index, splitPoint)[0]][imageListCalculator(index, splitPoint)[1]],
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Container(
                                                color: CColor.gray.withOpacity(0.3),
                                              ),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            );
                                          }),
                                    )),
                              ))),

                      Positioned(
                        top: 280.h + 98.h - 12.h,
                        left: 20.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                if(pollData.finalChoice!=null)
                                  if(pollData.finalChoice?[pollDetailController.selectedItemIndex]==1)
                                Container(
                                  width: 86.w,
                                  height: 28.w,
                                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(36))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(16.w)),
                                        child: SizedBox(
                                          width: 16.w,
                                          height: 16.w,
                                          child: CachedNetworkImage(
                                            imageUrl: pollData.profileImage ?? '',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Container(
                                              color: CColor.gray.withOpacity(0.3),
                                            ),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Text(pollData.finalChoice == null ? '종료됨' : '최종 선택', style: CTextStyle.regular12),
                                    ],
                                  ),
                                ),
                                if(pollData.finalChoice!=null)
                                  if(pollData.finalChoice?[pollDetailController.selectedItemIndex]==1)
                                const SizedBox(
                                  height: 6,
                                ),
                                if(votesRanking(pollData.numberOfVotes, pollDetailController.selectedItemIndex)!=null)
                                Container(
                                  width: 86.w,
                                  height: 28.h,
                                  decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(36))),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          CIconPath.crown,
                                          width: 16,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          '투표 ${votesRanking(pollData.numberOfVotes, pollDetailController.selectedItemIndex)}위',
                                          style: CTextStyle.regular12.copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  width: 86.w,
                                  height: 28.h,
                                  decoration: const BoxDecoration(color: Color(0xffF8A940), borderRadius: BorderRadius.all(Radius.circular(36))),
                                  child: Center(
                                    child: Text(
                                      '${pollData.numberOfVotes[pollDetailController.selectedItemIndex]} 표',
                                      style: CTextStyle.regular12,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            SizedBox(
                                width: 88.w,
                                height: 126.h,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      CIconPath.pollDetailBase02,
                                      fit: BoxFit.fill,
                                      color: Colors.white,
                                    ),
                                    Positioned(
                                        top: 6.h,
                                        child: SvgPicture.asset(
                                          CIconPath.pollDetailBase03,
                                        )),
                                    Positioned(
                                      bottom: 4.h,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                                        child: SizedBox(
                                          height: 100.h,
                                          child: Column(mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 80.h,
                                                height: 80.h,
                                                child: CachedNetworkImage(
                                                  imageUrl: pollData.items[pollDetailController.selectedItemIndex].image ?? '',
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => Container(
                                                    color: CColor.gray.withOpacity(0.3),
                                                  ),
                                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                                ),
                                              ),
                                              Container(
                                                width: 80.h,
                                                height: 20.h,
                                                color: isMine ? const Color(0xffF8408D) : const Color(0xffF8A940),
                                                child: Center(
                                                  child: Text(
                                                    pollDetailController.alphabetList[pollDetailController.selectedItemIndex],
                                                    style: CTextStyle.heavy12,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                pollDetailController.selectItem(pollDetailController.secondItem(pollData.items.length));
                                pollDetailController.imageListPageController.jumpToPage(imageListCalculatorReverse([pollDetailController.selectedItemIndex,0], splitPoint));
                              },
                              child: Container(
                                  width: 88.w,
                                  height: 108.h,
                                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                                  child: Center(
                                    child: SizedBox(
                                      width: 80.h,
                                      height: 100.h,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 80.h,
                                              height: 80.h,
                                              child: CachedNetworkImage(
                                                imageUrl: pollData.items[pollDetailController.secondItem(pollData.items.length)].image ?? '',
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => Container(
                                                  color: CColor.gray.withOpacity(0.3),
                                                ),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                              ),
                                            ),
                                            Container(
                                              width: 80.h,
                                              height: 20.h,
                                              color: CColor.brightGray,
                                              child: Center(
                                                child: Text(
                                                  //'B',
                                                  pollDetailController.alphabetList[pollDetailController.secondItem(pollData.items.length)],
                                                  style: CTextStyle.heavy12,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                pollDetailController.selectItem(pollDetailController.thirdItem(pollData.items.length));
                                pollDetailController.imageListPageController.jumpToPage(imageListCalculatorReverse([pollDetailController.selectedItemIndex,0], splitPoint));
                              },
                              child: Container(
                                  width: 88.w,
                                  height: 108.h,
                                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                                  child: Center(
                                    child: SizedBox(
                                      width: 80.h,
                                      height: 100.h,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 80.h,
                                              height: 80.h,
                                              child: CachedNetworkImage(
                                                imageUrl: pollData.items[pollDetailController.thirdItem(pollData.items.length)].image ?? '',
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => Container(
                                                  color: CColor.gray.withOpacity(0.3),
                                                ),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                              ),
                                            ),
                                            Container(
                                              width: 80.h,
                                              height: 20.h,
                                              color: CColor.brightGray,
                                              child: Center(
                                                child: Text(
                                                  // 'c',
                                                  pollDetailController.alphabetList[pollDetailController.thirdItem(pollData.items.length)],
                                                  style: CTextStyle.heavy12,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),

                      ///이거를 공용 위젯 화 시켜서 사용해야 합니다. 완전하게
                      ///댓글, 최다투표 위젯
                      if (pollDetailController.isExpanded == false)
                        commentNavigator(index, type, isMine),

                      ///투표하기 위젯
                      Positioned(
                        left: 20,
                        top: 558.h - 56.h,
                        child: Container(
                          width: Get.width - 40,
                          height: 46.h,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 178.w,
                                height: 42.h,
                                child: pollData.items[pollDetailController.selectedItemIndex].title == 'poll item'
                                    ? Center(
                                        child: Text(
                                          '직접 추가 한 이미지 입니다.',
                                          style: CTextStyle.heavy14.copyWith(height: 18 / 14, color: CColor.gray),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : Center(
                                        child: GestureDetector(
                                          onTap: (){
                                            pollDetailController.seeDetailUrl(pollData.items[pollDetailController.selectedItemIndex].url);
                                          },
                                          child: Text(
                                            pollData.items[pollDetailController.selectedItemIndex].title ??
                                                pollData.items[pollDetailController.selectedItemIndex].url,
                                            style: CTextStyle.heavy14.copyWith(height: 18 / 14, decoration: TextDecoration.underline),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                              ),
                              if (isMine) GestureDetector(
                                    onTap: () async {

                                      List<int> tempFinalChoice = joinData;

                                      ///제너럴에서는 여기서 선택 함수를 부르는 것이 아닌 새로운 바텀시트를 열어줘야 합니다.
                                      Get.bottomSheet(isScrollControlled: true, GetBuilder<PollController>(builder: (pollController) {
                                        return Container(
                                          height: Get.height - 50,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                                            color: Colors.white,
                                          ),
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: 60,
                                                    height: 6,
                                                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.black),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                                    child: Text(
                                                      '카트',
                                                      style: CTextStyle.light20,
                                                    ),
                                                  ),
                                                  if (cartController.filteredCartList.isNotEmpty) SizedBox(
                                                    width: Get.width,
                                                    height: Get.height - 50 - 60 - 16,
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                      child: GridView.builder(
                                                          physics: const BouncingScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: pollData.items.length,
                                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            childAspectRatio: 1 / 1,
                                                            mainAxisSpacing: 10,
                                                            crossAxisSpacing: 10,
                                                          ),
                                                          itemBuilder: (BuildContext context, int index) {
                                                            return

                                                              GestureDetector(
                                                                onTap: (){
                                                                  if(tempFinalChoice[index]==0){
                                                                    tempFinalChoice[index] = 1;
                                                                    safePrint(tempFinalChoice);
                                                                  }else{
                                                                    tempFinalChoice[index] = 0;
                                                                    safePrint(tempFinalChoice);
                                                                  }
                                                                  pollController.update();
                                                                },
                                                                child: Stack(alignment: Alignment.center,
                                                                  children: [
                                                                    Positioned.fill(
                                                                      child: ClipRRect(
                                                                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                                      child: CachedNetworkImage(
                                                                        imageUrl: pollData.items[index].image??'',
                                                                        fit: BoxFit.cover,
                                                                        placeholder: (context, url) => Container(
                                                                          color: CColor.gray.withOpacity(0.3),
                                                                        ),
                                                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                      ),
                                                            ),
                                                                    ),
                                                                    Positioned(
                                                                      bottom:4,
                                                                      child: Container(
                                                                        width: 30,
                                                                        height: 30,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                                            border: Border.all(color: tempFinalChoice[index]==1 ? CColor.mainGreen : Colors.white, width: 2),
                                                                            color:tempFinalChoice[index]==1? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.3)),
                                                                        child: Visibility(
                                                                            visible: tempFinalChoice[index]==1, child: Center(child: SvgPicture.asset(CIconPath.checkItem))),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              );







                                                          }),
                                                    ),
                                                  ) else SizedBox(
                                                      width: Get.width,
                                                      height: Get.height - 50 - 60 - 16,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            '카트에 담긴 아이템이 없어요.\n쇼핑몰의 관심상품을 카트에 담아 보세요.',
                                                            style: CTextStyle.light20,
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                              Get.back();
                                                            },
                                                            child: Text('카트에 담으러 가기',
                                                                style: CTextStyle.light16.copyWith(
                                                                  decoration: TextDecoration.underline,
                                                                )),
                                                          ),
                                                          const SizedBox(
                                                            height: 40,
                                                          ),
                                                          Text(
                                                            '관심 상품을 카트에 어떻게 담나요?',
                                                            style: CTextStyle.light18.copyWith(color: CColor.redCaution),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Image.asset(
                                                                  ImagePath.guide1,
                                                                  width: (Get.width - 70) / 2,
                                                                ),
                                                                Image.asset(
                                                                  ImagePath.guide2,
                                                                  width: (Get.width - 70) / 2,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 80,
                                                          ),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                                Positioned(
                                                  bottom: 20,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        if(tempFinalChoice.contains(1)){
                                                          Get.back();
                                                        }
                                                      },
                                                      child: Container(
                                                        width: Get.width - 80,
                                                        height: 46,
                                                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(16)), color: const Color(0xffF8408D).withOpacity(tempFinalChoice.contains(1)?1:0.3)),
                                                        child: Center(
                                                          child: Text(
                                                            '선택 완료',
                                                            style: CTextStyle.eHeader20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                        );
                                      })).whenComplete(() async {

                                        if(tempFinalChoice.contains(1)){
                                          safePrint('선택을 했습니다.');
                                          safePrint(tempFinalChoice);

                                          ///리스트를 받아서 선택하는 것을 하면 됩니다.
                                          if (pollData.finalChoice == null) {
                                            await pollController.generalFinalChoice(pollData, index, tempFinalChoice);
                                            tempFinalChoice = joinData;
                                          }

                                        }
                                      });






                                    },
                                    child:
                                        mineJoinButton(pollDetailController.alphabetList[pollDetailController.selectedItemIndex], pollData.finalChoice == null ? false : true)) else pollData.finalChoice != null?
                              mineJoinButton(pollDetailController.alphabetList[pollDetailController.selectedItemIndex], pollData.finalChoice == null ? false : true):
                                GestureDetector(

                                  onTap: () async {



                                    if(alreadyJoin(pollData.joins, pollDetailController.selectedItemIndex)){
                                      safePrint('이미 투표에 참여 했습니다.');
                                    }else{
                                      List<int> tempJoinData = setJoinData(pollDetailController.selectedItemIndex, pollData.joins??[],pollData.items.length);

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

                                  child: joinButton(0, true,

                                      alreadyJoin(pollData.joins, pollDetailController.selectedItemIndex),
                                    pollDetailController.selectedItemIndex

                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      ///폴코멘트 위젯
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
                      GeneralCommentSheet(commentDataList: pollData.comments, itemImageList: itemsImageList, type: 1, index:index),
                      //generalCommentSheet(pollData.comments, itemsImageList),
                      ///댓글 입려창
                      if (pollDetailController.commentSheetState != 0&& pollDetailController.commentExtraSheetState==false)
                        commentTextField(pollData, joinData, index, isMine, type),
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
