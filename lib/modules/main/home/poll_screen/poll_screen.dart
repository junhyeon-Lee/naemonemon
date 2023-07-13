import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/modules/main/home/cart_screen/cart_controller.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';

import 'poll_create_screen.dart';

Widget pollScreen(){
  return GetBuilder<HomeController>(
    builder: (controller) {
      return GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < 0) {
            controller.swipeRight();
          }
          if (details.delta.dx > 0) {
            controller.swipeLeft();
          }
        },

        child: Stack(
          children: [
            SizedBox(
              width: Get.width-20,
              height: Get.height,
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              left: controller.pollMode?0:10,
              child: Column(children: [


                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 20),
                  child: GestureDetector(
                    onTap: (){

                      Get.to(() =>
                          PollCreateScreen(pollItems: [Get.find<CartController>().nowCartList[0],Get.find<CartController>().nowCartList[1]]),
                          transition: Transition.rightToLeft);

                    },
                    child: CommonContainer(
                      width: Get.width-70,
                      height: 150,
                      containerColor: Colors.white,
                      child: DottedBorder(
                        color: CColor.gray,
                        radius: const Radius.circular(12),
                        strokeWidth: 4,
                        strokeCap: StrokeCap.butt,
                        dashPattern: const [8, 8],
                        borderType: BorderType.RRect,
                        child: CommonContainer(
                          containerColor: Colors.white,
                          child: Center(
                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonContainer(
                                  radius: 6,
                                  width: 60, height: 60, containerColor: Colors.black,
                                child: Center(child: SvgPicture.asset(CIconPath.poll)),
                                ),
                                const SizedBox(height: 10),
                                 Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text('Are there any products you are concerned about?Click here to create a new Poll and share it with your friends.'
                                  ,style: CTextStyle.bold12.copyWith(color: CColor.deepBlueBlack),
                                  ),
                                )
                              ],
                            ),
                          ),

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),


                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 20),
                  child: Stack(alignment: Alignment.centerRight,
                    children: [
                      CommonContainer(
                        width: Get.width-70,
                        height: 218,
                        containerColor: const Color(0xff80CCBF),
                        child:Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                SizedBox(
                                  height: 20,
                                  child: RichText(
                                    text: TextSpan(
                                      text: '2023.07.07',
                                      style: CTextStyle.bold14,

                                    ),
                                  ),
                                ),


                                SizedBox(
                                  height: 20,
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'New',
                                      style: CTextStyle.bold14,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),



                      ),
                      CommonContainer(
                        width: Get.width-90,
                        height: 218  ,
                        containerColor: Colors.white,
                      ),
                    ],
                  ),
                ),



              ],),
            ),
          ],
        ),
      );
    },
  );
}