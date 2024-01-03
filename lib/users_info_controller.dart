import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/models/api_model/users/users_info.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

class UserInfoController extends GetxController{

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    deviceToken = await setDeviceToken();
    super.onInit();
  }

  String deviceToken = '';
  Future<String> setDeviceToken() async {
    String? deviceToken;
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceToken = iosInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      const androidId = AndroidId();
      deviceToken = await androidId.getId();
    }
    return deviceToken??'';
  }


  UsersInfo? usersInfo ;
  String userAgent = 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)';

  setAgent(String? agent){
    if(agent!=null){
      userAgent = agent;
    }
  }

  setUsersInfo(UsersInfo usersInfoData){
    usersInfo =  usersInfoData;
    update();

  }

  String? token;
  int? type;
  setTempSocialInfo(String socialToken, int loginType){
    token = socialToken;
    type = loginType;
  }

}