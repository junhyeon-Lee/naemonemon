import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

import 'cart_controller.dart';
import 'cart_item.dart';

Widget cartScreen(double height) {
  return GetBuilder<CartController>(
    builder: (cartController) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: Flexible(
                    child: NotificationListener(
                      onNotification: (t) {
                        safePrint(homeController.cartScrollController.offset);

                        if (homeController.isScreenPosition) {
                          if (homeController.cartScrollController.position.userScrollDirection == ScrollDirection.reverse) {
                            if (homeController.exposureAppBar) {
                              homeController.exposureAppBar = false;
                              homeController.update();
                            }
                          } else if (homeController.cartScrollController.position.userScrollDirection == ScrollDirection.forward) {
                            if (!homeController.exposureAppBar) {
                              homeController.exposureAppBar = true;
                              homeController.update();
                            }
                          }
                        }

                        if (homeController.cartScrollController.position.userScrollDirection == ScrollDirection.idle) {}

                        return true;
                      },
                      child: GridView.builder(
                          controller: homeController.cartScrollController,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:

                          cartController.filteredCartList.isEmpty ? 3 :
                          (cartController.filteredCartList.length + 1) % 3 == 1 ?
                          cartController.filteredCartList.length + 3 + 3 :
                          (cartController.filteredCartList.length + 1) % 3 == 2 ?
                          cartController.filteredCartList.length + 2 + 3 :
                          cartController.filteredCartList.length + 1 + 3,

                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1 / 1,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return cartFirstItem();
                            }else if (index > cartController.filteredCartList.length) {
                              return cartDefaultItem();
                            } else {
                              return cartItem(cartController.filteredCartList[index - 1]);
                            }
                          }),
                    ),
                  ),
                ),
                if (cartController.filteredCartList.isEmpty)
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '관심 상품을 카트에 어떻게 담나요?',
                        style: CTextStyle.light18.copyWith(color: CColor.redCaution),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        ImagePath.guide1,
                        width: (Get.width - 60),
                      ),
                    ],
                  )
              ],
            ),
          ),




        ],
      );
    },
  );
}
