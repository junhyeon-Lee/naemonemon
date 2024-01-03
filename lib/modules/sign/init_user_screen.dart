import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rive/rive.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/api_model/users/users_login.dart';
import 'package:shovving_pre/modules/main/home/home_screen.dart';
import 'package:shovving_pre/modules/sign/sign_controller/sign_repository.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';


import 'dart:io';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/indicator/indicator.dart';
import 'package:shovving_pre/util/sundry_widget/profile/inti_profile_controller.dart';
import 'package:shovving_pre/util/sundry_widget/profile/profile_image_widget.dart';

class InitUserScreen extends StatefulWidget {
  const InitUserScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InitUserScreen> createState() => _InitUserScreenState();
}

class _InitUserScreenState extends State<InitUserScreen> {
  late RiveAnimationController _controllerLeft;
  late RiveAnimationController _controllerRight;

  /// Is the animation currently playing?
  bool _isPlayingLeft = false;
  bool _isPlayingRight = false;

  @override
  void initState() {
    super.initState();
    _controllerLeft = OneShotAnimation(
      'Click',
      autoplay: false,
      onStop: () => setState(() => _isPlayingLeft = false),
      onStart: () => setState(() => _isPlayingLeft = true),
    );
    _controllerRight = OneShotAnimation(
      'Click',
      autoplay: false,
      onStop: () => setState(() => _isPlayingRight = false),
      onStart: () => setState(() => _isPlayingRight = true),
    );
  }


  @override
  Widget build(BuildContext context) {






    return GetBuilder<InitProfileController>(
      init: InitProfileController(),
      builder: (profileController) {
        Future.delayed(const Duration(milliseconds: 300), () {
          bool keyboardVisible = false;
          keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
          if (keyboardVisible == false && profileController.textFocusNode.hasFocus) {
            profileController.textFocusNode.unfocus();
            profileController.onFocus();
          }
        });

        if (profileController.isGuideStep) {
          return Stack(
            children: [
              const GuideWidget(),
              if(indicatorController.isLoading)
              myIndicator()
            ],
          );
        } else {
          return Stack(
            children: [
              GestureDetector(
                    onTap: () {
                      profileController.textFocusNode.unfocus();
                      profileController.onFocus();
                    },
                    child: Scaffold(
                        // resizeToAvoidBottomInset: false,
                        body: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(color: profileController.bgFilter ?? Colors.transparent),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: CommonContainer(
                                  containerColor: CColor.gray.withOpacity(0.5),
                                  width: Get.width - 50,
                                  height: Get.width - 40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Text(
                                          '당신을 표현하는 이미지는 무엇인가요?',
                                          style: CTextStyle.bold18.copyWith(color: CColor.deepBlueBlack),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [initProfileImage()],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CommonContainer(
                                  containerColor: CColor.gray.withOpacity(0.5),
                                  width: Get.width - 50,
                                  height: 128,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Text(
                                          '당신을 설명하는 별명은 무엇인가요?',
                                          style: CTextStyle.bold18.copyWith(color: CColor.deepBlueBlack),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            GestureDetector(
                                              onTap: () {
                                                profileController.leftSlot();
                                                _isPlayingLeft ? null : _controllerLeft.isActive = true;
                                              },
                                              child: Container(
                                                width: 46,
                                                height: 46,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                    border: Border.all(width: 2, color: CColor.subLightGray),
                                                    color: Colors.white),
                                                child:

                                                SizedBox(
                                                  width: 46,
                                                  child:


                                                  RiveAnimation.asset(
                                                    RivePath.dice,
                                                    animations: const ['idle'],
                                                    controllers: [_controllerLeft],
                                                    // onInit: (_) => setState(() {}),
                                                  ),),


                                              ),
                                            ),
                                            Container(
                                              width: Get.width - 192,
                                              height: 46,
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                                                  border: Border.all(width: 2, color: CColor.subLightGray),
                                                  color: Colors.white),
                                              child: Focus(
                                                child: TextField(
                                                  focusNode: profileController.textFocusNode,
                                                  controller: profileController.textEditingController,
                                                  textAlign: TextAlign.center,
                                                  style: CTextStyle.bold16.copyWith(decorationThickness: 0),
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    border: InputBorder.none,
                                                    hintText: '${profileController.leftWord}${profileController.rightWord}',
                                                    hintStyle: CTextStyle.bold16,
                                                    enabled: true,
                                                  ),
                                                ),
                                                onFocusChange: (hasFocus) {
                                                  profileController.onFocus();
                                                },
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                profileController.rightSlot();
                                                _isPlayingRight ? null : _controllerRight.isActive = true;
                                              },
                                              child: Container(
                                                width: 46,
                                                height: 46,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                    border: Border.all(width: 2, color: CColor.subLightGray),
                                                    color: Colors.white),
                                                child:

                                                SizedBox(
                                                    width: 46,
                                                    child:


                                                    RiveAnimation.asset(
                                                      RivePath.dice,
                                                      animations: const ['idle'],
                                                      controllers: [_controllerRight],
                                                     // onInit: (_) => setState(() {}),
                                                    ),),



                                                // Center(
                                                //     child: SvgPicture.asset(
                                                //       CIconPath.dice,
                                                //       color: CColor.deepBlueBlack,
                                                //       width: 24,
                                                //     )),



                                            ),)
                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: Get.height - Get.width - 178 - 60 - 60),
                                child: GestureDetector(
                                  onTap: () async {


                                    indicatorController.nowLoading();
                                    profileController.update();
                                    profileController.socialLogin();

                                    ///이게 소셜로그인 그거 올라오는 거고요 그 전에 동의 받아야지








                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 60),
                                    child: Column(
                                      children: [
                                        CommonContainer(
                                          width: Get.width - 70,
                                          height: 60,
                                          radius: 24,
                                          containerColor: CColor.redCaution,
                                          child: Center(
                                              child: Text(
                                            '빨리 시작할래요!',
                                            style: CTextStyle.bold22.copyWith(color: Colors.white),
                                          )),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                  ),
              if(indicatorController.isLoading)
                myIndicator()
            ],
          );
        }
      },
    );
  }
}

Widget agreeToggle(bool isSelected) {
  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        border: Border.all(width: 2, color: isSelected ? const Color(0xff58BD71) : Colors.white),
        color: isSelected ? Colors.transparent : Colors.black.withOpacity(0.3)),
    child: Visibility(visible: isSelected, child: SvgPicture.asset(CIconPath.checkItem)),
  );
}

class GuideWidget extends StatelessWidget {
  const GuideWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InitProfileController>(builder: (profileController) {
      List<Color> initGuideColorList = [
        const Color(0xff0038FF).withOpacity(0.1),
        const Color(0xff00FFB2).withOpacity(0.1),
        const Color(0xff0085FF).withOpacity(0.1),
        const Color(0xffFFB800).withOpacity(0.1)
      ];

      return Scaffold(
        backgroundColor: CColor.brightGray,
        body: Column(
          children: [
            Container(
              color: Colors.transparent,
              height: 87,
            ),
            Container(
                width: Get.width - 40,
                height: Get.height - 179,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned.fill(
                      child: Container(
                        width: Get.width - 40,
                        height: Get.height - 179,
                        color: Colors.transparent,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        width: Get.width - 40,
                        height: 200,
                        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(30))),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            SvgPicture.asset(CIconPath.naemonemonLogoWithText, height: 40,),
                          ],
                        ),
                      ),
                    ),


                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: SizedBox(
                        width: Get.width - 40,
                        height: Get.height - 179 - 95,
                        child:   ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(overscroll: false),
                          child: PageView(
                            controller:  profileController.guideImageController,
                            onPageChanged: (page){
                              profileController.guideImageIndex = page;
                              profileController.update();
                            },
                            //physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: Get.width - 40,
                                    height: Get.height - 179 - 95,
                                    decoration: BoxDecoration(
                                      color: initGuideColorList[0],
                                      image: DecorationImage(
                                        image: AssetImage(ImagePath.initGuideImageList[0]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: Get.width - 40,
                                    height: Get.height - 179 - 95,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(40,60,29,0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('환영합니다',style: CTextStyle.heavy50,),
                                          const SizedBox(height: 10,),
                                          Text('만나서 무척 반가워요. 내모네몬은 모든 쇼핑몰의 상품을 한곳에 담아서 사람들과 와글와글 이야기하는 소셜 쇼핑 서비스 입니다.',
                                            style: CTextStyle.regular21,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: Get.width - 40,
                                    height: Get.height - 179 - 95,
                                    decoration: BoxDecoration(
                                      color: initGuideColorList[1],
                                      image: DecorationImage(
                                        image: AssetImage(ImagePath.initGuideImageList[1]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: Get.width - 40,
                                    height: Get.height - 179 - 95,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(40,60,29,0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('카트에 담기',style: CTextStyle.heavy50,),
                                          const SizedBox(height: 10,),
                                          Text('수많은 쇼핑몰의 관심 상품을 한자리에 담아보세요. 당장 구매하게에 고민되는 상품, 의견이 필요한 상품 등 일단 내모네모에 담아 보세요.',
                                            style: CTextStyle.regular21,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: Get.width - 40,
                                    height: Get.height - 179 - 95,
                                    decoration: BoxDecoration(
                                      color: initGuideColorList[2],
                                      image: DecorationImage(
                                        image: AssetImage(ImagePath.initGuideImageList[2]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: Get.width - 40,
                                    height: Get.height - 179 - 95,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(40,60,29,0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('투표 만들기',style: CTextStyle.heavy50,),
                                          const SizedBox(height: 10,),
                                          Text('내게 어울리는 옷은 뭘까? 어떤 제품이 더 성능이 좋을까? 이런 고민들, 이제는 망설이지 말고 사람들과 함께하세요.',
                                            style: CTextStyle.regular21,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: Get.width - 40,
                                    height: Get.height - 179 - 95,
                                    decoration: BoxDecoration(
                                      color: initGuideColorList[3],
                                      image: DecorationImage(
                                        image: AssetImage(ImagePath.initGuideImageList[3]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: Get.width - 40,
                                    height: Get.height - 179 - 95,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(40,60,29,0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('발견하기',style: CTextStyle.heavy50,),
                                          const SizedBox(height: 10,),
                                          Text('요즘 뜨는 상품은 뭘까? 어떤 신기한 상품이 있을까? 내모네몬에서 찾아보세요. 새로운 발견을 할지도 몰라요!',
                                            style: CTextStyle.regular21,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),




                    Positioned(
                      right: 0,
                      child: Container(
                        width: 158,
                        height: 170,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: const BorderRadius.all(Radius.circular(30))),

                        child: Center(child: Text('시작하기',style: CTextStyle.light30.copyWith(color: Colors.white),)),

                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: (){
                          profileController.nextGuide();
                        },
                        child: CustomPaint(
                          size: const Size(205, 220),
                          painter: GuideDecorator(CColor.brightGray),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              color: Colors.transparent,
              height: 92,
            ),
          ],
        ),
      );
    });
  }
}

class GuideDecorator extends CustomPainter {
  const GuideDecorator(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 0.0
      ..style = PaintingStyle.fill;

    canvas.drawPath(
      getPath(size.width, size.height),
      paint,
    );
  }

  Path getPath(double width, double height) {
    color:
    Colors.transparent;
    final path = Path();
    path.moveTo(0, height);
    path.lineTo(40, height + 10);
    path.lineTo(80, height);
    path.arcToPoint(Offset(80 - 30, height - 30), radius: const Radius.circular(30));

    // //
    path.lineTo(80 - 30, 80);
    // //
    path.arcToPoint(const Offset(80, 50), radius: const Radius.circular(30));
    // //
    path.lineTo(width - 30, 50);

    path.arcToPoint(Offset(width, 80), radius: const Radius.circular(30));
    path.lineTo(width + 10, 40);
    path.lineTo(width, 0);
     path.arcToPoint(Offset(width - 30, 30), radius: const Radius.circular(30));
    path.lineTo(60,30);
    path.arcToPoint(
      const Offset(30, 60), // End point
      radius: const Radius.circular(30), // Radius of the arc
      largeArc: false, // Set to true for a large arc, or false for a small arc
      clockwise: false, // Set to false for a counterclockwise arc
    );

    path.lineTo(30, height - 30);
    path.arcToPoint(Offset(0, height), radius: const Radius.circular(30));

    // path.quadraticBezierTo(width*0.60, height*0.85, width*0.65, height*0.65);
    // path.quadraticBezierTo(width*0.70, height*0.90, width, 0);
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}







