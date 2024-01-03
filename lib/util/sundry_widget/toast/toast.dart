import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';


///빌드 컨텍스트가 없는 기본 토스트
  void showBasicToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
    );
  }







showDefaultMiddleToast(String msg) {
  FToast fToast = FToast();
  fToast.init(navigatorKey.currentContext!);
  Widget toast = Container(
    width: Get.width-40, height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.black.withOpacity(0.8),
    ),
    child:  Center(child: Text(msg,style: CTextStyle.bold16.copyWith(color: Colors.white),)),
  );

  fToast.showToast(
    gravity: ToastGravity.CENTER,
    child: toast,
    toastDuration: const Duration(milliseconds: 1500),
  );
}

showMiddleToastWithImage(String msg, String image) {
  FToast fToast = FToast();
  fToast.init(navigatorKey.currentContext!);
  Widget toast = Container(
    width: Get.width-40, height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.black.withOpacity(0.8),
    ),
    child:  Row(
      children: [
        const SizedBox(width: 9,),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          child: SizedBox(width: 40, height: 40,
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: CColor.gray.withOpacity(0.3),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(width: 10,),
        SizedBox(
            width: Get.width-40-70,
            child: Center(child: Text(msg,style: CTextStyle.bold16.copyWith(color: Colors.white),))),
      ],
    ),
  );

  fToast.showToast(
    gravity: ToastGravity.CENTER,
    child: toast,
    toastDuration: const Duration(milliseconds: 1500),
  );
}
