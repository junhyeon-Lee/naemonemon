import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/sharing_function/favicon_get.dart';
import 'package:shovving_pre/util/sundry_widget/web_view/web_view_screen.dart';
import 'package:shovving_pre/util/sundry_widget/web_view/webview_getx_controller.dart';

import '../../../../main.dart';

Widget cartItem(UrlData data) {
  RiveAnimationController riveController = SimpleAnimation('idle');


    return GestureDetector(
      onTap: () {
        if (homeController.modeSate == 'delete' || homeController.modeSate == 'pollCreate') {
          cartController.cartItemSelect(data.localId);
        } else {
          cartItemBottomSheet(data);
        }
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
              child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: CachedNetworkImage(
              imageUrl: data.image!,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: CColor.gray.withOpacity(0.3),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          )),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: const Color(0xffF7F6F9)),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
          ),
          if (homeController.modeSate == 'delete' || homeController.modeSate == 'pollCreate')
            Positioned(
                bottom: 4,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      border: Border.all(color: cartController.selectedCartIdList.contains(data.localId) ? CColor.mainGreen : Colors.white, width: 2),
                      color:
                          cartController.selectedCartIdList.contains(data.localId) ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.3)),
                  child: Visibility(
                      visible: cartController.selectedCartIdList.contains(data.localId), child: Center(child: SvgPicture.asset(CIconPath.checkItem))),
                ))
        ],
      ),
    );

}

Widget cartFirstItem() {
  if (homeController.modeSate == 'delete') {
    return GestureDetector(
      onTap: () {
        ///삭제하기 여기서 바로 딜리트가 아니라 그거를 해야하죠 그 팝업
        cartController.showDeleteBottomSheet();
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: CColor.mainYellow,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SvgPicture.asset(
                      CIconPath.delete,
                      width: 50,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 5),
                          child: Text(
                            '삭제하기',
                            style: CTextStyle.bold12.copyWith(color: Colors.black),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
          if (cartController.selectedCartIdList.isEmpty)
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: Colors.white.withOpacity(0.5),
              ),
            )
        ],
      ),
    );
  } else {
    return GestureDetector(
      onTap: () {



        if (webViewGetXController.nowUrl != '') {
          Get.to(WebViewScreen(firstUrl: webViewGetXController.nowUrl));
        } else {
          selectShoppingMall(preUrlList, webViewGetXController.nowUrl);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: CColor.mainPurple,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: (Get.width - 60) / 3 / 110 * 20),
              child: SvgPicture.asset(
                GIconPath.shoppingBag,
                width: (Get.width - 60) / 3 / 110 * 50,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: (Get.width - 60) / 3 / 110 * 10),
              child: Container(
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 5),
                    child: Text(
                      '쇼핑하기',
                      style: CTextStyle.bold12.copyWith(color: Colors.black),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

Widget urlItem() {
    return GestureDetector(
      onTap: () {

        if(homeController.modeSate == 'urlItemMode'){
          homeController.changeMode('main');
        }else{
          homeController.changeMode('urlItemMode');
        }

        safePrint('urlMode');

      },
      child: Container(
        decoration: BoxDecoration(
          color: CColor.grassGreen,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: (Get.width - 60) / 3 / 110 * 20),
              child: Center(
                child: SizedBox( width: (Get.width - 60) / 3 / 110 * 50 ,
                  height: (Get.width - 60) / 3 / 110 * 50,
                  child: const RiveAnimation.asset(
                    RivePath.riveClipbox,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),


            ),
            Padding(
              padding: EdgeInsets.only(bottom: (Get.width - 60) / 3 / 110 * 10),
              child: Container(
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 5),
                    child: Text(
                      '클립담기',
                      style: CTextStyle.bold12.copyWith(color: Colors.black),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
}



Widget cartDefaultItem() {
  return Container(
    decoration: BoxDecoration(
      color: CColor.subLightGray,
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
    ),
  );
}

void cartItemBottomSheet(UrlData data) {
  Get.bottomSheet(
    //isScrollControlled: true,
    backgroundColor: Colors.transparent,

    Container(
      width: Get.width,
      height: 306,
      decoration:
          const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)), color: Colors.white),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 6,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.black),
          ),
          const SizedBox(height: 15),
          Text(
            '상세 정보',
            style: CTextStyle.light20,
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: const Color(0xffF7F6F9)),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: CachedNetworkImage(
                      imageUrl: data.image!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: CColor.gray.withOpacity(0.3),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                            child: Image.asset(
                              faviconGet(data.url) ?? ImagePath.logo,
                              width: 22,
                            )),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          mallNameGet(data.url) ?? '',
                          style: CTextStyle.bold22,
                        )
                      ],
                    ),
                    const SizedBox(height: 7),
                    SizedBox(
                      width: Get.width - 60 - 120 - 10,
                      child: Text(
                        data.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CTextStyle.bold18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
                color: Colors.black,
              ),
              width: Get.width,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(WebViewScreen(firstUrl: data!.url));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                          color: Colors.white,
                        ),
                        width: 120,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              CIconPath.seeDetail,
                              width: 32,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '상품 정보',
                              style: CTextStyle.bold14.copyWith(color: CColor.deepBlueBlack),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          CIconPath.down,
                          width: 36,
                        )),
                    GestureDetector(
                      onTap: () {
                        homeController.changeMode('delete');
                        cartController.cartItemSelect(data.localId);
                        Get.back();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                          color: Colors.white,
                        ),
                        width: 120,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              CIconPath.delete,
                              width: 32,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '삭제',
                              style: CTextStyle.bold14.copyWith(color: CColor.deepBlueBlack),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
