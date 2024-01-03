import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/api_model/cart/cart.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/ui_helper/common_widget/common_appbar.dart';
import 'package:shovving_pre/util/sundry_function/image_uploader/image_uploade_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/sharing_function/favicon_get.dart';
import 'package:shovving_pre/util/sundry_function/sharing_function/sharing_function.dart';
import 'package:shovving_pre/util/sundry_widget/indicator/indicator.dart';

import '../../cart/cart_controller.dart';
import '../../cart/cart_item.dart';
import '../../cart/cart_repository.dart';
import 'poll_create_controller.dart';

class PollCreateScreen extends StatelessWidget {
  const PollCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .viewPadding
        .top;
    double appBarHeight = 68;
    double widgetHeight1 = 59;

    ///무엇이 고민이신가요? + 우아래 패딩
    double widgetHeight2 = 120;

    ///무엇이 고민이신가요. 입력창
    double widgetHeight3 = 59;

    ///아이템을 추가 해보세요? + 우아래 패딩
    double widgetHeight4 = 80;

    ///카트 직접입력 갤러리 위젯
    double widgetHeight5 = 120;

    ///공개투표, 지인투표
    double widgetHeight6 = 76;

    ///투표만들기 + 우아래 패딩
    double emptyHeight =
        Get.height - (height + appBarHeight + widgetHeight1 + widgetHeight2 + widgetHeight3 + widgetHeight4 + widgetHeight5 + widgetHeight6);

    return
      GetBuilder<PollCreateController>(
          init: PollCreateController(),
          builder: (controller) {
            return Stack(
              children: [
                Scaffold(
                    backgroundColor: Colors.white,
                    appBar: CommonAppbar(title: ' 글 쓰기'),
                    body: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView(
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 13),
                            child: Text(
                              '무엇이 고민인가요?',
                              style: CTextStyle.light26,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                                height: widgetHeight2,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: const Color(0xffe0e0e0)),
                                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                                child: Center(
                                  child: SizedBox(
                                    width: Get.width - 80,
                                    height: 100,
                                    child: TextField(

                                      controller: controller.pollComment,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      style: CTextStyle.light16.copyWith(decorationThickness: 0),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintText: '무엇이 고민인가요?',
                                        hintStyle: CTextStyle.light16.copyWith(color: CColor.gray),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          if (controller.pollItems.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 13),
                              child: Text(
                                '추가 된 아이템',
                                style: CTextStyle.light26,
                              ),
                            ),
                          if (controller.pollItems.isNotEmpty)
                            Container(
                                constraints: BoxConstraints(
                                  minHeight: emptyHeight - 20 - 59,
                                ),
                                child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.pollItems.length,
                                    itemBuilder: (BuildContext ctx, int index) {
                                      return Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Stack(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10),
                                                          child: SizedBox(
                                                            width: 80,
                                                            height: 80,
                                                            child: ClipRRect(
                                                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                              child: CachedNetworkImage(
                                                                imageUrl: controller.pollItems[index].image!.split(',')[0],
                                                                fit: BoxFit.cover,
                                                                placeholder: (context, url) =>
                                                                    Container(
                                                                      color: CColor.gray.withOpacity(0.3),
                                                                    ),
                                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 2),
                                                          child: Column(
                                                            children: [
                                                              faviconGet(controller.pollItems[index].url) != null ?
                                                              Row(
                                                                children: [
                                                                  ClipRRect(
                                                                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                                      child: controller.pollItems[index].localId.substring(0, 7) == 'UrlData'
                                                                          ? Image.asset(
                                                                        faviconGet(controller.pollItems[index].url) ?? '',
                                                                        width: 14,
                                                                      )
                                                                          : Image.asset(
                                                                        ImagePath.galleryImage,
                                                                        width: 14,
                                                                      )),
                                                                  const SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  SizedBox(
                                                                    width: Get.width - 200,
                                                                    child: controller.pollItems[index].localId.substring(0, 7) == 'UrlData'
                                                                        ? Text(
                                                                      mallNameGet(controller.pollItems[index].url) ?? '',
                                                                      style: CTextStyle.bold12.copyWith(color: Colors.black),
                                                                    )
                                                                        : Text(
                                                                      '갤러리',
                                                                      style: CTextStyle.bold12.copyWith(color: Colors.black),
                                                                    ),
                                                                  )
                                                                ],
                                                              ) :
                                                              Row(
                                                                children: [
                                                                  const SizedBox(width: 14, height: 14,),
                                                                  const SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  SizedBox(
                                                                    width: Get.width - 200,
                                                                  )
                                                                ],
                                                              )


                                                              ,
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              SizedBox(
                                                                width: Get.width - 200,
                                                                height: 32,
                                                                child: controller.pollItems[index].url.substring(0, 5) != 'empty'
                                                                    ? Text(
                                                                  controller.pollItems[index].title ?? "",
                                                                  style: CTextStyle.bold14.copyWith(color: Colors.black),
                                                                  maxLines: 2,
                                                                )
                                                                    : Text(
                                                                  '직접 추가 한 이미지 입니다.',
                                                                  style: CTextStyle.bold14.copyWith(color: CColor.gray),
                                                                  maxLines: 2,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              SizedBox(
                                                                width: Get.width - 200,
                                                                child: Text(
                                                                  '(선택) 이미지 추가, 최대 4장',
                                                                  style: CTextStyle.light10,
                                                                  maxLines: 2,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(width: 6),
                                                        GestureDetector(
                                                            onTap: () {
                                                              controller.pollItems.removeAt(index);
                                                              controller.update();
                                                            },
                                                            child: SvgPicture.asset(
                                                              CIconPath.delete,
                                                              width: 24,
                                                              color: Colors.black,
                                                            ))
                                                      ],
                                                    ),
                                                    if(controller.eachItemImage.isNotEmpty)
                                                      if(controller.eachItemImage.length >= index + 1)
                                                        if (controller.eachItemImage[index].isEmpty)
                                                          Positioned(
                                                              bottom: 0,
                                                              left: 64,
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  showAddImageBottomSheet(index, 0);
                                                                },
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.white.withOpacity(0.8),
                                                                      border: Border.all(width: 1, color: CColor.gray),
                                                                      borderRadius: const BorderRadius.all(Radius.circular(6))),
                                                                  width: 30,
                                                                  height: 30,
                                                                  child: Center(
                                                                      child: SvgPicture.asset(
                                                                        CIconPath.plus,
                                                                        color: Colors.black,
                                                                        width: 14,
                                                                      )),
                                                                ),
                                                              )),


                                                    if (controller.eachItemImage.isEmpty)
                                                      Positioned(
                                                          bottom: 0,
                                                          left: 64,
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              showAddImageBottomSheet(index, 0);
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white.withOpacity(0.8),
                                                                  border: Border.all(width: 1, color: CColor.gray),
                                                                  borderRadius: const BorderRadius.all(Radius.circular(6))),
                                                              width: 30,
                                                              height: 30,
                                                              child: Center(
                                                                  child: SvgPicture.asset(
                                                                    CIconPath.plus,
                                                                    color: Colors.black,
                                                                    width: 14,
                                                                  )),
                                                            ),
                                                          )),

                                                    if(controller.eachItemImage.length < controller.pollItems.length &&
                                                        controller.eachItemImage.length < index + 1)
                                                      Positioned(
                                                          bottom: 0,
                                                          left: 64,
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              showAddImageBottomSheet(index, 0);
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white.withOpacity(0.8),
                                                                  border: Border.all(width: 1, color: CColor.gray),
                                                                  borderRadius: const BorderRadius.all(Radius.circular(6))),
                                                              width: 30,
                                                              height: 30,
                                                              child: Center(
                                                                  child: SvgPicture.asset(
                                                                    CIconPath.plus,
                                                                    color: Colors.black,
                                                                    width: 14,
                                                                  )),
                                                            ),
                                                          )),


                                                  ],
                                                ),
                                              ),
                                              if (index != controller.pollItems.length - 1)
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                  child: Container(
                                                    height: 1,
                                                    color: CColor.brightGray,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          if (controller.eachItemImage.isNotEmpty)
                                            if(controller.eachItemImage.length > index)
                                              if (controller.eachItemImage[index].isNotEmpty)
                                                Positioned(
                                                  right: 60,
                                                  child: Container(
                                                      width: Get.width - 40 - 30 - 80 - 10 - 10 - 10 + 4,
                                                      height: 80,
                                                      color: Colors.white.withOpacity(0.8),
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: controller.eachItemImage[index].length + 1,
                                                          itemBuilder: (BuildContext ctx, int itemIndex) {
                                                            if (itemIndex == controller.eachItemImage[index].length) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 58,
                                                                  height: 58,
                                                                  child: Center(
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        showAddImageBottomSheet(index, controller.eachItemImage[index].length);
                                                                      },
                                                                      child: Container(
                                                                        width: 50,
                                                                        height: 50,
                                                                        decoration: BoxDecoration(
                                                                            border: Border.all(width: 1, color: Colors.black),
                                                                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                                                                            color: Colors.white),
                                                                        child: Center(
                                                                            child: SvgPicture.asset(
                                                                              CIconPath.plus,
                                                                              color: Colors.black,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              return Center(
                                                                child: Stack(alignment: Alignment.topRight,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 58,
                                                                      height: 58,
                                                                      child: Center(
                                                                        child: Container(
                                                                          width: 50,
                                                                          height: 50,
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(width: 1, color: const Color(0xfff7f6f9)),
                                                                              borderRadius: const BorderRadius.all(Radius.circular(6))),
                                                                          child: ClipRRect(
                                                                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                                                                            child: CachedNetworkImage(
                                                                              imageUrl: controller.eachItemImage[index][itemIndex],
                                                                              fit: BoxFit.cover,
                                                                              placeholder: (context, url) =>
                                                                                  Container(
                                                                                    color: CColor.gray.withOpacity(0.3),
                                                                                  ),
                                                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        controller.deleteEachImage(index, itemIndex);
                                                                      },
                                                                      child: Container(width: 16, height: 16,
                                                                        decoration: const BoxDecoration(
                                                                            color: Colors.black,
                                                                            borderRadius: BorderRadius.all(Radius.circular(16))
                                                                        ),
                                                                        child: Center(child: SvgPicture.asset(
                                                                            CIconPath.close, color: Colors.white, width: 12)),
                                                                      ),
                                                                    )

                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                          })),
                                                )
                                        ],
                                      );
                                    })),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 13),
                            child: Text(
                              '아이템을 추가 해보세요',
                              style: CTextStyle.light26,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showCartBottomSheet();
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2, color: CColor.brightGray),
                                        borderRadius: const BorderRadius.all(Radius.circular(16))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Center(
                                            child: SvgPicture.asset(
                                              CIconPath.cart,
                                              width: 40,
                                            ),
                                          ),
                                          Text(
                                            '카트',
                                            style: CTextStyle.eHeader16,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    showUrlBottomSheet();
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2, color: CColor.brightGray),
                                        borderRadius: const BorderRadius.all(Radius.circular(16))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Center(
                                            child: SvgPicture.asset(
                                              CIconPath.url,
                                              width: 40,
                                            ),
                                          ),
                                          Text(
                                            '직접입력',
                                            style: CTextStyle.eHeader16,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showGalleryBottomSheet();
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2, color: CColor.brightGray),
                                        borderRadius: const BorderRadius.all(Radius.circular(16))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Center(
                                            child: SvgPicture.asset(
                                              CIconPath.galery,
                                              width: 40,
                                            ),
                                          ),
                                          Text(
                                            '갤러리 ',
                                            style: CTextStyle.eHeader16,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: controller.pollItems.isEmpty ? emptyHeight : 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: const Color(0xffe0e0e0)),
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                              ),
                              height: widgetHeight2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      '피드에 내가 만든 투표가 노출 됩니다.\n누구나 투표 할 수 있지만, 회원만 댓글을 작성 할 수 있습니다.',
                                      style: CTextStyle.light12.copyWith(color: CColor.deepBlueBlack),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 14),
                                      child: Container(
                                        width: Get.width - 80,
                                        height: 46,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                                          border: Border.all(width: 1, color: CColor.brightGray),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller.tapPollPublicL();
                                                },
                                                child: Container(
                                                  width: (Get.width - 110) / 2,
                                                  height: 34,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                                    color: controller.isPollPublic ? CColor.brightGray : Colors.transparent,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(CIconPath.lockOpen,
                                                          width: 18, color: controller.isPollPublic ? Colors.black : CColor.gray),
                                                      const SizedBox(width: 6),
                                                      Text(
                                                        '공개 투표',
                                                        style: CTextStyle.light16.copyWith(
                                                            color: controller.isPollPublic ? Colors.black : CColor.gray),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.tapPollPublicR();
                                                },
                                                child: Container(
                                                  width: (Get.width - 110) / 2,
                                                  height: 34,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                                    color: controller.isPollPublic ? Colors.transparent : CColor.brightGray,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(CIconPath.lockOpen,
                                                          width: 18, color: controller.isPollPublic ? CColor.gray : Colors.black),
                                                      const SizedBox(width: 6),
                                                      Text(
                                                        '지인 투표',
                                                        style: CTextStyle.light16.copyWith(
                                                            color: controller.isPollPublic ? CColor.gray : Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                            child: GestureDetector(
                              onTap: controller.pollItems.isNotEmpty
                                  ? () {
                                controller.createPoll();
                              }
                                  : null,
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                    color: controller.pollItems.isNotEmpty ? CColor.mainPurple : CColor.gray),
                                child: Center(
                                  child: Text(
                                    '투표 만들기',
                                    style: CTextStyle.eHeader20,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                ),
                if(indicatorController.isLoading)
                  myIndicator()
              ],
            );
          });
  }
}

void showCartBottomSheet() {
  homeController.changeMode('pollCreate');
  final pollCreateController = Get.put(PollCreateController());
  Get.bottomSheet(isScrollControlled: true, GetBuilder<CartController>(builder: (cartController) {
    return Container(
      height: Get.height - 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 60,
                height: 6,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '카트',
                  style: CTextStyle.light20,
                ),
              ),
              cartController.filteredCartList.isNotEmpty
                  ? SizedBox(
                width: Get.width,
                height: Get.height - 50 - 60 - 16,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartController.filteredCartList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1 / 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return cartItem(cartController.filteredCartList[index]);
                      }),
                ),
              )
                  : SizedBox(
                  width: Get.width,
                  height: Get.height - 50 - 60 - 16,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '카트에 담긴 아이템이 없어요.\n쇼핑몰의 관심상품을 카트에 담아 보세요.',
                        style: CTextStyle.light20,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        child: Text('카트에 담으러 가기',
                            style: CTextStyle.light16.copyWith(
                              decoration: TextDecoration.underline,
                            )),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        '관심 상품을 카트에 어떻게 담나요?',
                        style: CTextStyle.light18.copyWith(color: CColor.redCaution),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              ImagePath.guide1,
                              width: (Get.width - 70) / 2,
                            ),
                            Image.asset(
                              ImagePath.guide2,
                              width: (Get.width - 70) / 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ))
            ],
          ),
          if (cartController.selectedCartIdList.isNotEmpty)
            Positioned(
              bottom: 20,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                child: GestureDetector(
                  onTap: () async {
                    await cartController.insertPollItem();
                    await pollCreateController.setPollItems(cartController.selectedCartItemList);
                    cartController.cartItemSelectListClear();
                    Get.back();
                  },
                  child: Container(
                    width: Get.width - 80,
                    height: 46,
                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(16)), color: CColor.mainPurple),
                    child: Center(
                      child: Text(
                        '선택 완료',
                        style: CTextStyle.eHeader20,
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  })).whenComplete(() {
    //cartController.cartItemSelectListClear();
    homeController.changeMode('main');
  });
}

Future<void> showGalleryBottomSheet() async {
  final pollCreateController = Get.put(PollCreateController());
  var status1 = await Permission.storage.request();
  var status2 = await Permission.videos.request();
  var status3 = await Permission.photos.request();
  if (status1.isGranted && status2.isGranted && status3.isGranted) {} else {
    Map<Permission, PermissionStatus> statuses = await [Permission.videos, Permission.storage, Permission.photos].request();
  }

  List<AssetPathEntity> album = await PhotoManager.getAssetPathList(type: RequestType.image);
  pollCreateController.images = await album[0].getAssetListPaged(page: 0, size: 100);

  Get.bottomSheet(isScrollControlled: true, GetBuilder<PollCreateController>(builder: (pollCreateController) {
    return

      GetBuilder<PollCreateController>(
          builder: (controller) {
            return  Container(
              height: Get.height - 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                color: Colors.white,
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 60,
                        height: 6,
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          '갤러리',
                          style: CTextStyle.light20,
                        ),
                      ),
                      SizedBox(
                        width: Get.width,
                        height: Get.height - 50 - 60 - 16,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GridView.builder(
                            controller: pollCreateController.galleryScrollController,
                            itemCount: pollCreateController.images.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1 / 1,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  pollCreateController.selectImage(index);
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Positioned.fill(
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                                          child: AssetEntityImage(
                                            pollCreateController.images[index],
                                            isOriginal: false,
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Positioned(
                                        bottom: 4,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                                              border: Border.all(
                                                  color: pollCreateController.isSelected.contains(index) ? CColor.mainGreen : Colors.white, width: 2),
                                              color: pollCreateController.isSelected.contains(index)
                                                  ? Colors.white.withOpacity(0.8)
                                                  : Colors.black.withOpacity(0.3)),
                                          child: Visibility(
                                              visible: pollCreateController.isSelected.contains(index),
                                              child: Center(child: SvgPicture.asset(CIconPath.checkItem))),
                                        ))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  if (pollCreateController.isSelected.isNotEmpty)
                    Positioned(
                      bottom: 20,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                        child: GestureDetector(
                          onTap: () async {
                            indicatorController.nowLoading();
                            pollCreateController.update();
                            ImageUploadRepository imageUploadRepository = ImageUploadRepository();
                            List<File> fileList = [];
                            for (int i = 0; i < pollCreateController.isSelected.length; i++) {
                              File? fileImage = await pollCreateController.images[pollCreateController.isSelected[i]].file;

                              fileList.add(fileImage!);
                            }
                            try {
                              List<String> fileUrlList = await imageUploadRepository.imageListUpload(fileList);
                              List<UrlData> tempUrlDataList = [];
                              for (int i = 0; i < fileUrlList.length; i++) {
                                UrlData tempData =
                                UrlData(localId: "PollItem ${DateTime.now()}",
                                    title: "poll item",
                                    image: fileUrlList[i],
                                    url: "empty",
                                    group: []);
                                tempUrlDataList.add(tempData);
                              }
                              CartRepository cartRepository = CartRepository();
                              await cartRepository.addPollItem(tempUrlDataList);
                              List<UrlData> imagePollItems = [];
                              for (int i = 0; i < tempUrlDataList.length; i++) {
                                for (int j = 0; j < cartController.nowCartList.length; j++) {
                                  if (cartController.nowCartList[j].localId == tempUrlDataList[i].localId) {
                                    imagePollItems.add(cartController.nowCartList[j]);
                                  }
                                }
                              }
                              await pollCreateController.setPollItems(imagePollItems);
                              Get.back();
                            } catch (e) {
                              safePrint(e);
                            }
                          },
                          child: Container(
                            width: Get.width - 80,
                            height: 46,
                            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(16)), color: CColor.mainPurple),
                            child: Center(
                              child: Text(
                                '선택 완료',
                                style: CTextStyle.eHeader20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  if(indicatorController.isLoading)
                    myIndicator()
                ],
              ),
            );
          });






  })).whenComplete(() {
    pollCreateController.selectImageClose();
  });
}

Future<void> showUrlBottomSheet() async {
  final pollCreateController = Get.put(PollCreateController());
  // var status1 = await Permission.storage.request();
  // var status2 = await Permission.videos.request();
  // var status3 = await Permission.photos.request();
  // if (status1.isGranted && status2.isGranted && status3.isGranted) {} else {
  //   Map<Permission, PermissionStatus> statuses = await [Permission.videos, Permission.storage, Permission.photos].request();
  // }

  List<AssetPathEntity> album = await PhotoManager.getAssetPathList(type: RequestType.image);
  pollCreateController.images = await album[0].getAssetListPaged(page: 0, size: 24);

  Get.bottomSheet(isScrollControlled: true, GetBuilder<PollCreateController>(builder: (pollCreateController) {
    return Stack(alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: Get.height - 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Stack(alignment: Alignment.topCenter,
                    children: [
                      Positioned(top: 10,
                        child: Container(
                          width: 60,
                          height: 6,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.black),
                        ),
                      ),

                      Positioned(
                        top: 26,
                        child: Text(
                          '직접입력',
                          style: CTextStyle.light20.copyWith(height: 2),
                        ),
                      ),

                      Positioned(top: 86, left: 0,
                        child: Row(
                          children: [
                            const SizedBox(width: 20,),
                            Text('주소 입력으로 아이템 추가', style: CTextStyle.light26.copyWith(height: 26 / 24),),
                          ],
                        ),
                      ),


                      Positioned(
                        top: 203, left: 20,
                        child: SizedBox(height: Get.height - 253, width: Get.width - 40,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: pollCreateController.urlPollItem.length,
                              itemBuilder: (BuildContext ctx, int index) {
                                return Stack(
                                  children: [
                                    Container(width: Get.width - 40, height: 120,
                                      color: Colors.transparent,
                                    ),

                                    Positioned(
                                      top: 0,
                                      child: Container(width: Get.width - 40, height: 1,
                                        color: CColor.brightGray,
                                      ),
                                    ),

                                    Positioned(
                                        top: 20, left: 10,
                                        child: SizedBox(width: 80, height: 80,
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                                            child: CachedNetworkImage(
                                              imageUrl: pollCreateController.urlPollItem[index].image ?? '',
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Container(
                                                    color: CColor.gray.withOpacity(0.3),
                                                  ),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                          ),
                                        )),

                                    Positioned(
                                        top: 20, left: 100,
                                        child: SizedBox(width: 80, height: 14,

                                          child: Row(
                                            children: [
                                              SizedBox(width: 14, height: 14,
                                                child: ClipRRect(
                                                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                    child: Image.asset(
                                                      faviconGet(pollCreateController.urlPollItem[index].url) ?? ImagePath.logo,
                                                      width: 14,
                                                      fit: BoxFit.fitWidth,
                                                    )),
                                              ),
                                              const SizedBox(width: 4,),
                                              Text(mallNameGet(pollCreateController.urlPollItem[index].url) ?? '',
                                                style: CTextStyle.bold12.copyWith(color: Colors.black, height: 14 / 12),)


                                            ],
                                          ),

                                        )),
                                    Positioned(
                                        top: 40, left: 100,
                                        child: SizedBox(width: Get.width - 170, height: 32,

                                          child: Text(pollCreateController.urlPollItem[index].title ?? '',
                                            style: CTextStyle.bold14.copyWith(height: 16 / 14, color: Colors.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,),

                                        )),
                                    Positioned(
                                        top: 20, right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            pollCreateController.urlPollItem.removeAt(index);
                                            pollCreateController.update();
                                          },
                                          child: SizedBox(width: 24, height: 24,

                                            child: Center(child: SvgPicture.asset(CIconPath.delete, width: 24, color: Colors.black,)),

                                          ),
                                        )),
                                  ],
                                );
                              }),
                        ),
                      ),

                      Positioned(
                        top: 125,
                        child: Stack(alignment: Alignment.topCenter,
                          children: [
                            SizedBox(width: Get.width - 40, height: 148,),
                            if(pollCreateController.searchedData != null)
                              Container(width: Get.width - 40, height: 148,

                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    color: Color(0xffEDF2FE)
                                ),
                                child: Stack(alignment: Alignment.bottomCenter,

                                  children: [


                                    if(pollCreateController.searchedData?.title != pollCreateController.searchedData?.url)
                                      Positioned(
                                        bottom: 14, left: 20,
                                        child: SizedBox(
                                            width: Get.width - 140,
                                            height: 46,

                                            child: Text(
                                              pollCreateController.searchedData?.title ?? '', style: CTextStyle.bold14.copyWith(color: Colors.black),
                                              maxLines: 2,)),
                                      ),

                                    Positioned(
                                      bottom: 20, right: 20,
                                      child: GestureDetector(
                                        onTap: () async {
                                          indicatorController.nowLoading();
                                          pollCreateController.update();

                                          safePrint(pollCreateController.searchedData?.title ?? "");
                                          String? itemsId = await pollCreateController.registerUrlItem();


                                          for (int i = 0; i < cartController.nowCartList.length; i++) {
                                            if (cartController.nowCartList[i].localId == itemsId) {
                                              pollCreateController.urlPollItem.add(cartController.nowCartList[i]);
                                              safePrint(cartController.nowCartList[i]);
                                              pollCreateController.update();
                                            }
                                          }

                                          pollCreateController.urlPollItemController.clear();
                                          pollCreateController.searchedData = null;
                                          pollCreateController.update();

                                        },
                                        child: AnimatedContainer(duration: const Duration(milliseconds: 200),
                                          width: pollCreateController.searchedData?.title != pollCreateController.searchedData?.url ? 40 : Get.width -
                                              40 - 30,
                                          height: 40,

                                          decoration: BoxDecoration(
                                            color: CColor.lavender,
                                            borderRadius:
                                            pollCreateController.searchedData?.title != pollCreateController.searchedData?.url ?
                                            const BorderRadius.all(Radius.circular(6)) :
                                            const BorderRadius.all(Radius.circular(630)),
                                          ),

                                          child: Center(
                                            child: SvgPicture.asset(CIconPath.plus, width: 18,),
                                          ),

                                        ),
                                      ),
                                    )


                                  ],),

                              ),
                            SizedBox(
                              width: Get.width,
                              child: Center(
                                child: Container(


                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                    border: Border.all(width: 1, color: CColor.subLightGray),
                                    color: Colors.white,
                                  ),


                                  width: Get.width - 40,
                                  height: 58,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Center(
                                      child: TextField(
                                        onChanged: (text) {
                                          pollCreateController.textLength = text.length;

                                          ///타이핑이 들어오면 트루로 바꾸고
                                          pollCreateController.isTypingNow = true;

                                          ///2초를 기다리는데 2초를 기다리고도 true상태라면 서치를 하겠어요
                                          pollCreateController.isTypingEnd(pollCreateController.textLength);

                                          pollCreateController.update();
                                        },
                                        autofocus: true,
                                        controller: pollCreateController.urlPollItemController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 1,
                                        style: CTextStyle.light16.copyWith(decorationThickness: 0),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: 'URL을 입력하세요.',
                                          hintStyle: CTextStyle.light16.copyWith(color: CColor.gray),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      )


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: GestureDetector(
            onTap: () async {
              await pollCreateController.setPollItems(pollCreateController.urlPollItem);
              Get.back();
            },
            child: Container(
              width: Get.width - 80,
              height: 46,
              decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: pollCreateController.urlPollItem.isEmpty ? const Color(0xffC1A7FB) : CColor.mainPurple),
              child: Center(
                child: Text(
                  '입력 완료',
                  style: CTextStyle.eHeader20,
                ),
              ),
            ),
          ),
        ),

        if(indicatorController.isLoading)
        myIndicator()
      ],
    );
  })).whenComplete(() {
    pollCreateController.selectImageClose();
  });
}

Future<void> showAddImageBottomSheet(int index, int count) async {
  final pollCreateController = Get.put(PollCreateController());
  var status1 = await Permission.storage.request();
  var status2 = await Permission.videos.request();
  var status3 = await Permission.photos.request();
  if (status1.isGranted && status2.isGranted && status3.isGranted) {} else {
    Map<Permission, PermissionStatus> statuses = await [Permission.videos, Permission.storage, Permission.photos].request();
  }

  List<AssetPathEntity> album = await PhotoManager.getAssetPathList(type: RequestType.image);
  pollCreateController.images = await album[0].getAssetListPaged(page: 0, size: 80);

  Get.bottomSheet(isScrollControlled: true, GetBuilder<PollCreateController>(builder: (pollCreateController) {
    return Container(
      height: Get.height - 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 60,
                height: 6,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '이미지 추가',
                  style: CTextStyle.light20,
                ),
              ),
              SizedBox(
                width: Get.width,
                height: Get.height - 50 - 60 - 16,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    controller: pollCreateController.galleryScrollController,
                    itemCount: pollCreateController.images.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          pollCreateController.selectItemImage(index, count);
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  child: AssetEntityImage(
                                    pollCreateController.images[index],
                                    isOriginal: false,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Positioned(
                                bottom: 4,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                                      border: Border.all(
                                          color: pollCreateController.isSelected.contains(index) ? CColor.mainGreen : Colors.white, width: 2),
                                      color: pollCreateController.isSelected.contains(index)
                                          ? Colors.white.withOpacity(0.8)
                                          : Colors.black.withOpacity(0.3)),
                                  child: Visibility(
                                      visible: pollCreateController.isSelected.contains(index),
                                      child: Center(child: SvgPicture.asset(CIconPath.checkItem))),
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          if (pollCreateController.isSelected.isNotEmpty)
            Positioned(
              bottom: 20,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                child: GestureDetector(
                  onTap: () async {
                    ///이미지를 서버에 추가하고 그 이미지를 바탕으로 cartData를 엄데이트 해야합니다.
                    ImageUploadRepository imageUploadRepository = ImageUploadRepository();
                    List<File> fileList = [];
                    for (int i = 0; i < pollCreateController.isSelected.length; i++) {
                      File? fileImage = await pollCreateController.images[pollCreateController.isSelected[i]].file;
                      fileList.add(fileImage!);
                    }

                    safePrint('파일 리스트 길이');
                    safePrint(fileList.length);
                    safePrint(fileList[0].path);

                    try {
                      List<String> fileUrlList = await imageUploadRepository.imageListUpload(fileList);

                      List<String> urlList = [];

                      for (int i = 0; i < fileUrlList.length; i++) {
                        safePrint(i);
                        urlList.add('$index${fileUrlList[i]}');
                      }

                      pollCreateController.setItemImages(urlList);

                      ///여기에서 이미지를 아이템 코멘트에 넣을꺼여 그리고 그거를 거시기로 사용할꺼여 이미지의 맨 앞에는 인덱스를 붙일꺼야

                      pollCreateController.setEachItemImage();
                      Get.back();
                    } catch (e) {
                      safePrint(e);
                    }
                  },
                  child: Container(
                    width: Get.width - 80,
                    height: 46,
                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(16)), color: CColor.mainPurple),
                    child: Center(
                      child: Text(
                        '이미지 추가하기',
                        style: CTextStyle.eHeader20,
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  })).whenComplete(() {
    pollCreateController.selectImageClose();
  });
}
