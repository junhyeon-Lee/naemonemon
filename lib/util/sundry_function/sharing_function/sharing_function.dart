import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/local_repository/local_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/url_previewer/src/helpers/link_preview.dart';

import '../../../modules/main/home/cart/cart_repository.dart';
import '../url_previewer/any_link_preview.dart';
import 'package:flutter/services.dart' as fp;

class SharingRepository {
  LocalRepository localRepository = LocalRepository();
  late StreamSubscription intentDataStreamSubscription;

  ///외부 공유
  void getSharedUrl(List<UrlData> localList) {
    safePrint('@@@=>get shared url');

    intentDataStreamSubscription = FlutterSharingIntent.instance.getMediaStream().listen((List<SharedFile> value) async {
      List<UrlData> nowCartList = cartController.nowCartList;
      if (value.isNotEmpty) {
        int startIndex = value[0].value!.indexOf('https://');
        String result = value[0].value!.substring(startIndex);
        if (value[0].value != null) {
          BaseMetaInfo? info = await getUrlData(result);

          UrlData? tempData = verificationThumbnailImage(info, 'UrlData temp ${DateTime.now()}', result);

          nowCartList.add(tempData);
          localRepository.updateMyCartList(nowCartList);
          cartController.filteredCartList = [];
          cartController.filteredCartList = nowCartList;

          CartRepository cartRepository = CartRepository();
          cartRepository.addNewCart(tempData);
        }
      }

      FlutterSharingIntent.instance.reset();
    }, onError: (err) {
      safePrint("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    FlutterSharingIntent.instance.getInitialSharing().then((List<SharedFile> value) async {
      if (value.isNotEmpty) {
        List<UrlData> nowCartList = cartController.nowCartList;
        if (value.isNotEmpty) {
          int startIndex = value[0].value!.indexOf('https://');
          String result = value[0].value!.substring(startIndex);
          if (value[0].value != null) {
            BaseMetaInfo? info = await getUrlData(result);
            String presetImage = ImagePath.presetIcon[Random().nextInt(10)];
            UrlData? tempData;
            if (info == null) {
              tempData = UrlData(localId: 'UrlData temp ${DateTime.now()}', title: result, image: presetImage, url: result, group: []);
            } else {
              String? image = info.image ?? presetImage;
              String imageAvailable = image.substring(0, 4);
              String imageBackAvailable = image.substring(image.length - 3);
              if (imageAvailable == "http") {
                if (imageBackAvailable == 'jpg' ||
                    imageBackAvailable == 'peg' ||
                    imageBackAvailable == 'png' ||
                    image.contains('jpg?type') ||
                    image.contains('jpeg?type') ||
                    image.contains('png?type')) {
                  image = info.image;
                } else {
                  image = presetImage;
                }
              } else {
                image = presetImage;
              }
              tempData = UrlData(localId: 'UrlData temp ${DateTime.now()}', title: info!.title, image: image, url: result, group: []);
            }

            nowCartList.add(tempData);
            localRepository.updateMyCartList(nowCartList);
            cartController.filteredCartList = [];
            cartController.filteredCartList = nowCartList.reversed.toList();

            CartRepository cartRepository = CartRepository();
            cartRepository.addNewCart(tempData);
          }
        }
      }
      FlutterSharingIntent.instance.reset();
    });
  }

  ///클립보드 공유
  Future<void> clipboardShare() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    String? str = data?.text;
    homeController.clipBoardUrl = str??'';
    if (str != null && str?.substring(0, 8) == 'https://') {
      ///지금 이 url이 최근 5개의 항목과 겹치는지를 확인
      LocalRepository localRepository = LocalRepository();
      List<String> usedUrlList = await localRepository.getUsedUrlList();

      bool isDuplication = true;
      if(usedUrlList.contains(str)){
        isDuplication = true;
      }else{
        isDuplication = false;
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isDuplication==false) {
          homeController.isClipBoardUrl = true;
          homeController.update();
        }
      })
      
      
      ;
    }
  }

  ///URL 직접입력
  Future<UrlData> urlPollItem(String str) async {
    String localId = 'PollItem ${DateTime.now()}';

    safePrint('링크 직접 추가');
    BaseMetaInfo? info = await getUrlData(str);
    UrlData? tempData = verificationThumbnailImage(info, localId, str);
    safePrint('잘 처리');

    // CartRepository cartRepository = CartRepository();
    // await cartRepository.addPollItem([tempData]);
    return tempData;
  }

  Future<UrlData> registerUrlPollItem(UrlData data) async {
    String localId = 'PollItem ${DateTime.now()}';


    CartRepository cartRepository = CartRepository();
    await cartRepository.addPollItem([data]);
    return data;
  }

  ///웹뷰에서 공유하기
  webViewShare() async {
    LocalRepository localRepository = LocalRepository();
    List<UrlData> nowCartList = cartController.nowCartList;
    int startIndex = webViewGetXController.nowUrl.indexOf('http');
    String result = webViewGetXController.nowUrl.substring(startIndex);

    BaseMetaInfo? info;
    info = await getUrlData(result);

    UrlData? tempData = verificationThumbnailImage(info, 'UrlData temp ${DateTime.now()}', result);

    nowCartList.add(tempData);
    CartRepository cartRepository = CartRepository();
    cartRepository.addNewCart(tempData);
    localRepository.updateMyCartList(nowCartList);
    cartController.filterNowCartList('all');

    Fluttertoast.showToast(msg: '저장되었습니다.', toastLength: Toast.LENGTH_SHORT);
  }

}

///데이터 가져오기
Future<BaseMetaInfo?>? getUrlData(String url) async {
  BaseMetaInfo? info;
  safePrint('데이터 가져오기');

  info = await AnyLinkPreview.getMetadataInfo(
    url,
    cache: const Duration(days: 1),
  );
  return info;
}

///썸네일 이미지 검증 후 대체 이미지 적용
UrlData verificationThumbnailImage(BaseMetaInfo? info, String localId, String str) {
  String presetImage = ImagePath.presetIcon[Random().nextInt(10)];
  UrlData tempData;

  if (info == null) {
    tempData = UrlData(localId: localId, title: str, image: presetImage, url: str, group: []);
    return tempData;
  } else {
    String? image = info.image ?? presetImage;
    String imageAvailable = image.substring(0, 4);
    String imageBackAvailable = image.substring(image.length - 3);

    if (imageAvailable == "http") {
      if (imageBackAvailable == 'jpg' ||
          imageBackAvailable == 'peg' ||
          imageBackAvailable == 'png' ||
          image.contains('jpg?type') ||
          image.contains('jpeg?type') ||
          image.contains('png?type') ||
          image.contains('.png?') ||
          image.contains('.jpg?') ||
          image.contains('.jpeg?')) {
        image = info.image;
      } else {
        safePrint('사용가능한 이미지를 가져오지 못했심더');
        safePrint(image);
        image = presetImage;
      }
    } else {
      image = presetImage;
    }

    tempData = UrlData(localId: localId, title: info!.title, image: image, url: str, group: []);
  }

  return tempData;
}
