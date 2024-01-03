import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/cart/cart_repository.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_screen.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/ui_helper/common_widget/common_appbar.dart';
import 'package:shovving_pre/util/local_repository/local_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/sharing_function/sharing_function.dart';
import 'package:shovving_pre/util/sundry_function/url_previewer/src/parser/base.dart';
import 'package:shovving_pre/util/sundry_widget/indicator/indicator.dart';
import 'package:shovving_pre/util/sundry_widget/toast/toast.dart';
import 'package:shovving_pre/util/sundry_widget/web_view/web_view_screen.dart';
import 'cart/cart_screen.dart';
import 'poll/feed_screen/feed_screen.dart';
import 'poll/poll_create_screen/poll_create_screen.dart';

bool wantCloseApp = false;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return GetBuilder<HomeController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            if (wantCloseApp) {
              Fluttertoast.cancel();
              return Future(() => true);
            } else {
              if (homeController.modeSate == 'webview') {
                homeController.changeMode('main');
                return Future(() => false);
              } else {
                wantCloseApp = true;
                Fluttertoast.showToast(msg: '한 번 더 뒤로 가기를 하시면 종료됩니다', toastLength: Toast.LENGTH_SHORT);
                Future.delayed(const Duration(seconds: 2), () {
                  wantCloseApp = false;
                });
                return Future(() => false);
              }
            }
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(68),
                  child: AnimatedCrossFade(
                    firstChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HomeAppbar(),
                      ],
                    ),
                    secondChild: const SizedBox.shrink(),
                    crossFadeState: homeController.exposureAppBar ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 300),
                  ),
                ),
                body: Stack(
                  children: [
                    SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: homeController.pageController,
                        children: [
                          cartScreen(height),
                          const FeedScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 30,
                child: Container(
                  width: Get.width - 40,
                  height: 60,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(36),
                      ),
                      color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            homeController.moveLeft();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: (Get.width - 90) / 2 - 35,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(36)),
                                  color: homeController.isScreenPosition ? Colors.white : CColor.deepBlueBlack),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      GIconPath.shoppingBag,
                                      width: 32,
                                      color: homeController.isScreenPosition ? Colors.black : Colors.white,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '카트',
                                      style: CTextStyle.bold14.copyWith(
                                          decoration: TextDecoration.none, color: homeController.isScreenPosition ? Colors.black : Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(PollCreateScreen(), transition: Transition.downToUp);
                          // //Get.to(const PollDetailScreen(), transition: Transition.downToUp);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(100)),
                                border: Border.all(width: 4, color: Colors.white),
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                CIconPath.plus,
                                width: 20,
                              )),
                            ),
                            if (feedController.isFeedLoading)
                              SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: CircularProgressIndicator(
                                    color: CColor.lavender,
                                  ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            homeController.changeMode('main');
                            cartController.cartItemSelectListClear();
                            homeController.moveRight();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: (Get.width - 90) / 2 - 35,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(36)),
                                  color: homeController.isScreenPosition ? CColor.deepBlueBlack : Colors.white),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(GIconPath.feed, width: 32, color: homeController.isScreenPosition ? Colors.white : Colors.black),
                                    const SizedBox(width: 10),
                                    Text(
                                      '피드',
                                      style: CTextStyle.bold14.copyWith(
                                          decoration: TextDecoration.none, color: homeController.isScreenPosition ? Colors.white : Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // if (webViewGetXController.nowUrl != '')
              //   Positioned(
              //     bottom: 0,
              //     left: 0,
              //     child: AnimatedOpacity(
              //         opacity: controller.modeSate == 'webview' ? 1 : 0,
              //         duration: const Duration(milliseconds: 500),
              //         child: SizedBox(
              //           width: Get.width,
              //           height: Get.height,
              //           child: IgnorePointer(
              //               ignoring: homeController.modeSate != 'webview',
              //               child: const WebViewScreen(
              //                 firstUrl: '',
              //               )),
              //         )),
              //   ),


              if(homeController.isClipBoardUrl)
                GestureDetector(
                  onTap: (){
                    homeController.isClipBoardUrl = false;
                    homeController.update();
                  },
                    child: Container(width: Get.width, height: Get.height, color: Colors.black.withOpacity(0.3),)),
              AnimatedPositioned(
                  top: homeController.isClipBoardUrl ? MediaQuery.of(context).viewPadding.top : -126,
                  duration: const Duration(milliseconds: 300),
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: const BorderRadius.all(Radius.circular(16))
                      ),

                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Add clipboard link',
                                  style: CTextStyle.bold14.copyWith(color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 6,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  width: Get.width - 80,
                                  child: RichText(
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    text: TextSpan(text: homeController.clipBoardUrl, style: CTextStyle.bold14.copyWith(color: const Color(0xff1288f5))),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,)
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    LocalRepository localRepository = LocalRepository();
                                    localRepository.setUsedUrlList(homeController.clipBoardUrl);
                                    homeController.isClipBoardUrl = false;
                                    homeController.clipBoardUrl = '';
                                    homeController.update();
                                    Get.back();
                                  },
                                  child: Container(width: Get.width/2, height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16)),
                                      color: CColor.lightGray,
                                    ),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(CIconPath.close,width: 26,),
                                        const SizedBox(width: 6,),
                                        Text('닫기',style: CTextStyle.bold14.copyWith(color: Colors.black),)
                                      ],
                                    ),
                                 )),
                              GestureDetector(
                                  onTap: () async {
                                    LocalRepository localRepository = LocalRepository();
                                    localRepository.setUsedUrlList(homeController.clipBoardUrl);
                                    Get.back();
                                    List<UrlData> nowCartList = cartController.nowCartList;
                                    int startIndex = homeController.clipBoardUrl.indexOf('https://');
                                    String result = homeController.clipBoardUrl.substring(startIndex);
                                    BaseMetaInfo? info = await getUrlData(result);
                                    UrlData? tempData = verificationThumbnailImage(info, 'UrlData temp ${DateTime.now()}', homeController.clipBoardUrl);
                                    nowCartList.add(tempData);
                                    localRepository.updateMyCartList(nowCartList);
                                    cartController.filteredCartList = [];
                                    cartController.filteredCartList = nowCartList.reversed.toList();
                                    Fluttertoast.showToast(msg: '저장 되었습니다.', toastLength: Toast.LENGTH_SHORT);
                                    CartRepository cartRepository = CartRepository();
                                    cartRepository.addNewCart(tempData);
                                    homeController.isClipBoardUrl = false;
                                    homeController.clipBoardUrl = '';
                                    homeController.update();


                                  },
                                  child: Container(width: Get.width/2, height: 48,

                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16)),
                                      color: CColor.lavender,
                                    ),

                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(CIconPath.download,width: 26,),
                                        const SizedBox(width: 6,),
                                        Text('카트 추가',style: CTextStyle.bold14.copyWith(color: Colors.black,),)
                                      ],
                                    ),

                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),

              if (indicatorController.isLoading) myIndicator(),
            ],
          ),
        );
      },
    );
  }
}
