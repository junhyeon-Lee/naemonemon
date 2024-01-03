import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shovving_pre/models/api_model/users/users_info.dart';
import 'package:shovving_pre/models/api_model/users/users_login.dart';
import 'package:shovving_pre/modules/sign/init_user_screen.dart';
import 'package:shovving_pre/modules/sign/sign_controller/splash_controller.dart';
import 'package:shovving_pre/modules/sign/splash_screen.dart';
import 'package:shovving_pre/util/dio/api_constants.dart';
import 'package:shovving_pre/util/dio/dio_api.dart';
import 'package:shovving_pre/util/local_repository/local_user_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/profile/inti_profile_controller.dart';

import '../../../main.dart';


class SignRepository {
  static final SignRepository _repository = SignRepository._intrnal();

  factory SignRepository() => _repository;

  SignRepository._intrnal();

  Dio dio = HttpService().to();
  LocalUserRepository localUserRepository = LocalUserRepository();

  Future<UserLogin?> loginNovice(String email, int loginType) async {
    safePrint('@@@=>try novice login');
    //일단 토큰 지우고
    HttpService().deleteAccessToken();

    try {
    } catch (e, s) {
      print(s);
    }
    String deviceToken = (userInfoController.deviceToken+email+loginType.toString()).replaceAll('.', '');

    try {
      final response = await dio.post(APIConstants.usersLogin, data: {
        "loginType": 5,
        "deviceToken": deviceToken,
        "fcmToken" : fcmToken
      }, options: Options(headers: null));

      if (response.statusCode == 201 || response.statusCode == 200) {
        UserLogin loginResponse = UserLogin.fromJson(response.data);
        localUserRepository.setAccessToken(loginResponse.access_token);
        HttpService().setAccessToken(loginResponse.access_token);
        return loginResponse;
      }
    } catch (e) {
      safePrint('error in novie Login : $e');
    }
    return null;
  }

  Future<UsersInfo?> getUsersInfo() async {
    safePrint('@@@=>try get users info');
    try {
      final response = await dio.get(APIConstants.usersInfo);
      if (response.statusCode == 201 || response.statusCode == 200) {
        UsersInfo usersInfo = UsersInfo.fromJson(response.data);
        localUserRepository.setUsersInfo(usersInfo);
        userInfoController.setUsersInfo(usersInfo);


        safePrint('유저 정보 가져오기');
        safePrint(usersInfo.fcmToken);

        if(usersInfo.fcmToken==null||usersInfo.fcmToken!=fcmToken){
          UsersInfo? updatedUserInfo =  await updateFcmToken(fcmToken);

          safePrint('업데이트한 fcm토큰');
          safePrint(updatedUserInfo?.fcmToken);

          return updatedUserInfo;
        }

        return usersInfo;
      }
    } catch (e) {
      safePrint('error in get users info : $e');
    }
    return null;
  }

  Future<UsersInfo?> updateUsersInfo(String nickName, String profileImage) async {
    safePrint('@@@=>try get users info');
    try {
      final response = await dio.patch(APIConstants.usersUpdate, data: {
        "nickName": nickName,
        "profileImage": profileImage,
      });
      if (response.statusCode == 201 || response.statusCode == 200) {
        UsersInfo usersInfo = UsersInfo.fromJson(response.data);
        localUserRepository.setUsersInfo(usersInfo);
        userInfoController.setUsersInfo(usersInfo);
        return usersInfo;
      }
    } catch (e) {
      safePrint('error in update users info : $e');
    }
    return null;
  }

  Future<UsersInfo?> updateFcmToken(String fcmToken) async {
    safePrint('@@@=>try update fcmToken');
    try {
      final response = await dio.patch(APIConstants.usersUpdate, data: {
        "fcmToken": fcmToken,
      });
      if (response.statusCode == 201 || response.statusCode == 200) {
        UsersInfo usersInfo = UsersInfo.fromJson(response.data);
        localUserRepository.setUsersInfo(usersInfo);
        userInfoController.setUsersInfo(usersInfo);
        return usersInfo;
      }
    } catch (e) {
      safePrint('error in update users info : $e');
    }
    return null;
  }

  Future<bool> userWithdraw(String reason) async {
    String deviceToken = userInfoController.usersInfo!.deviceToken;

    String deletedDeviceToken = 'deleted$deviceToken${DateTime.now().toString()}';
    final response = await dio.patch(APIConstants.usersUpdate, data: {
      "deviceToken": deletedDeviceToken,
    });
    if (response.statusCode == 201 || response.statusCode == 200) {
      final responseWith = await dio.patch(APIConstants.usersWithdraw, data: {"withdrawReason": reason});
      if (responseWith.statusCode == 200 || responseWith.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<UserLogin?> loginWithSocial(int loginType, String socialToken) async {
    safePrint('@@@=>try social login');
    HttpService().deleteAccessToken();

    String deviceToken = userInfoController.deviceToken;

    ///여기서 탬프 저장하자
    userInfoController.setTempSocialInfo(socialToken, loginType);
    try {
      final response = await dio.post(APIConstants.usersLogin,
          data: {
        "loginType": loginType,
            "fcmToken" : fcmToken,
            "socialToken": socialToken,
            "deviceToken": deviceToken,

          }, options: Options(headers: null));

      if (response.statusCode == 201 || response.statusCode == 200) {
        ////여기서 저장하기
        LocalUserRepository localUserRepository = LocalUserRepository();
        localUserRepository.setSocialToken(socialToken, loginType);

        UserLogin loginResponse = UserLogin.fromJson(response.data);
        localUserRepository.setAccessToken(loginResponse.access_token);
        HttpService().setAccessToken(loginResponse.access_token);
        return loginResponse;
      }
    } catch (e) {
      safePrint('error in social Login : $e');
    }
    return null;
  }

  Future<UsersInfo?> updateUsersSocialInfo(int loginType, String email, String nickName, String profileImage) async {



    safePrint('@@@=>try update users social info');
    try {
      final response = await dio.patch(APIConstants.usersUpdate,


          data: {
        "nickName": nickName,
        "profileImage": profileImage,
        "loginType": loginType,
        "email": email,
      });
      if (response.statusCode == 201 || response.statusCode == 200) {
        UsersInfo usersInfo = UsersInfo.fromJson(response.data);

        safePrint('유저 정보 저장하기 직전');
        safePrint(usersInfo);

        localUserRepository.setUsersInfo(usersInfo);
        userInfoController.setUsersInfo(usersInfo);

        return usersInfo;
      }
    } catch (e) {
      safePrint('error in update users social info : $e');
    }
    return null;
  }

  // Future<void> updateTempSocialInfo() async {
  //   safePrint('@@@=>try update users social info');
  //
  //   Get.back();
  //
  //   await loginNovice();
  //
  //   String socialToken = userInfoController.token ?? '';
  //   int loginType = userInfoController.type ?? 0;
  //
  //   Map<String, dynamic> decodedToken = JwtDecoder.decode(socialToken);
  //
  //   try {
  //     final response = await dio.patch(APIConstants.usersUpdate, data: {
  //       "loginType": loginType,
  //       "email": decodedToken['email'].toString(),
  //     });
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       UsersInfo usersInfo = UsersInfo.fromJson(response.data);
  //       localUserRepository.setUsersInfo(usersInfo);
  //       userInfoController.setUsersInfo(usersInfo);
  //     }
  //   } catch (e) {
  //     safePrint('error in update users social info : $e');
  //   }
  //   Get.find<InitProfileController>().update();
  // }



  Future<String?> signWithKaKao() async {
    // if (await isKakaoTalkInstalled()) {
    //   try {
    //     OAuthToken kakaoToken = await UserApi.instance.loginWithKakaoTalk();
    //     safePrint('카카오톡 로그인 성공');
    //     return kakaoToken.idToken;
    //   } catch (error) {
    //     safePrint('카카오톡 로그인 실패 $error');
    //     if (error is PlatformException && error.code == 'CANCELED') {
    //       return null;
    //     }
    //     try {
    //       OAuthToken kakaoToken = await UserApi.instance.loginWithKakaoAccount();
    //       safePrint('카카오계정 로그인 성공');
    //       safePrint(kakaoToken.idToken);
    //     } catch (error) {
    //       safePrint('카카오계정 로그인 실패 $error');
    //     }
    //   }
    // } else {
    //   try {
    //     OAuthToken kakaoToken = await UserApi.instance.loginWithKakaoAccount();
    //     safePrint('카카오계정 로그인 성공');
    //     return kakaoToken.idToken;
    //   } catch (error) {
    //     safePrint('카카오계정 로그인 실패 $error');
    //   }
    // }

    try {
          OAuthToken kakaoToken = await UserApi.instance.loginWithKakaoAccount();
          safePrint('카카오계정 로그인 성공');
          return kakaoToken.idToken;
        } catch (error) {
          safePrint('카카오계정 로그인 실패 $error');
        }

    return null;
  }

  Future<String?> signWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    safePrint('구글 로그인 정보');

    if (googleAuth?.idToken != null) {
      return googleAuth?.idToken;
    } else {
      return null;
    }
  }

  Future<String?> signWithNaver() async {

    safePrint('로그아웃');
    var code = await FlutterNaverLogin.logOutAndDeleteToken();
    safePrint('로그아웃');
    safePrint(code);
    NaverLoginResult result = await FlutterNaverLogin.logIn();
    String id = result.account.id;
    final account = await FlutterNaverLogin.currentAccount();

    safePrint('네이버 로그인 성공');
    safePrint(account.email.toString());


    if (account.email.toString() != '') {
      final naverToken = JWT(
        {'email': account.email.toString()},
        issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
      );
      String token = naverToken.sign(SecretKey('LA7qNNS1dsurwJI5JKgzphSm0lD2twAa'));

      return token;
    } else {
      return null;
    }
  }

  Future<bool> userLogout() async {
    final response = await dio.post(APIConstants.usersLogout);
    if (response.statusCode == 201 || response.statusCode == 200) {
      localUserRepository.deleteSocialToken();

       GoogleSignIn().signOut();
       FlutterNaverLogin.logOutAndDeleteToken();
       UserApi.instance.logout();
      Get.offAll(const InitUserScreen());
    }
    return false;
  }

  Future<void> splashSocialLoginKaKao() async {
    String? token;
    token = await signWithKaKao();
    if (token != null) {
      UserLogin? userLogin = await loginWithSocial(1, token);
      if (userLogin != null) {
        Get.find<SplashController>().onInit();
      }
    }
  }

  Future<void> splashSocialLoginGoogle() async {
    String? token;
    token = await signWithGoogle();
    if (token != null) {
      UserLogin? userLogin = await loginWithSocial(2, token);
      if (userLogin != null) {
        Get.find<SplashController>().onInit();
      }
    }
  }

  Future<void> splashSocialLoginNaver() async {
    String? token;
    token = await signWithNaver();
    if (token != null) {
      UserLogin? userLogin = await loginWithSocial(3, token);
      if (userLogin != null) {
        Get.find<SplashController>().onInit();
      }
    }
  }

  spKakao() {
    Get.back();
    splashSocialLoginKaKao();
  }

  spGoogle() {
    Get.back();
    splashSocialLoginGoogle();
  }

  spNaver() {
    Get.back();
    splashSocialLoginNaver();
  }
}
