import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/my_poll/my_poll_screen.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';

import '../../modules/main/home/profile/profile_screen.dart';

class CommonAppbar extends AppBar implements PreferredSizeWidget {
  CommonAppbar({super.key, required String title})
      : super(
            title: Stack(alignment: Alignment.center,
              children: [
                Positioned.fill(child: SizedBox(width: Get.width, height: 78,)),
                SizedBox(width: Get.width,
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color:  CColor.subLightGray, width: 2)),
                            child: Center(
                                child: SvgPicture.asset(
                                  CIconPath.appbarBack,
                                  width: 26,
                                  color: CColor.subLightGray,
                                ))),
                      ),
                    ],
                  ),
                ),

                Positioned(child: Text(title,
                  style: CTextStyle.light26,
                )),

              ],
            ),
            centerTitle: true,
            elevation: 0,
            titleSpacing: 0,
            toolbarHeight: 78,
            leadingWidth: 0,
    leading: Container()
  );

  @override
  Size get preferredSize => const Size.fromHeight(78);
}

class HomeAppbar extends AppBar implements PreferredSizeWidget {
  HomeAppbar({
    super.key,
  }) : super(
          titleSpacing: 0,
          title: GetBuilder<HomeController>(builder: (controller) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: controller.appbarScrollController,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width,
                      height: 78-10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (homeController.modeSate == 'delete')
                                    GestureDetector(
                                      onTap: () {
                                        homeController.changeMode('main');
                                        cartController.cartItemSelectListClear();
                                      },
                                      child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                                              border: Border.all(color: CColor.subLightGray, width: 2)),
                                          child: Center(
                                              child: SvgPicture.asset(
                                            CIconPath.appbarBack,
                                            width: 26,
                                            color:  CColor.subLightGray,
                                          ))),
                                    )
                                  else
                                    const SizedBox(
                                      width: 36,
                                      height: 36,
                                    ),
                                  if (homeController.modeSate == 'delete')
                                    GestureDetector(
                                      onTap: (){
                                        cartController.showDeleteBottomSheet();
                                      },
                                      child: Text(
                                        '${cartController.selectedCartIdList.length}개 선택됨',
                                        style: CTextStyle.light12.copyWith(color: CColor.redCaution),
                                      ),
                                    )
                                  else
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(const ProfileScreen(), transition: Transition.fadeIn);
                                      },
                                      child: CommonContainer(
                                          width: 36,
                                          height: 36,
                                          radius: 36,
                                          child: Center(
                                            child: Hero(
                                              tag: 'preset',
                                              child: SizedBox(
                                                width: 44,
                                                height: 44,
                                                child: ClipOval(
                                                  child: AspectRatio(
                                                    aspectRatio: 1.0, // Maintain a 1:1 aspect ratio for a circular shape
                                                    child: userInfoController.usersInfo!.profileImage!.substring(0, 6) == 'assets'
                                                        ? Image.asset(userInfoController.usersInfo!.profileImage!)
                                                        : Image.network(userInfoController.usersInfo!.profileImage!),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                    ),
                                ],
                              ),
                            ),
                            Positioned(
                                child: Text(
                              homeController.modeSate == 'delete' ? 'Delete' : 'My Cart',
                              style: CTextStyle.light26,
                            )),
                          ],
                        ),
                      ),
                    ),


                    SizedBox(
                        width: Get.width-88-88,
                        child: Center(child: SvgPicture.asset(CIconPath.naemonemonLogoWithText, width: 100,))),

                    SizedBox(
                      width: 88,
                      height: 44,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                ///내 투표로 가기
                                Get.to(const MyPollScreen(), transition: Transition.rightToLeft);
                              },
                              child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                      border: Border.all(color: CColor.subLightGray, width: 2)),
                                  child: Center(
                                      child: SvgPicture.asset(
                                    CIconPath.feedMyPoll,
                                    width: 26,
                                    color: CColor.subLightGray,
                                  ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          centerTitle: true,
          elevation: 0,
        );

  @override
  Size get preferredSize => const Size.fromHeight(78);
}