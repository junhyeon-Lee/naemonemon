import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/modules/main/home/cart_screen/cart_controller.dart';
import 'package:shovving_pre/modules/main/home/group_screen/group_controller.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/ui_helper/common_widget/common_appbar.dart';
import 'package:shovving_pre/ui_helper/common_widget/slide_button.dart';
import 'package:slide_action/slide_action.dart';

import 'cart_screen/cart_screen.dart';
import 'group_screen/group_screen.dart';
import 'poll_screen/poll_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    final cartController = Get.put(CartController());
    final groupController = Get.put(GroupController());
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: HomeAppbar(),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: controller.scrollController,
              child: Stack(
                children: [

                  Row(
                    children: [groupScreen(height), cartScreen(), pollScreen()],
                  ),


                  AnimatedPositioned(
                    left: controller.mainMode?Get.width-24:Get.width-80,
                      bottom: cartController.deleteMode?0:-100,
                      duration: const Duration(milliseconds: 500),
                      child:  Container(
                        width: Get.width-32, height: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                          color: Colors.white,
                        ),



                        child: Padding(
                          padding: const EdgeInsets.only(left: 30,right: 18),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xfff8f8f8),
                                    borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
                                width: 240, height: 68,
                                child: Center(
                                  child: SizedBox( width: 232, height: 60,
                                    child: DeleteSlideButton(
                                      iconPath: CIconPath.delete,
                                      destinationIconPath: CIconPath.delete,
                                      text: '밀어서 삭제',
                                      action: cartController.cartListDelete,
                                      iconColor: Colors.white,
                                      destinationIconColor: CColor.gray,
                                    ),


                                    // SlideAction(
                                    //   trackBuilder: (context, state) {
                                    //     return Container(
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(12),
                                    //         color: const Color(0xfff8f8f8),
                                    //       ),
                                    //       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           Padding(
                                    //             padding: const EdgeInsets.only(left: 68),
                                    //             child: Column(
                                    //               crossAxisAlignment: CrossAxisAlignment.start,
                                    //               mainAxisAlignment: MainAxisAlignment.center,
                                    //               children: [
                                    //                 Text(
                                    //                   "slide to add delete",
                                    //                   style: CTextStyle.regular10,
                                    //                 ),
                                    //                 const SizedBox(height:  6),
                                    //                 Row(
                                    //                   children: [
                                    //                     SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                    //                     const SizedBox(width: 2,),
                                    //                     SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                    //                     const SizedBox(width: 2,),
                                    //                     SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                    //                     const SizedBox(width: 2,),
                                    //                     SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                    //                     const SizedBox(width: 2,),
                                    //                     SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                    //                     const SizedBox(width: 2,),
                                    //                     SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
                                    //                   ],
                                    //                 )
                                    //               ],
                                    //             ),
                                    //           ),
                                    //
                                    //           CommonContainer(
                                    //             containerColor: const Color(0xffeeeeee),
                                    //             width: 60,height: 60,
                                    //             child: DottedBorder(
                                    //               color: CColor.gray,
                                    //               radius: const Radius.circular(12),
                                    //               strokeWidth: 1,
                                    //               strokeCap: StrokeCap.butt,
                                    //               dashPattern: const [2,2],
                                    //               borderType: BorderType.RRect, child:
                                    //             Center(child: SvgPicture.asset(CIconPath.plus,color: CColor.gray,))
                                    //               ,
                                    //             ),
                                    //           )
                                    //         ],
                                    //       ),
                                    //     );
                                    //   },
                                    //   thumbBuilder: (context, state) {
                                    //     return Container(
                                    //       decoration: BoxDecoration(
                                    //         color: CColor.deepBlueBlack,
                                    //         borderRadius: BorderRadius.circular(12),
                                    //       ),
                                    //       child: Center(
                                    //           child: SvgPicture.asset(CIconPath.delete,width: 28,height: 28,)
                                    //       ),
                                    //     );
                                    //   },
                                    //   action: () {
                                    //     cartController.cartListDelete();
                                    //   },
                                    // ),
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: (){
                                    cartController.closeDeleteMode();
                                    cartController.selectedCartListSelect(-1, "");
                                  },
                                  child: SvgPicture.asset(CIconPath.close,width: 32,))
                            ],
                          ),
                        ),
                      )
                  ),

                  AnimatedPositioned(
                      left: groupController.designateMode?Get.width-100:-Get.width ,
                      bottom: 0,
                      duration: const Duration(milliseconds: 500),
                      child:  Container(
                        width: Get.width, height: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                          color: Colors.black,
                        ),

                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 18),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('1. Select the Group tab in the top left.\n'
                                '2. Select tje otems to put in the group.\n'
                                '3. When done, hit the check button'
                                ,style: CTextStyle.bold14,),
                              GestureDetector(
                                  onTap: (){
                                    groupController.closeDesignateMode();
                                  },
                                  child: SvgPicture.asset(CIconPath.checkDone)),
                            ],
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
