import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/modules/main/home/profile/profile_controller.dart';
import 'package:shovving_pre/modules/sign/sign_controller/sign_repository.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/profile/profile_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_setting_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (profileController) {
        return GestureDetector(
          onTap: () {
            profileController.closeNicknameChangeMode();
          },
          child: Scaffold(
              backgroundColor: CColor.brightGray,
              body: SizedBox(
                width: Get.width,
                height: Get.height,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              profileImage(),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (profileController.isNicknameChangeMode == false)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 24),
                                Text(
                                  userInfoController.usersInfo!.nickName!,
                                  style: CTextStyle.eHeader22,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      profileController.openNicknameChangeMode();
                                    },
                                    child: SvgPicture.asset(
                                      CIconPath.nickNameEdit,
                                      width: 24,
                                    ))
                              ],
                            ),
                          if (profileController.isNicknameChangeMode)
                            CommonContainer(
                              containerColor: CColor.gray.withOpacity(0.5),
                              width: Get.width - 50,
                              height: 178,
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
                                            child: SizedBox(
                                              width: 46,
                                              child: RiveAnimation.asset(
                                                RivePath.dice,
                                                animations: const ['idle'],
                                                controllers: [_controllerLeft],
                                                // onInit: (_) => setState(() {}),
                                              ),
                                            ),
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
                                              // profileController.onFocus();
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
                                            child: SizedBox(
                                              width: 46,
                                              child: RiveAnimation.asset(
                                                RivePath.dice,
                                                animations: const ['idle'],
                                                controllers: [_controllerRight],
                                                // onInit: (_) => setState(() {}),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        profileController.closeNicknameChangeMode();
                                        profileController.userInitUpdate();
                                      },
                                      child: CommonContainer(
                                        width: Get.width - 120,
                                        height: 40,
                                        radius: 24,
                                        containerColor: CColor.redCaution,
                                        child: Center(
                                            child: Text(
                                          '닉네임 변경하기',
                                          style: CTextStyle.bold22.copyWith(color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          // SizedBox(height: 15,),
                          // Text(userInfoController.usersInfo!.email!)
                        ],
                      ),
                    ),

                    Positioned(
                        top: 330 + 84,
                        child: GestureDetector(
                          onTap: (){
                            Get.to(const AppSettingScreen());
                          },
                          child: Container(
                            width: Get.width - 40,
                            height: 60,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                                    color: CColor.lavender,
                                  ),
                                  child: Center(child: SvgPicture.asset(CIconPath.setting)),
                                ),
                                const SizedBox(width: 18),
                                Text('앱 설정',style: CTextStyle.regular21.copyWith(fontSize: 22, color: CColor.deepBlueBlack),)

                              ],
                            ),
                          ),
                        )),

                    Positioned(
                        bottom: 20,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              width: 52,
                              height: 52,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                color: Colors.white
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  CIconPath.arrowBackDouble,
                                  width: 42,
                                ),
                              )),
                        )),

                    Positioned(
                        bottom: 35,
                        right: 20,
                        child: Text(
                          appVersion,
                          style: CTextStyle.bold12.copyWith(height: 1, color: Colors.black),
                        )),

                    Positioned(
                        bottom: 35,
                        left: 20,
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  final url = Uri.parse(
                                    'https://relic-barberry-504.notion.site/69a73968ee234b22be8f3c7bf95c2b43',
                                  );
                                  if (await canLaunchUrl(url)) {
                                    launchUrl(url, mode: LaunchMode.externalApplication);
                                  } else {
                                    // ignore: avoid_print
                                    print("Can't launch $url");
                                  }
                                },
                                child: Text(
                                  '이용약관',
                                  style: CTextStyle.bold12.copyWith(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                '|',
                                style: CTextStyle.bold12.copyWith(
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  final url = Uri.parse(
                                    'https://relic-barberry-504.notion.site/7bb02c9c469e44f3a9785c316445cb02',
                                  );
                                  if (await canLaunchUrl(url)) {
                                    launchUrl(url, mode: LaunchMode.externalApplication);
                                  } else {
                                    // ignore: avoid_print
                                    print("Can't launch $url");
                                  }
                                },
                                child: Text(
                                  '개인정보정책',
                                  style: CTextStyle.bold12.copyWith(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                )),
                          ],
                        )),

                    Positioned(
                        top: 64,
                        right: 20,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            safePrint('로그아웃');
                            profileController.showLogoutBottomSheet();

                            ///소셜 로그아웃
                          },
                          child: Text(
                            '로그아웃',
                            style: CTextStyle.bold12.copyWith(height: 1, color: Colors.black, decoration: TextDecoration.underline),
                          ),
                        )),

                    // if(userInfoController.usersInfo?.email==null)
                    // Positioned(
                    //     bottom: 80,
                    //     child: GestureDetector(
                    //       behavior: HitTestBehavior.translucent,
                    //       onTap: (){
                    //         Get.back();
                    //       },
                    //       child: SizedBox(
                    //         width: Get.width,
                    //         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             const SizedBox(
                    //               width: 1,
                    //             ),
                    //             GestureDetector(
                    //               onTap: (){
                    //                 profileController.socialLogin(1);
                    //               },
                    //               child: SizedBox(
                    //                   width: 42, height: 42,
                    //                   child: Image.asset(ImagePath.kakao,width: 42,)),
                    //             ),
                    //             GestureDetector(
                    //               onTap: (){
                    //                 profileController.socialLogin(3);
                    //               },
                    //               child: SizedBox(
                    //                   width: 42, height: 42,
                    //                   child: Image.asset(ImagePath.naver,width: 42,)),
                    //             ),
                    //             GestureDetector(
                    //               onTap: (){
                    //                 profileController.socialLogin(2);
                    //               },
                    //               child: SizedBox(
                    //                   width: 42, height: 42,
                    //                   child: Image.asset(ImagePath.google,width: 42,)),
                    //             ),
                    //             SizedBox(
                    //                 width: 42, height: 42,
                    //                 child: Image.asset(ImagePath.apple,width: 42,)),
                    //             const SizedBox(
                    //               width: 1,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     )),
                  ],
                ),
              )),
        );
      },
    );
  }
}

class PresetProfileScreen extends StatelessWidget {
  const PresetProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        Widget presetImage(int index) {
          return GestureDetector(
            onTap: () async {
              profileController.settingImage = ImagePath.presetProfile[index];

              profileController.update();
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
              child: CachedNetworkImage(
                imageUrl: ImagePath.presetProfile[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: CColor.gray.withOpacity(0.3),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        }

        return Scaffold(
            body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 147,
                child: Hero(
                  tag: 'preset',
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(260)),
                      border: Border.all(width: 8, color: CColor.lightGray),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: profileController.settingImage ?? profileController.profilePath,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: CColor.gray.withOpacity(0.3),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 147 + 260 + 64 + 20,
                  child: CommonContainer(
                    width: Get.width - 40,
                    height: 200,
                    containerColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              presetImage(0),
                              presetImage(1),
                              presetImage(2),
                              presetImage(3),
                              presetImage(4),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              presetImage(5),
                              presetImage(6),
                              presetImage(7),
                              presetImage(8),
                              presetImage(9),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                top: 147 + 260 + 64,
                child: GestureDetector(
                  onTap: () async {
                    profileController.profilePath = profileController.settingImage ?? profileController.profilePath;
                    profileController.userSelfImage = null;

                    SignRepository signRepository = SignRepository();
                    await signRepository.updateUsersInfo(userInfoController.usersInfo!.nickName!, profileController.settingImage!);
                    profileController.update();
                    homeController.update();
                    Get.back();
                  },
                  child: CommonContainer(
                    width: Get.width - 40,
                    height: 40,
                    containerColor: CColor.redCaution,
                    child: Center(child: SvgPicture.asset(CIconPath.upload, width: 34)),
                  ),
                ),
              ),
              Positioned(
                top: 147 + 260 + 200 + 64,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: CommonContainer(
                    width: Get.width - 40,
                    height: 40,
                    containerColor: CColor.subLightGray,
                    child: SvgPicture.asset(CIconPath.back),
                  ),
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
