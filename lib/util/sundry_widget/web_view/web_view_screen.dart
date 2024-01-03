import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/pre_url/pre_url.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/sharing_function/sharing_function.dart';
import 'package:url_launcher/url_launcher.dart';

import 'webview_getx_controller.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key, required this.firstUrl}) : super(key: key);

  final String? firstUrl;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WebViewGetXController());
    return WillPopScope(
      onWillPop: () {
        return Future(() async {
          bool isCanGoBack = await controller.webViewController?.canGoBack() ?? false;
          if (isCanGoBack) {
            controller.webViewController?.goBack();
          } else {
            return true;
          }
          return false;
        });
      },
      child: GetBuilder<WebViewGetXController>(
        init: WebViewGetXController(),
        builder: (webViewGetXController) {
          checkCanMove() async {
            webViewGetXController.isCanBack = await controller.webViewController?.canGoBack() ?? false;
            webViewGetXController.isCanFront = await controller.webViewController?.canGoForward() ?? false;
          }

          void openBottomSheet(List<PreUrl> preUrlList, String nowUrl) {
            Get.bottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 330,
                      height: 556,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70,

                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    launchUrl(Uri.parse(nowUrl), mode: LaunchMode.externalApplication);
                                  },
                                  child: CommonContainer(
                                    width: Get.width - 60,
                                    height: 60,
                                    containerColor: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(CIconPath.goWeb),
                                          const SizedBox(
                                            width: 11,
                                          ),
                                          Text(
                                            '웹에서 보기',
                                            style: CTextStyle.bold14.copyWith(color: CColor.deepBlueBlack),
                                          ),
                                          const SizedBox(
                                            width: 11,
                                          ),
                                          SvgPicture.asset(
                                            CIconPath.right,
                                            width: 16,
                                            color: CColor.lightGray,
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
                            height: 430,
                            child: ScrollConfiguration(
                              behavior: const ScrollBehavior().copyWith(overscroll: false),
                              child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: preUrlList.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 16 / 6,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      safePrint('웹뷰 이동하기');
                                      safePrint(preUrlList[index].url);
                                      webViewGetXController.nowUrl = preUrlList[index].url;
                                      webViewGetXController.routePage(preUrlList[index].url);

                                      // update();

                                      // 여기에서
                                      // safePrint('웹뷰 페이지 이동');
                                      // webViewGetXController.webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(preUrlList[index].url)));
                                      Get.back();



                                    },
                                    child: CommonContainer(
                                      width: 160,
                                      height: 60,
                                      containerColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 6),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                                    image: DecorationImage(image: AssetImage(preUrlList[index].image)))),
                                            Text(
                                              preUrlList[index].name,
                                              style: CTextStyle.bold14.copyWith(color: CColor.deepBlueBlack),
                                            ),
                                            SvgPicture.asset(
                                              CIconPath.right,
                                              width: 16,
                                              color: CColor.lightGray,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.01),
                            width: Get.width,
                            height: 56,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: InAppWebView(
                        initialUrlRequest:
                            URLRequest(url: Uri.parse(widget.firstUrl == '' ? webViewGetXController.nowUrl : widget.firstUrl ?? "https://shopping.naver.com/")),
                        onWebViewCreated: (controller) {
                          webViewGetXController.webViewController = controller;
                        },
                        initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(resourceCustomSchemes: ['intent'], userAgent: userInfoController.userAgent)),
                        onLoadResourceCustomScheme: (controller, url) async {
                          await controller.stopLoading();
                          return null;
                        },
                        onLoadStart: (controller, url) async {
                          //로딩 스타트
                          webViewGetXController.loadingStart();
                          webViewGetXController.setNowUrl(url.toString());
                          checkCanMove();
                        },
                        onLoadStop: (controller, url) async {
                          webViewGetXController.loadingFinish();
                          webViewGetXController.setNowUrl(url.toString());
                        },
                        onProgressChanged: (controller, progress) {
                          webViewGetXController.setLoadProgress(progress);
                        },
                      ),
                    ),
                  ),
                 Positioned(
                    bottom: 0,
                    left: webViewGetXController.isDownloadRight?null:0,
                    child: Column(
                      crossAxisAlignment: webViewGetXController.isDownloadRight?CrossAxisAlignment.end:CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                          child: GestureDetector(
                            onTap: () async {
                              SharingRepository sharingRepository = SharingRepository();
                              sharingRepository.webViewShare();
                            },

                            onPanUpdate: (details) {
                              if (details.delta.dx > 0) {
                                webViewGetXController.isDownloadRight = true;
                                webViewGetXController.update();
                              }
                              if (details.delta.dx < 0) {
                                webViewGetXController.isDownloadRight = false;
                                webViewGetXController.update();
                              }
                            },



                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                  border: Border.all(color: CColor.deepBlueBlack.withOpacity(0.4), width: 3),
                                color: Colors.white.withOpacity(0.4),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical:10 ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      CIconPath.download26p,
                                      width: 26,
                                    ),
                                    Text('상품 담기', style: CTextStyle.eHeader8.copyWith(height: 1),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              height: 56,
                              color: Colors.black,
                            ),
                            Opacity(
                              opacity: webViewGetXController.isNowLoading ? 1 : 0,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                width: Get.width * webViewGetXController.loadProgress / 100,
                                height: 56,
                                color: CColor.gray,
                              ),
                            ),
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: SvgPicture.asset(
                                          CIconPath.close,
                                          color: Colors.white,
                                          width: 30,
                                        )),
                                    SizedBox(
                                      width: 170,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                controller.webViewController?.goBack();
                                              },
                                              child: SvgPicture.asset(
                                                CIconPath.left,
                                                color: webViewGetXController.isCanBack ? Colors.white : CColor.deepBlueBlack,
                                                width: 30,
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                controller.webViewController?.reload();
                                              },
                                              child: SvgPicture.asset(
                                                CIconPath.refresh,
                                                color: Colors.white,
                                                width: 30,
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                controller.webViewController?.goForward();
                                              },
                                              child: SvgPicture.asset(
                                                CIconPath.right,
                                                color: webViewGetXController.isCanFront ? Colors.white : CColor.deepBlueBlack,
                                                width: 30,
                                              )),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          openBottomSheet(preUrlList, webViewGetXController.nowUrl);
                                        },
                                        child: SvgPicture.asset(
                                          CIconPath.more,
                                          color: Colors.white,
                                          width: 30,
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void selectShoppingMall(List<PreUrl> preUrlList, String nowUrl) {
  Get.bottomSheet(
    isScrollControlled: true,
    GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        color: Colors.transparent,
        width: Get.width,
        height: 502 + 20 + 116,
        child: Column(
          children: [
            Container(
              width: Get.width - 20,
              height: 116,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: Colors.white.withOpacity(0.8),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          CIconPath.helperText,
                          width: 18,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '안내',
                          style: CTextStyle.bold16.copyWith(color: CColor.redCaution),
                        )
                      ],
                    ),
                    Text(
                      '내모네몬은 통신판매의 당사자가 아닙니다.\n카트에 넣은 모든 아이템의 상품, 거래정보 및 거래 등에 대한 책임은 해당 상품의 통신판매 당사자에게 있습니다.',
                      style: CTextStyle.bold14.copyWith(color: CColor.deepBlueBlack, fontSize: 14.sp),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: Get.width,
              height: 502,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                      color: Colors.white,
                    ),
                    child: Center(
                        child: Text(
                      '쇼핑 시작하기',
                      style: CTextStyle.bold18,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 382,
                      color: Colors.white,
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(overscroll: false),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: preUrlList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 16 / 6,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {

                                Get.to(WebViewScreen(firstUrl: preUrlList[index].url));

                                // Get.back();
                                // webViewGetXController.nowUrl = preUrlList[index].url;
                                // webViewGetXController.routePage(preUrlList[index].url);
                                // homeController.changeMode('webview');


                              },
                              child: CommonContainer(
                                borderColor: CColor.lightGray,
                                width: 160,
                                height: 60,
                                containerColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                                              image: DecorationImage(image: AssetImage(preUrlList[index].image)))),
                                      Text(
                                        preUrlList[index].name,
                                        style: CTextStyle.bold14.copyWith(color: CColor.deepBlueBlack),
                                      ),
                                      SvgPicture.asset(
                                        CIconPath.right,
                                        width: 16,
                                        color: CColor.lightGray,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 60,
                    color: Colors.white,
                    child: Center(
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(CIconPath.close, width: 32))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
