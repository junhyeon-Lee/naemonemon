import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/modules/main/home/cart_screen/cart_controller.dart';
import 'package:shovving_pre/modules/main/home/group_screen/group_controller.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:slide_action/slide_action.dart';
Widget groupScreen(double height){
  final homeController = Get.put(HomeController());
  final cartController = Get.put(CartController());
  final groupController = Get.put(GroupController());
  return GestureDetector(
    onTap: (){
      groupController.unFocusNameField();
    },
    child: GetBuilder<GroupController>(
      builder: (groupController) {
        return SizedBox(
          width: Get.width-20,
          height: Get.height,
          child: Stack(
            children: [
              CommonContainer(
                  containerColor: Colors.white,
                  radius: 0 ,
                  width: Get.width-100,
                  child:
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20,20,20,10),
                        child: Obx(
                              ()=> CommonContainer(
                            containerColor: CColor.lightGray,
                            height: 40,
                            width: double.infinity,
                            child:
                            Padding(
                              padding: const EdgeInsets.only(left: 20, ),
                              child:
                              groupController.groupNameController.text.isEmpty&&groupController.groupName.value!=''?

                              GestureDetector(
                                  onTap: (){
                                    groupController.groupName.value='';
                                    groupController.groupNameFocusNode.requestFocus();
                                  },
                                  child: TextField(
                                    style: CTextStyle.bold22.copyWith(decorationThickness: 0),
                                    decoration: InputDecoration(
                                      isDense:true,
                                      border: InputBorder.none,
                                      hintText: groupController.groupName.value,
                                      hintStyle: CTextStyle.bold22,
                                      enabled: false,
                                      suffixIcon: IconButton(
                                          onPressed:null,
                                          icon: SvgPicture.asset(CIconPath.textFieldClose,width: 16,height: 16)
                                      ),
                                    ),
                                  )):
                              Focus(
                                onFocusChange: (hasFocus){
                                  if(hasFocus){
                                  }else{
                                    groupController.unFocusNameField();
                                  }

                                },
                                child: TextField(
                                  focusNode: groupController.groupNameFocusNode,
                                  controller: groupController.groupNameController,
                                  style: CTextStyle.bold22.copyWith(decorationThickness: 0),
                                  decoration: InputDecoration(
                                    isDense:true,
                                    border: InputBorder.none,
                                    hintText: 'Group Name_',
                                    hintStyle: CTextStyle.bold22.copyWith(color: CColor.gray),
                                    suffixIcon: IconButton(
                                        onPressed:()=> groupController.groupNameController.clear(),
                                        icon: SvgPicture.asset(CIconPath.textFieldClose,width: 16,height: 16)
                                    ),
                                  ),
                                ),
                              ),

                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32, right: 24),
                        child: SizedBox( height: Get.height-100-56-height-70,
                          child: ScrollConfiguration(
                            behavior: const ScrollBehavior().copyWith(overscroll: false),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                const SizedBox(height: 10,),
                                Text('Color',style: CTextStyle.bold22),
                                const SizedBox(height: 20,),
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 20,
                                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5, //1 개의 행에 보여줄 item 개수
                                    childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
                                    mainAxisSpacing: 6, //수평 Padding
                                    crossAxisSpacing: 6, //수직 Padding
                                  ),
                                  itemBuilder: (BuildContext context,int index){
                                    return
                                      GestureDetector(
                                        onTap: (){
                                          groupController.selectColor(index);
                                        },
                                        child: CommonContainer(
                                          width: 42, height: 42,
                                          containerColor:GColor.gColorList[index][0],
                                        ),
                                      );
                                  },
                                ),
                                const SizedBox(height: 20,),
                                Text('Icon',style: CTextStyle.bold22),
                                const SizedBox(height: 20,),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 45,
                                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5, //1 개의 행에 보여줄 item 개수
                                    childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
                                    mainAxisSpacing: 6, //수평 Padding
                                    crossAxisSpacing: 6, //수직 Padding
                                  ),
                                  itemBuilder: (BuildContext context,int index){
                                    // return Text(index.toString());
                                    return
                                      GestureDetector(
                                        onTap: (){
                                          groupController.selectIcon(index);
                                        },
                                        child: CommonContainer(
                                          containerColor: const Color(0xffbdbdbd),
                                          child:Center(child: SvgPicture.asset(GIconPath.gIconList[index+1],width: 20, height: 20,)),
                                        ),
                                      );
                                  },
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              AnimatedPositioned(
                left: homeController.mainMode?Get.width-110:Get.width-100,
                duration: const Duration(milliseconds: 500),
                child: SizedBox(
                  width: 68,
                  height: Get.height-100-56-height,
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child:
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: groupController.groupList.length+2,
                      itemBuilder: (BuildContext context, int index) {
                        if(index ==0){
                          return GestureDetector(
                            onTap: (){
                              if(groupController.designateMode&&index==0){
                                groupController.closeDesignateMode();
                                groupController.selectGroup(index);
                              }else{
                                groupController.selectGroup(index);
                                Get.find<CartController>().filterNowCartList('all');
                              }

                            },
                            child: Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  width: groupController.selectGroupIndex==0?68:50,
                                  height: 68,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffc7ceea),
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12))
                                  ),

                                  child: Center(child: SvgPicture.asset(GIconPath.gIconList[0],width: 34, height: 34,)),
                                ),
                              ],
                            ),
                          );
                        }
                        if(index==groupController.groupList.length+1){
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: (){

                              if(groupController.designateMode){

                                groupController.closeDesignateMode();
                                groupController.selectGroup(0);
                              }else{
                                cartController.closeDeleteMode();
                                cartController.selectedCartListSelect(-1, "");
                                homeController.openEditGroup();
                                groupController.selectGroup(-1);
                              }

                            },
                            child: Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  width: groupController.selectGroupIndex==-1?68:50
                                  , height: 68,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffbdbdbd),
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12))
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                        width:24, height:24,child:
                                    SvgPicture.asset(CIconPath.plus,fit: BoxFit.contain,)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: (){
                              groupController.selectGroup(index);

                              if(groupController.designateMode==false){
                                cartController.filterNowCartList(groupController.groupId);
                              }


                          },
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                width: index==groupController.selectGroupIndex?68:50, height: 68,
                                decoration: BoxDecoration(
                                    color: GColor.gColorList[groupController.groupList[index-1].groupColorId][0],
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12))
                                ),

                                child: Center(child: SvgPicture.asset(GIconPath.gIconList[groupController.groupList[index-1].groupIconId+1],width: 34, height: 34,)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              AnimatedPositioned(
                bottom: 0,
                left: homeController.editGroupMode?0:-70 ,
                duration: const Duration(milliseconds: 500),
                child:Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12)),
                      color: Colors.white,
                    ),
                    width: Get.width-32, height: 100,
                    child:


                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xfff8f8f8),
                              borderRadius: BorderRadius.all(Radius.circular(12))
                            ),

                            width: 240, height: 68,
                            child: Center(
                              child: SizedBox(
                                width: 232, height: 60,
                                child:
                                groupController.selectGroupIndex==-1?
                                SlideAction(
                                  trackBuilder: (context, state) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color(0xfff8f8f8),
                                      ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 68),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "slide to add group",
                                                  style: CTextStyle.regular10,
                                                ),
                                                const SizedBox(height:  6),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                                    const SizedBox(width: 2,),
                                                    SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                                    const SizedBox(width: 2,),
                                                    SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                                    const SizedBox(width: 2,),
                                                    SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                                    const SizedBox(width: 2,),
                                                    SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                                    const SizedBox(width: 2,),
                                                    SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),

                                          CommonContainer(
                                            containerColor: const Color(0xffeeeeee),
                                            width: 60,height: 60,
                                            child: DottedBorder(
                                              color: CColor.gray,
                                              radius: const Radius.circular(12),
                                              strokeWidth: 1,
                                              strokeCap: StrokeCap.butt,
                                              dashPattern: const [2,2],
                                              borderType: BorderType.RRect, child:
                                            Center(child: SvgPicture.asset(CIconPath.plus,color: CColor.gray,))
                                              ,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  thumbBuilder: (context, state) {
                                    return Obx(
                                          ()=> Container(
                                        decoration: BoxDecoration(
                                          color: GColor.gColorList[groupController.groupColor.value][0],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                            child: SvgPicture.asset(GIconPath.gIconList[groupController.groupIcon.value+1],width: 28,height: 28,)
                                        ),
                                      ),
                                    );
                                  },
                                  action: () {
                                    groupController.slideAction();
                                  },
                                )
                                    :SlideAction(
                                  rightToLeft: true,
                                  trackBuilder: (context, state) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color(0xfff8f8f8),
                                      ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [


                                          CommonContainer(
                                            containerColor: const Color(0xffeeeeee),
                                            width: 60,height: 60,
                                            child: DottedBorder(
                                              color: CColor.gray,
                                              radius: const Radius.circular(12),
                                              strokeWidth: 1,
                                              strokeCap: StrokeCap.butt,
                                              dashPattern: const [2,2],
                                              borderType: BorderType.RRect, child:
                                            Center(child: SvgPicture.asset(CIconPath.plus,color: CColor.gray,))
                                              ,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 68),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end ,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "slide to delete group",
                                                  style: CTextStyle.regular10,
                                                ),
                                                const SizedBox(height:  6),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
                                                    const SizedBox(width: 2,),
                                                    SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
                                                    const SizedBox(width: 2,),
                                                    SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
                                                    const SizedBox(width: 2,),
                                                    SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
                                                    const SizedBox(width: 2,),
                                                    SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
                                                    const SizedBox(width: 2,),
                                                    SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  thumbBuilder: (context, state) {
                                    return Obx(
                                        ()=> Container(
                                        decoration: BoxDecoration(
                                          color: GColor.gColorList[groupController.groupColor.value][0],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(GIconPath.gIconList[groupController.groupIcon.value+1],width: 28,height: 28,)
                                        ),
                                      ),
                                    );
                                  },
                                  action: () {
                                    groupController.slideAction();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        //homeController.editGroupMode?
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: (){
                                groupController.selectGroup(0);
                                cartController.filterNowCartList('all');
                                groupController.closeGroupMode();
                                homeController.closeEditGroup();

                              },
                              child: SizedBox(
                                  width: 32, height: 32,
                                  child: SvgPicture.asset(CIconPath.close))),
                        )
                            //:
                        // GestureDetector(
                        //   onTap: (){
                        //     Get.find<CartController>().filterNowCartList('all');
                        //     groupController.enterDesignateMode();
                        //
                        //     if(Get.find<CartController>().deleteMode){
                        //       Get.find<CartController>().closeDeleteMode();
                        //       Get.find<CartController>().selectedCartListSelect(-1, "");
                        //     }
                        //
                        //     if(groupController.selectGroupIndex==0){
                        //       groupController.selectGroup(1);
                        //     }
                        //
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(right: 9),
                        //     child: SizedBox(
                        //         width:32, height: 32,
                        //         child: SvgPicture.asset(CIconPath.nameTag)),
                        //   ),
                        // )
                      ],
                    )
                ),
              )
            ],
          ),
        );
      },
    ),
  );
}