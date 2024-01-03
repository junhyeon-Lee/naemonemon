import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/api_model/users/users_info.dart';
import 'package:shovving_pre/models/api_model/users/users_login.dart';
import 'package:shovving_pre/modules/main/home/home_screen.dart';
import 'package:shovving_pre/modules/sign/init_user_screen.dart';
import 'package:shovving_pre/modules/sign/sign_controller/sign_repository.dart';
import 'package:shovving_pre/util/local_repository/local_user_repository.dart';
import 'package:shovving_pre/util/sundry_function/dialog/dialog.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

import '../../main/home/cart/cart_repository.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {

    ///소셜 인포는 List형태이며 0,1순서대로 소셜토큰, 로그인 타입을 가지고 있습니다.
    LocalUserRepository localUserRepository = LocalUserRepository();
    List<String>? socialInfo = await localUserRepository.getSocialToken();

    String? socialToken;
    int? loginType;
    bool? isNewMember;

    ///이 디바이스의 소셜 정보가 저장되어 있다면
    if (socialInfo != null) {
      socialToken = socialInfo[0];
      loginType = int.parse(socialInfo[1]);
      isNewMember = await socialLogin(socialToken, loginType);

      await cartRepository.setCartList();
      await feedController.setFeedList();
      pollController.setPollList();
      pollController.setJoinedPollList();
      ///데이터 적용 완료
      Get.offAll(const HomeScreen());

    }
    else {
      safePrint('이거잖수');
      Get.to(const InitUserScreen());
    }

    ///피드는 맨 처음에 보이니까 먼저 처리를 해주겠습니다.





    super.onInit();
  }

  SignRepository signRepository = SignRepository();
  CartRepository cartRepository = CartRepository();
  LocalUserRepository localUserRepository = LocalUserRepository();

  // Future<bool?> noviceLogin() async {
  //   UserLogin? noviceLoginResponse = await signRepository.loginNovice();
  //   if (noviceLoginResponse != null) {
  //     UsersInfo? response = await signRepository.getUsersInfo();
  //     if (response?.profileImage != null && response?.nickName != null) {
  //       return false;
  //     } else {
  //       return true;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

  String? userDeviceToken;
  String userSocialToken = '';
  int userLoginType = 0;

  ///이거는 정상 로그인 성공 케이스
  Future<bool?> socialLogin(String socialToken, int loginType) async {
    ///바로 소셜 로그인을 시도합니다. 이 함수는 유저 컨트롤러에 유저 정보를 저장하는 역할까지 수행합니다.
    UserLogin? socialLoginResponse = await signRepository.loginWithSocial(loginType, socialToken);

    ///null을 수신한 경우 다른 판단 없이 null을 반환합니다
    if (socialLoginResponse != null) {
      await signRepository.getUsersInfo();
      return false;
    } else {
      return null;
    }
  }

  // ///이건 곧 사용할꺼임
  // Future<void> overrideUserInfo() async {
  //   if (userDeviceToken != null) {
  //     ///지금은 소셜 로그인으로 로그인한 계정임 즉 다시 노비스 계정으로 로그인하고 그거 탈퇴 시키고 로그인 다시하고 정보 업데이트 해야함
  //
  //     await signRepository.loginNovice();
  //     await signRepository.userWithdraw('loginExistingAccount');
  //     await signRepository.loginWithSocial(userLoginType, userSocialToken);
  //
  //     Get.offAll(const HomeScreen());
  //   }
  // }

  void notOverrideUserInfo() {
    localUserRepository.deleteSocialToken();
    onInit();
  }
}
