import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/pre_url/pre_url.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewGetXController extends GetxController{
  InAppWebViewController? webViewController;


  String nowUrl = '';
  setNowUrl(String url){
      nowUrl = url;
  }

  bool isNowLoading = false;
  loadingStart() {
    isNowLoading = true;
    update();
  }
  loadingFinish() {
    Future.delayed(const Duration(milliseconds: 300),(){
      isNowLoading = false;
      update();
    });

  }

  int loadProgress = 0;
  setLoadProgress(int progress){
    loadProgress = progress;
    update();
  }

  bool isCanBack = false;
  bool isCanFront = false;

  Future<void> routePage(String url) async {
    nowUrl =url;
   await webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
    //webViewController?.clearCache();
    // WebViewCookieManager cookieManager = WebViewCookieManager();
    // cookieManager.clearCookies();
    update();
    homeController.update();
  }

  bool isDownloadRight = true;



}

List<PreUrl> preUrlList = [
  PreUrl(image: CIconPath.naverSmartStore, url: 'https://shopping.naver.com/', name: '네이버'),
  PreUrl(image: CIconPath.coupang, url: 'https://www.coupang.com', name: '쿠팡'),
  PreUrl(image: CIconPath.sipilst, url: 'https://www.11st.co.kr', name: '11번가'),
  PreUrl(image: CIconPath.gmarket, url: 'https://www.gmarket.co.kr', name: 'G마켓'),
  PreUrl(image: CIconPath.interpark, url: 'https://shop.interpark.com', name: '인터파크'),
  PreUrl(image: CIconPath.tmon, url: 'https://www.tmon.co.kr', name: '티몬'),
  PreUrl(image: CIconPath.auction, url: 'https://www.auction.co.kr', name: '옥션'),
  PreUrl(image: CIconPath.wemakeprice, url: 'https://front.wemakeprice.com', name: '위메프'),
  PreUrl(image: CIconPath.ssg, url: 'https://www.ssg.com', name: 'SSG'),
  PreUrl(image: CIconPath.eMart, url: 'https://emart.ssg.com', name: '이마트몰'),
  //PreUrl(image: CIconPath.homePlus, url: 'https://www.homeplus.co.kr/', name: '홈플러스'),
  //PreUrl(image: CIconPath.kakaoGift, url: 'https://store.kakao.com', name: '카카오'),
  PreUrl(image: CIconPath.lotteOn, url: 'https://www.lotteon.com/', name: '롯데ON'),
  PreUrl(image: CIconPath.hiMart, url: 'https://www.e-himart.co.kr/', name: '하이마트'),
  PreUrl(image: CIconPath.gSShop, url: 'https://www.gsshop.com/', name: 'GS SHOP'),
  PreUrl(image: CIconPath.aladin, url: 'https://www.aladin.co.kr/', name: '알라딘'),
  PreUrl(image: CIconPath.yes24, url: 'https://www.yes24.com/', name: '예스24'),
  PreUrl(image: CIconPath.oliveyoung, url: 'https://www.oliveyoung.co.kr/', name: '올리브영'),
  //PreUrl(image: CIconPath.marketKurly, url: 'https://www.kurly.com/', name: '마켓컬리'),
  PreUrl(image: CIconPath.danawa, url: 'https://www.danawa.com/', name: '다나와'),
  //PreUrl(image: CIconPath.ohou, url: 'https://ohou.se/', name: '오늘의 집'),
  PreUrl(image: CIconPath.musinsa, url: 'https://www.musinsa.com', name: '무신사'),
  PreUrl(image: CIconPath.zigzag, url: 'https://zigzag.kr/', name: '지그재그'),
  //PreUrl(image: CIconPath.ably, url: 'https://m.a-bly.com/', name: '에이블리'),
  PreUrl(image: CIconPath.hmall, url: 'https://www.hmall.com/', name: 'H몰'),

];