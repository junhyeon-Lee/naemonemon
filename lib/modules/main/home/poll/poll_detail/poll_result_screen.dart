import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/api_model/cart/cart.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/calculator.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/profile/profile_image_widget.dart';

import 'poll_detail_widget.dart';

List<String> alphabetList = List.generate(26, (index) {
  String alphabet = String.fromCharCode(65 + index);
  return alphabet;
});

void pollResultScreen(Poll pollData) {
  ///여기서 득표수에 따라 아이템을 재배치하고, 그에 맞게 nov도 정렬해주자.
  List<int> finalChoice = [];
  double percent = 0;
  if(pollData.finalChoice != null){
    finalChoice = pollData.finalChoice!;

    if(pollData.items.length>2){
      int myChoice = 0;
      int correct = 0;
      for(int i=0; i<pollData.joins!.length; i++){

        if(pollData.joins![i]==1){
          myChoice ++;
          if(pollData.finalChoice![i]==1){
            correct++;
          }
        }

      }

      percent = 100* correct/myChoice;
  }
    ///퍼센트를 여기서 계산하고자 합니다.



  }

  List<int> tempNov = pollData.numberOfVotes;
  List<int> tempId = [];
  List<Cart> sortItemData = [];

  for (int i = 0; i < pollData.items.length; i++) {
    sortItemData.add(pollData.items[i]);
    tempId.add(pollData.items[i].id!);
  }

  for (int i = 0; i < pollData.items.length; i++) {
    sortItemData[i] = sortItemData[i].copyWith(numberOfVote: tempNov[i]);
  }

  if (pollData.items.length == 1) {
    Cart tempData = sortItemData[0].copyWith(id: -1, numberOfVote: tempNov[1]);
    sortItemData.add(tempData);
    tempId.add(-1);
  }

  quickSort(sortItemData, 0, sortItemData.length - 1);

  for (int i = 0; i < sortItemData.length; i++) {
    safePrint('리스트 ${sortItemData[i].numberOfVote},  ${sortItemData[i].id}');
  }

  safePrint('데이터 확인');
  safePrint(finalChoice);
  safePrint(finalChoice!.length);
  safePrint(pollData.joins);
  safePrint(pollData.joins!.length);
  safePrint(listEquals(pollData.joins, finalChoice));

  Get.bottomSheet(isScrollControlled: true, GetBuilder<PollDetailController>(builder: (pollController) {
    return Container(
      width: Get.width,
      height: Get.height - 90,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Container(
                  width: 60, height: 6, decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.black)),
              const SizedBox(height: 10),
              Text('결과', style: CTextStyle.light20.copyWith(height: 26 / 20)),
              const SizedBox(height: 10),
            ],
          ),

          SizedBox(
            width: Get.width,
            height: Get.height - 90 - 30 - 26 - 6,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView(
                shrinkWrap: true,
                children: [

                  if(pollData.finalChoice!=null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Container(width: Get.width,

                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(36)),
                        color: CColor.lightGray,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              profileImageCircle(pollData.user?.profileImage ?? ''),
                              const SizedBox(width: 6),
                              Text('${pollData.user?.nickName}',style: CTextStyle.bold14.copyWith(height: 20/14,color: Colors.black),),
                              const SizedBox(width: 6),
                              Text('님의 최종 선택은?',style: CTextStyle.bold14.copyWith(height: 20/14,color: CColor.gray),),
                            ],
                          ),

                          if(pollData.items.length>2)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(33,12,33,20),
                            child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: pollData.items.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 88 / 108,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return

                                    Stack(
                                      children: [
                                        Container(
                                            width: 88,
                                            height: 108,
                                            decoration:
                                             BoxDecoration(
                                                color:
                                                finalChoice[index]==1 && pollData.joins![index]==1?
                                                const Color(0xffFF2E7E):
                                                Colors.white,

                                                borderRadius: BorderRadius.all(Radius.circular(16))),
                                            child: Center(
                                              child: SizedBox(
                                                width: 80,
                                                height: 100,
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 80,
                                                        height: 80,
                                                        child: CachedNetworkImage(
                                                          imageUrl: pollData.items[index].image ?? '',
                                                          fit: BoxFit.cover,
                                                          placeholder: (context, url) => Container(
                                                            color: CColor.gray.withOpacity(0.3),
                                                          ),
                                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 80,
                                                        height: 20,
                                                        color: CColor.brightGray,
                                                        child: Center(
                                                          child: Text(
                                                            // 'c',
                                                            alphabetList[index],
                                                            style: CTextStyle.heavy12,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )),

                                        if(finalChoice[index]==1 && pollData.joins![index]==1)
                                          Positioned(
                                            top:10, right:10,
                                            child: Container(width: 14, height: 14,

                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(14)),
                                                color: Color(0xffFF2E7E)
                                              ),
                                              child: Center(child: SvgPicture.asset(CIconPath.check, width: 7,),),

                                            ),
                                          ),

                                        if(finalChoice[index]==0)
                                        Container(
                                          width: 88,
                                          height: 108,
                                          decoration:
                                          BoxDecoration(color: Colors.black.withOpacity(0.8), borderRadius: const BorderRadius.all(Radius.circular(12))),
                                        )
                                      ],
                                    );

                                }),
                          ),

                          if(pollData.items.length==1)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(width: 120, height: 120,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                  color: Colors.white
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(13)),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: CachedNetworkImage(
                                            imageUrl: pollData.items[0].image??'',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Container(
                                              color: CColor.gray.withOpacity(0.3),
                                            ),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ),
                                        ),
                                         Container(
                                          width: 114, height: 114,
                                          color: listEquals(pollData.joins, finalChoice)?Colors.transparent:Colors.black.withOpacity(0.8),
                                           child: Center(child: Text(listEquals(pollData.joins, finalChoice)?'산다!':'안 산다!', style: CTextStyle.heavy24.copyWith(fontSize: 26, color: Color(0xffFF2E7E)),)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if(pollData.items.length==2)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(width: 120, height: 120,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                    color: Colors.white
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(13)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      pollData.finalChoice![0]==1?
                                      pollData.items[0].image??'':
                                      pollData.items[1].image??'',

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



                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            pollData.items.length>2?
                            [
                              Text('나의 선택 중, ',style:  CTextStyle.light20.copyWith(height: 40/20,color: Colors.black),),
                              Text('${percent.ceil()}%',style: CTextStyle.light20.copyWith(height: 40/20,color: const Color(0xffC1A7FB)),),
                              Text(' 적중!',style: CTextStyle.light20.copyWith(height: 40/20,color: Colors.black),),
                            ]:
                            pollData.items.length==1?
                            [
                              if(listEquals(pollData.joins, finalChoice))
                              Text('최종 선택',style: CTextStyle.light20.copyWith(height: 40/20,color: const Color(0xffC1A7FB)),),
                              if(listEquals(pollData.joins, finalChoice))
                              Text(' 적중!',style:  CTextStyle.light20.copyWith(height: 40/20,color: Colors.black),),
                              if(listEquals(pollData.joins, finalChoice)==false)
                                Text(' 예상 실패...',style:  CTextStyle.light20.copyWith(height: 40/20,color: Colors.black),),

                            ]:
                            [ //pollData.finalChoice![0]==1
                              if(listEquals(pollData.joins, finalChoice))
                                Text('최종 선택',style: CTextStyle.light20.copyWith(height: 40/20,color: const Color(0xffC1A7FB)),),
                              if(listEquals(pollData.joins, finalChoice))
                                Text(' 적중!',style:  CTextStyle.light20.copyWith(height: 40/20,color: Colors.black),),
                              if(listEquals(pollData.joins, finalChoice)==false)
                                Text(' 예상 실패...',style:  CTextStyle.light20.copyWith(height: 40/20,color: Colors.black),),
                            ],
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(36)),
                        color: CColor.lightGray,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                              child: Text(
                                '가장 인기 있는 아이템은?',
                                style: CTextStyle.light20.copyWith(height: 22 / 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 118.0 * sortItemData.length,
                              width: Get.width - 40,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: sortItemData.length,
                                  itemBuilder: (BuildContext ctx, int idx) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 10, 32, 0),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          SizedBox(
                                            width: Get.width - 40 - 52,
                                            height: 108,
                                          ),
                                          Positioned(
                                            left: 0,
                                            child: Container(
                                                width: 88,
                                                height: 108,
                                                decoration:
                                                    const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                                                child: Center(
                                                  child: SizedBox(
                                                    width: 80,
                                                    height: 100,
                                                    child: ClipRRect(
                                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            width: 80,
                                                            height: 80,
                                                            child: CachedNetworkImage(
                                                              imageUrl:


                                                              sortItemData[idx].id==-1?
                                                                  ImagePath.noBuy:
                                                              sortItemData[idx].image ?? '',



                                                              fit: BoxFit.cover,
                                                              placeholder: (context, url) => Container(
                                                                color: CColor.gray.withOpacity(0.3),
                                                              ),
                                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 80,
                                                            height: 20,
                                                            color: CColor.brightGray,
                                                            child: Center(
                                                              child: Text(
                                                                // 'c',
                                                                alphabetList[tempId.indexOf(sortItemData[idx].id!)],
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
                                          Positioned(
                                            left: 88 + 6 + 36 + 6,
                                            top: 23,
                                            child: SizedBox(
                                              width: Get.width - 228,
                                              child: Text(
                                                sortItemData[idx].title ?? sortItemData[idx].url,
                                                style: CTextStyle.bold12
                                                    .copyWith(height: 15 / 12, decoration: TextDecoration.underline, color: Colors.black),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              left: 94,
                                              top: 0,
                                              child: SizedBox(
                                                height: 95,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    if (idx == 0)
                                                      SvgPicture.asset(
                                                        CIconPath.crown,
                                                        width: 20,
                                                      ),
                                                    const SizedBox(height: 2),
                                                    idx == 0
                                                        ? Text(
                                                            '1st',
                                                            style: CTextStyle.heavy16.copyWith(fontSize: 20, color: CColor.lavender),
                                                          )
                                                        : idx == 1
                                                            ? Text(
                                                                '2nd',
                                                                style: CTextStyle.heavy16,
                                                              )
                                                            : idx == 2
                                                                ? Text(
                                                                    '3rd',
                                                                    style: CTextStyle.heavy16,
                                                                  )
                                                                : Text('${idx + 1}th', style: CTextStyle.heavy16),
                                                    const SizedBox(height: 12),
                                                    GestureDetector(
                                                      onTap: () {
                                                        bool isMine = sortItemData[idx].userID == userInfoController.usersInfo?.id ? true : false;
                                                        if (isMine) {
                                                        } else {
                                                          checkInMyCart(sortItemData[idx].url)
                                                              ? pollController.alreadyInMyCart()
                                                              : pollController.addCartItem(sortItemData[idx].url);
                                                        }
                                                      },
                                                      child: Container(
                                                        width: 36,
                                                        height: 36,
                                                        decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(15)), color: Colors.white),
                                                        child: Center(
                                                            child: SvgPicture.asset(
                                                          CIconPath.download26p,
                                                          width: 24,
                                                          color: checkInMyCart(sortItemData[idx].url) ? Colors.black.withOpacity(0.25) : Colors.black,
                                                        )),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                          Positioned(
                                              top: 59,
                                              left: 88 + 6 + 36 + 6,
                                              child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                  pollData.items.length == 1
                                                      ? Container(
                                                          height: 36,
                                                          width: (Get.width - 228) / sortItemData[0].numberOfVote! * sortItemData[idx].numberOfVote!,
                                                          decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                            color: idx == 0 && tempId.indexOf(sortItemData[idx].id!) == 0
                                                                ? const Color(0xff7080FC)
                                                                : idx == 0 && tempId.indexOf(sortItemData[idx].id!) == 1
                                                                    ? const Color(0xff19E4D0)
                                                                    : CColor.subLightGray,
                                                          ),
                                                        )
                                                      : pollData.items.length == 2
                                                          ? Container(
                                                              height: 36,
                                                              width:
                                                                  (Get.width - 228) / sortItemData[0].numberOfVote! * sortItemData[idx].numberOfVote!,
                                                              decoration: BoxDecoration(
                                                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                                color: idx == 0 && tempId.indexOf(sortItemData[idx].id!) == 0
                                                                    ? CColor.grassGreen
                                                                    : idx == 0 && tempId.indexOf(sortItemData[idx].id!) == 1
                                                                        ? CColor.lavender
                                                                        : CColor.subLightGray,
                                                              ),
                                                            )
                                                          : Container(
                                                              height: 36,
                                                              width:
                                                                  (Get.width - 228) / sortItemData[0].numberOfVote! * sortItemData[idx].numberOfVote!,
                                                              decoration: BoxDecoration(
                                                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                                color: idx == 0 ? const Color(0xffF8A940) : CColor.subLightGray,
                                                              ),
                                                            ),
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(sortItemData[idx].numberOfVote.toString()),
                                                    ],
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }));
}

void quickSort(List<Cart> arr, int low, int high) {
  if (low < high) {
    int partitionIndex = partition(arr, low, high);

    quickSort(arr, low, partitionIndex - 1);
    quickSort(arr, partitionIndex + 1, high);
  }
}

int partition(List<Cart> arr, int low, int high) {
  int pivot = arr[high].numberOfVote!;
  int i = low - 1;

  for (int j = low; j < high; j++) {
    if (arr[j].numberOfVote! >= pivot) {
      i++;
      swap(arr, i, j);
    }
  }

  swap(arr, i + 1, high);

  return i + 1;
}

void swap(List<Cart> arr, int i, int j) {
  Cart temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}
