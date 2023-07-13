
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shovving_pre/util/safe_print.dart';

class LoginController extends GetxController {
  Future<void> loginWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
       OAuthToken kakaoToken = await UserApi.instance.loginWithKakaoTalk();
        safePrint('카카오톡 로그인 성공');
        safePrint(kakaoToken.idToken);
       User user = await UserApi.instance.me();
      } catch (error) {
        safePrint('카카오톡 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }

        try {
          OAuthToken kakaoToken = await UserApi.instance.loginWithKakaoAccount();
          safePrint('카카오계정 로그인 성공');
          safePrint(kakaoToken.idToken);
        } catch (error) {
          safePrint('카카오계정 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken kakaoToken = await UserApi.instance.loginWithKakaoAccount();
        safePrint('카카오계정 로그인 성공');
        safePrint(kakaoToken);
      } catch (error) {
        safePrint('카카오계정 로그인 실패 $error');
      }
    }
  }

  Future<void> loginWithNaver() async {
    NaverLoginResult result = await FlutterNaverLogin.logIn();
    String id = result.account.id;

    safePrint('네이버 로그인 성공');
    safePrint(id);
    final account = await FlutterNaverLogin.currentAccount();

  }
  void logoutWithNaver(){
    FlutterNaverLogin.logOut();
  }


  Future<void> loginWithGoogle() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    safePrint('구글 로그인 정보');
    safePrint(googleAuth?.idToken);//소셜
    safePrint('잘 나왔는가');
  }


}
