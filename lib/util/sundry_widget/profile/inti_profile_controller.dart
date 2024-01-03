import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/api_model/users/users_info.dart';
import 'package:shovving_pre/models/api_model/users/users_login.dart';
import 'package:shovving_pre/modules/main/home/cart/cart_repository.dart';
import 'package:shovving_pre/modules/main/home/home_screen.dart';
import 'package:shovving_pre/modules/sign/init_user_screen.dart';
import 'package:shovving_pre/modules/sign/sign_controller/sign_repository.dart';
import 'package:shovving_pre/modules/sign/sign_controller/splash_controller.dart';
import 'package:shovving_pre/modules/sign/splash_screen.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/dio/dio_api.dart';
import 'package:shovving_pre/util/local_repository/local_user_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/indicator/indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'nickname_preset.dart';

class InitProfileController extends GetxController {
  @override
  void onInit() {
    leftWord = NickNamePreset.leftWord[Random().nextInt(270)];
    rightWord = NickNamePreset.rightWord[Random().nextInt(390)];

    textEditingController = TextEditingController();
    textFocusNode = FocusNode();
    nickNameChangeFocusNode = FocusNode();

    super.onInit();
  }

  late TextEditingController textEditingController;
  late FocusNode textFocusNode;
  late FocusNode nickNameChangeFocusNode;
  ScrollController scrollController = ScrollController();

  String leftWord = '';
  String rightWord = '';
  String videoPath = '';
  String profilePath = ImagePath.presetProfile[0];
  String? settingImage;
  Color? bgFilter;

  File? userSelfImage;

  leftSlot() {
    textFocusNode.unfocus();
    textEditingController.clear();
    leftWord = NickNamePreset.leftWord[Random().nextInt(270)];
    update();
  }

  rightSlot() {
    textFocusNode.unfocus();
    textEditingController.clear();
    rightWord = NickNamePreset.rightWord[Random().nextInt(390)];
    update();
  }

  onFocus() {
    update();
  }

  SignRepository signRepository = SignRepository();

  String? socialToken;
  int? loginType;

  ///이 함수는 이메일을 알아내고 이를 바탕으로 유저 정보를 업데이트 합니다.
  Future<void> socialLogin() async {
    ///먼저 프사랑 닉네임이랑
    String nickName = '$leftWord$rightWord';
    if (textEditingController.text.isNotEmpty) {
      nickName = textEditingController.text;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(socialToken!);

    if (decodedToken['email'].toString().contains('@')) {
      safePrint(loginType);
      safePrint(
        decodedToken['email'].toString(),
      );
      safePrint(nickName);
      safePrint(profilePath);

      indicatorController.nowLoading();
      update();
      await signRepository.loginNovice(decodedToken['email'].toString(), loginType!);

      LocalUserRepository localUserRepository = LocalUserRepository();
      localUserRepository.setSocialToken(socialToken!, loginType!);

      UsersInfo? response = await signRepository.updateUsersSocialInfo(loginType!, decodedToken['email'].toString(), nickName, profilePath);

      update();

      ///여기서 다 가져오기 알지?
      await cartRepository.setCartList();
      await feedController.setFeedList();
      pollController.setPollList();
      pollController.setJoinedPollList();

      ///데이터 적용 완료
      Get.offAll(const HomeScreen());
    }
  }

  CartRepository cartRepository = CartRepository();

  // Future<bool?> noviceLogin() async {
  //   UserLogin? noviceLoginResponse = await signRepository.loginNovice();
  //   if (noviceLoginResponse != null) {
  //     UsersInfo? response = await signRepository.getUsersInfo();
  //     if (response?.profileImage != null && response?.nickName != null) {
  //       return false;
  //     } else {
  //       return true;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

  ///이 함수가 검증을 해야합니다. 이 소셜 정보가 정상인지 아닌지를
  loginExistingAccount(int loginTypeData) async {
    String? token;
    if (loginTypeData == 1) {
      safePrint('카카오 로그인 시도');
      token = await signRepository.signWithKaKao();
    } else if (loginTypeData == 2) {
      token = await signRepository.signWithGoogle();
    } else if (loginTypeData == 3) {
      token = await signRepository.signWithNaver();
    }

    if (token != null) {
      LocalUserRepository localUserRepository = LocalUserRepository();
      localUserRepository.deleteAGroupOrder();

      socialToken = token;
      loginType = loginTypeData;
      safePrint('로그인 타입 $loginTypeData');

      indicatorController.nowLoading();
      update();
      UserLogin? socialLoginResponse = await signRepository.loginWithSocial(loginTypeData, token);

      ///신규회원이면 여기서 끝남 그러니까 이 이후는 따로 함수로 하자

      ///위 api가 팅이 안나면 이 함수가 돕니다.
      if (socialLoginResponse != null) {
        await signRepository.loginWithSocial(loginTypeData, token);
        UsersInfo? response = await signRepository.getUsersInfo();

        await cartRepository.setCartList();
        await feedController.setFeedList();
        pollController.setPollList();
        pollController.setJoinedPollList();

        ///데이터 적용 완료
        Get.offAll(const HomeScreen());
      } else {}
    } else {
      ///로그인을 실패하면 어쩌나 그냥 겟백 하면 될듯 다시 하라는 의미에서 토스트나 띄워주자
    }

    // }
  }


  loginAdministrator(int administratorNo)async {

    String token ='';

    switch(administratorNo){
      case 1: token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluaXN0cmF0b3IwMUBnbWFpbC5jb20iLCJpYXQiOjE3MDI1MjQ4NjEsImlzcyI6Imh0dHBzOi8vZ2l0aHViLmNvbS9qb25hc3JvdXNzZWwvZGFydF9qc29ud2VidG9rZW4ifQ.cdqLhBd74v74gk0TmyOf3JYS4ZOSP3LF8uTvSuxxB3I'; break;
      case 2: token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluaXN0cmF0b3IwMkBnbWFpbC5jb20iLCJpYXQiOjE3MDI1MjQ4ODQsImlzcyI6Imh0dHBzOi8vZ2l0aHViLmNvbS9qb25hc3JvdXNzZWwvZGFydF9qc29ud2VidG9rZW4ifQ.1UAksvpwxsglHujapamgrNeR2vDty2V-XoP03Mqpmjc'; break;
      case 3: token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluaXN0cmF0b3IwM0BnbWFpbC5jb20iLCJpYXQiOjE3MDI1MjQ5MDIsImlzcyI6Imh0dHBzOi8vZ2l0aHViLmNvbS9qb25hc3JvdXNzZWwvZGFydF9qc29ud2VidG9rZW4ifQ.wpJQfN-B_2hxADS2-3MhP7ASd8nCDyDTui324kPaAe4'; break;
      case 4: token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluaXN0cmF0b3IwNEBnbWFpbC5jb20iLCJpYXQiOjE3MDI1MjQ5MTcsImlzcyI6Imh0dHBzOi8vZ2l0aHViLmNvbS9qb25hc3JvdXNzZWwvZGFydF9qc29ud2VidG9rZW4ifQ.59tDu1FDF12_Jc2EUkvZGY1pwQEjgC-FwU7PDYqQHFk'; break;
      case 5: token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluaXN0cmF0b3IwNUBnbWFpbC5jb20iLCJpYXQiOjE3MDI1MjQ5MzcsImlzcyI6Imh0dHBzOi8vZ2l0aHViLmNvbS9qb25hc3JvdXNzZWwvZGFydF9qc29ud2VidG9rZW4ifQ.7H3if6igwxujdYF1Mu64UtAOi8Cv0sapziqkdXKcO20'; break;
    }



      LocalUserRepository localUserRepository = LocalUserRepository();
      localUserRepository.deleteAGroupOrder();

      socialToken = token;
      loginType = 3;

      indicatorController.nowLoading();
      update();
      UserLogin? socialLoginResponse = await signRepository.loginWithSocial(3, token);

      if (socialLoginResponse != null) {
        await signRepository.loginWithSocial(3, token);
        UsersInfo? response = await signRepository.getUsersInfo();

        await cartRepository.setCartList();
        await feedController.setFeedList();
        pollController.setPollList();
        pollController.setJoinedPollList();

        ///데이터 적용 완료
        Get.offAll(const HomeScreen());
      } else {}


    // }
  }

  ///동의
  bool isAllAgree = false;
  bool isService = false;
  bool isPersonal = false;
  bool isMarketing = false;

  agreeService() {
    isService ? isService = false : isService = true;
    isService && isPersonal && isMarketing ? isAllAgree = true : isAllAgree = false;
    update();
    safePrint('전체 : $isAllAgree  서비스 : $isService  개인정보 : $isPersonal  광고성  :  $isMarketing');
  }

  agreePersonal() {
    isPersonal ? isPersonal = false : isPersonal = true;
    isService && isPersonal && isMarketing ? isAllAgree = true : isAllAgree = false;
    update();
    safePrint('전체 : $isAllAgree  서비스 : $isService  개인정보 : $isPersonal  광고성  :  $isMarketing');
  }

  agreeMarketing() {
    isMarketing ? isMarketing = false : isMarketing = true;
    isService && isPersonal && isMarketing ? isAllAgree = true : isAllAgree = false;
    update();
    safePrint('전체 : $isAllAgree  서비스 : $isService  개인정보 : $isPersonal  광고성  :  $isMarketing');
  }

  agreeAll() {
    if (isAllAgree) {
      isAllAgree = false;
      isService = false;
      isPersonal = false;
      isMarketing = false;
    } else {
      isAllAgree = true;
      isService = true;
      isPersonal = true;
      isMarketing = true;
    }
    update();
    safePrint('전체 : $isAllAgree  서비스 : $isService  개인정보 : $isPersonal  광고성  :  $isMarketing');
  }

  launchTerms(int index) async {
    String termsUrl = '';
    switch (index) {
      case 0:
        termsUrl = 'https://relic-barberry-504.notion.site/7bb02c9c469e44f3a9785c316445cb02';
        break;
      case 1:
        termsUrl = 'https://relic-barberry-504.notion.site/69a73968ee234b22be8f3c7bf95c2b43';
        break;
      case 2:
        termsUrl = 'https://relic-barberry-504.notion.site/f9e07956de8841e6963938c2887b9acb';
        break;
    }
    final url = Uri.parse(termsUrl);

    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  showAgree() {
    Get.bottomSheet(
        isDismissible: false,
        enableDrag: false,
        WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: GetBuilder<InitProfileController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                      color: Colors.white,
                    ),
                    width: Get.width - 40,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 26,
                        ),
                        Text(
                          '약관 동의',
                          style: CTextStyle.light16,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    controller.agreeAll();
                                  },
                                  child: agreeToggle(controller.isAllAgree)),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '전체 동의',
                                style: CTextStyle.regular14,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: Get.width - 120,
                          height: 1,
                          color: CColor.gray,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        controller.agreeService();
                                      },
                                      child: agreeToggle(controller.isService)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '(필수) 서비스 이용약관',
                                    style: CTextStyle.regular14,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.launchTerms(0);
                                },
                                child: Text(
                                  "더보기",
                                  style: CTextStyle.light12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        controller.agreePersonal();
                                      },
                                      child: agreeToggle(controller.isPersonal)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '(필수) 개인정보 처리방침',
                                    style: CTextStyle.regular14,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.launchTerms(1);
                                },
                                child: Text(
                                  '더보기',
                                  style: CTextStyle.light12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        controller.agreeMarketing();
                                      },
                                      child: agreeToggle(controller.isMarketing)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '(선택) 광고성 정보 수신 동의',
                                    style: CTextStyle.regular14,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.launchTerms(2);
                                },
                                child: Text(
                                  '더보기',
                                  style: CTextStyle.light12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller.isService && controller.isPersonal) {
                              Get.back();
                            }
                          },
                          child: Container(
                            width: Get.width - 80,
                            height: 46,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                                color: controller.isService && controller.isPersonal ? CColor.mainPurple : CColor.mainPurple.withOpacity(0.3)),
                            child: Center(
                              child: Text(
                                '확인',
                                style: CTextStyle.eHeader20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
              );
            },
          ),
        )).whenComplete(() => showSocialLogin());
  }

  bool isGuideStep = true;

  showSocialLogin() {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                color: Colors.white,
              ),
              height: 242.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 26.h,
                  ),
                  Text(
                    '소셜 로그인으로 시작하기',
                    style: CTextStyle.light16.copyWith(fontSize: 16.sp, height: 18.sp / 16.sp),
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Text(
                    '소셜 로그인으로 서비스를 빠르게 시작할 수 있어요.',
                    style: CTextStyle.light14.copyWith(fontSize: 14.sp, height: 15.sp / 14.sp),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  isAdministrator
                      ? Container(
                          width: Get.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 1,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    loginAdministrator(1);
                                  },
                                  child: Container(
                                      width: 50,
                                      height: 40,
                                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: CColor.gray),
                                      child: const Center(child: Text('관리자1'))),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    loginAdministrator(2);
                                  },
                                  child: Container(
                                      width: 50,
                                      height: 40,
                                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: CColor.gray),
                                      child: const Center(child: Text('관리자2'))),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    loginAdministrator(3);
                                  },
                                  child: Container(
                                      width: 50,
                                      height: 40,
                                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: CColor.gray),
                                      child: const Center(child: Text('관리자3'))),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    loginAdministrator(4);
                                  },
                                  child: Container(
                                      width: 50,
                                      height: 40,
                                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: CColor.gray),
                                      child: const Center(child: Text('관리자4'))),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    loginAdministrator(5);
                                  },
                                  child: Container(
                                      width: 50,
                                      height: 40,
                                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: CColor.gray),
                                      child: const Center(child: Text('관리자5'))),
                                ),
                                const SizedBox(
                                  width: 1,
                                ),
                                // Image.asset(
                                //     ImagePath.apple,
                                //     width: (Get.width-90.w)/4
                                // ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          width: Get.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 1,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    loginExistingAccount(2);
                                  },
                                  child: Image.asset(ImagePath.google, width: (Get.width - 90.w) / 4),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    loginExistingAccount(1);
                                  },
                                  child: Image.asset(ImagePath.kakao, width: (Get.width - 90.w) / 4),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    loginExistingAccount(3);
                                  },
                                  child: Image.asset(ImagePath.naver, width: (Get.width - 90.w) / 4),
                                ),
                                const SizedBox(
                                  width: 1,
                                ),
                                // Image.asset(
                                //     ImagePath.apple,
                                //     width: (Get.width-90.w)/4
                                // ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
            if (indicatorController.isLoading) myIndicator(),
          ],
        ),
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  int guideImageIndex = 0;
  PageController guideImageController = PageController();

  nextGuide() {
    if (3 == guideImageIndex) {
      ///여기서 동의창 열기
      showAgree();
      //isGuideStep = false;
      update();
    } else {
      guideImageController.animateToPage(guideImageIndex + 1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
    }
  }
}
