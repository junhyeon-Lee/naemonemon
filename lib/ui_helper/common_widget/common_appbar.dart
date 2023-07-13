import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/modules/main/home/group_screen/group_controller.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/modules/main/home/profile_screen/profile_screen.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';

class CommonAppbar extends AppBar implements PreferredSizeWidget {
  CommonAppbar({
    super.key,
    required String title,
    bool? isHelp
  }) : super(
    title: Text(title, style: CTextStyle.headerM),
    centerTitle: true,
    elevation: 0,
  );

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class HomeAppbar extends AppBar{
  HomeAppbar({
    super.key,
  }) : super(


    titleSpacing: 0,


    title: GetBuilder<HomeController>(
        builder: (controller) {
        return
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: controller.appbarScrollController,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width:Get.width,
                  child:
                  controller.allItemMode||controller.editGroupMode?
                  AnimatedPadding(
                    padding: EdgeInsets.only(left:controller.editGroupMode? 20:controller.allItemMode?80:-100, right: 12),
                    duration: const Duration(milliseconds: 500),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        (Get.find<GroupController>().selectGroupIndex==0||Get.find<GroupController>().selectGroupIndex==-1)
                            ? Text(controller.editGroupMode?'Edit Group' : 'All Items',style: CTextStyle.eHeader40,)
                            : Expanded(child: Text(Get.find<GroupController>().groupName.value,style: CTextStyle.eHeader40,))

                      ],
                    ),
                  ):
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 12),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(CIconPath.sovssoLogo, height: 42,),
                        GestureDetector(
                          onTap:(){
                            Get.to(const ProfileScreen(),transition: Transition.upToDown);
                          },
                          child: CommonContainer(
                              width: 48, height: 48,radius: 48,
                              child: Center(
                                child: Hero(
                                  tag: 'my_profile',
                                  child: SizedBox(width: 44, height: 44,
                                    child: ClipOval(
                                      child: AspectRatio(
                                        aspectRatio: 1.0, // Maintain a 1:1 aspect ratio for a circular shape
                                        child: Image.asset(CIconPath.sample),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),


                ),
                SizedBox(width: Get.width-72, height: 44,
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text('Poll',style: CTextStyle.eHeader40,),
                    ),
                  ],
                ),
                ),
              ],
            ),
          );
        }),
    centerTitle: true,
    elevation: 0,
  );
}