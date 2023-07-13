import 'dart:async';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/cart_screen/cart_controller.dart';
import 'package:shovving_pre/util/local_repository/local_repository.dart';
import 'package:shovving_pre/util/safe_print.dart';

import '../url_previewer/any_link_preview.dart';
import '../url_previewer/src/helpers/link_preview.dart';


class SharingRepository{

  LocalRepository localRepository = LocalRepository();
  late StreamSubscription intentDataStreamSubscription;

  void getSharedUrl(List<UrlData> localList){
    safePrint('@@@=>get shared url');


    intentDataStreamSubscription = FlutterSharingIntent.instance.getMediaStream()
        .listen((List<SharedFile> value) async {
          List<UrlData> nowCartList = Get.find<CartController>().nowCartList;
      if(value.isNotEmpty){
        safePrint(value);
        safePrint('url 정보를 확인하는 순간 아래');

        int startIndex = value[0].value!.indexOf('https://');
        String result = value[0].value!.substring(startIndex);

        safePrint('url: $result');
        if(value[0].value!=null){
          BaseMetaInfo info = await getUrlData(result);
          safePrint('타이틀 : ${info.title}');
          safePrint('이미지 주소: ${info.image}');

          String imageAvailable = info.image?.substring(0,5)??"https://finutss.s3.ap-northeast-2.amazonaws.com/profile/sample.jpg";
          safePrint('이미지 검증');
          safePrint(imageAvailable);
          nowCartList.add(UrlData(
        id: 'UrlData temp ${DateTime.now()}',
        title: info!.title,
        image: imageAvailable=="https"?info.image:"https://finutss.s3.ap-northeast-2.amazonaws.com/profile/sample.jpg",
        url: value[0].value!,
        group: []));
          localRepository.updateMyCartList(nowCartList);
          Get.find<CartController>().filteredCartList =[];
          Get.find<CartController>().filteredCartList = nowCartList;
        }
      }



          FlutterSharingIntent.instance.reset();
    }, onError: (err) {
      safePrint("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    FlutterSharingIntent.instance.getInitialSharing().then((List<SharedFile> value) async {
      if(value.isNotEmpty){
        List<UrlData> nowCartList = Get.find<CartController>().nowCartList;
        if(value.isNotEmpty){
          safePrint('url 정보를 확인하는 순간 아래');

          int startIndex = value[0].value!.indexOf('https://');
          String result = value[0].value!.substring(startIndex);

          safePrint('url: $result');
          if(value[0].value!=null){
            BaseMetaInfo info = await getUrlData(result);
            safePrint('타이틀 : ${info.title}');
            safePrint('이미지 주소: ${info.image}');

            String imageAvailable = info.image?.substring(0,5)??"https://finutss.s3.ap-northeast-2.amazonaws.com/profile/sample.jpg";
            safePrint('이미지 검증');
            safePrint(imageAvailable);

            nowCartList.add(UrlData(
                id: 'UrlData temp ${DateTime.now()}',
                title: info!.title,
                image: imageAvailable=="https"?info.image:"https://finutss.s3.ap-northeast-2.amazonaws.com/profile/sample.jpg",
                url: value[0].value!,
                group: []));
            localRepository.updateMyCartList(nowCartList);
            Get.find<CartController>().filteredCartList =[];
            Get.find<CartController>().filteredCartList = nowCartList;
          }
        }
      }
      FlutterSharingIntent.instance.reset();
    });
  }


  Future<BaseMetaInfo> getUrlData(String url) async {
    safePrint('함수가 시작됩니다.');
    safePrint(url);
    BaseMetaInfo? info;
    while(true){
      info = await AnyLinkPreview.getMetadataInfo(
        url,
        cache: const Duration(days: 1),
        headers: {},
      );
      if(info?.title!=null||info?.image!=null||info?.url!=null||info!=null){
        break;
      }
    }

    return info!;

  }





}