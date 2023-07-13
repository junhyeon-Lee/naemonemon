import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/models/local_model/group/group.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/group_screen/group_controller.dart';
import 'package:shovving_pre/modules/main/home/poll_screen/poll_controller.dart';
import 'package:shovving_pre/util/safe_print.dart';

import '../../../../ui_helper/common_ui_helper.dart';

class PollCreateScreen extends StatelessWidget {
  const PollCreateScreen({Key? key, required this.pollItems}) : super(key: key);

  final List<UrlData> pollItems;




  @override
  Widget build(BuildContext context) {

    Group? groupData = pollItems[0].group.isEmpty?null: Get.find<GroupController>().getGroupInfo(pollItems[0].group[0]);

    ///색상 인덱스인데 널이면 베이직 아니라면 해당하는 색상번호를 부여합니다. 즉 시작하는 색상 그룹의 인덱스여
    int colorIndex = groupData?.groupColorId==null?0:(groupData?.groupColorId)!+1;

    Color itemColor(int index){
      /// 다행이도 Null인 색상을 반환하는 경우는 없지


      return  GColor.fColorList[(colorIndex+index~/5)%(GColor.fColorList.length-1)][index%5];



    }

    return GetBuilder<PollController>(
      init: PollController(),
      builder: (pollController) {
        return GestureDetector(
          onTap: (){
            pollController.unFocusCommentField();
          },
          child: Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                leading: Container(),
                leadingWidth: 0,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: SvgPicture.asset(CIconPath.back)),
                      const SizedBox(
                        width: 18,
                      ),
                      SizedBox(
                          width: Get.width - 100,
                          child: Text(
                            pollItems[0].title??"타이틀이 없음",
                            style: CTextStyle.bold16,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
              ),

              body: Stack(alignment: Alignment.bottomCenter,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                          const Text('There are'),
                            Text(' ${pollItems.length.toString()} '),
                            const Text('items.'),
                        ],
                        ),
                        const SizedBox(height: 12),

                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: Colors.white),
                              width: double.infinity,
                              height: 124,
                              child: Center(
                                      child: Stack(
                                        children: [
                                          Visibility(
                                             visible: pollController.manualTypeMode==false,
                                            child: ListView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              controller: pollController.scrollController,
                                              itemBuilder: (BuildContext context, int index) {
                                                return SizedBox(
                                                    height: 124,
                                                    child: Center(
                                                        child: Text(
                                                          pollController.slotList[index],
                                                          style: CTextStyle.bold26,
                                                          textAlign: TextAlign.center,
                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,
                                                        )));
                                              },
                                              itemCount: pollController.slotList.length,
                                            ),
                                          ),
                                          Center(
                                            child: Visibility(
                                              visible: pollController.manualTypeMode,
                                              child: Focus(
                                                onFocusChange: (hasFocus) {
                                                  if(hasFocus==false) {
                                                    safePrint('포커스 아웃');
                                                    pollController.manualCommentSet();
                                                  }
                                                },
                                                child: TextField(
                                                  focusNode: pollController.pollCommentFocusNode,
                                                  controller: pollController.pollCommentTextController,
                                                  style: CTextStyle.bold26.copyWith(decorationThickness: 0),
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    border: InputBorder.none,
                                                    hintText: '소감 한마디 부탁드립니다.',
                                                    hintStyle: CTextStyle.bold26.copyWith(color: CColor.gray),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )

                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      pollController.unFocusCommentField();
                                      pollController.slotRandomSetting();
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)), color: Colors.black),
                                      height: 40,
                                      child: Center(child: SvgPicture.asset(CIconPath.dice)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if(pollController.manualTypeMode){
                                        pollController.unFocusCommentField();
                                      }else{
                                        pollController.typeMode();
                                      }

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12)), color: CColor.pink),
                                      height: 40,
                                      child: Center(child: SvgPicture.asset(CIconPath.commentEdit)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Container(
                          decoration: BoxDecoration(
                              color: itemColor(0),
                            borderRadius: const BorderRadius.all(Radius.circular(12))
                          ),
                          width: Get.width-40, height: Get.width-40+50,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: Get.width-40, height: Get.width-40,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                      image: DecorationImage(
                                        image: NetworkImage(pollItems[0].image!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(right: 0, top: 20,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                                        color: itemColor(0),
                                      ),
                                      width: 60, height: 100,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 50,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                                        border: Border.all(width: 2, color: CColor.lightGray)
                                      ),
                                      child: Center(
                                        child: Text('eeeeeeee'),
                                      ),
                                    ),
                                  ),
                                ),

                              )
                            ],
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                              color: itemColor(1),
                              borderRadius: const BorderRadius.all(Radius.circular(12))
                          ),
                          width: Get.width-40, height: Get.width-40+50,
                          child: Column(
                            children: [
                              Container(
                                width: Get.width-40, height: Get.width-40,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  image: DecorationImage(
                                    image: NetworkImage(pollItems[1].image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 50,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                                          border: Border.all(width: 2, color: CColor.lightGray)
                                      ),
                                      child: Center(
                                        child: Text('eeeeeeee'),
                                      ),
                                    ),
                                  ),
                                ),

                              )
                            ],
                          ),
                        )


                      ],
                    ),
                  ),

                  CommonContainer(
                    width: double.infinity, height: 60,
                    containerColor: CColor.redCaution,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(CIconPath.poll),
                        const SizedBox(width: 10),
                        Text('Create a poll.', style: CTextStyle.bold22.copyWith(color: Colors.white),),
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
