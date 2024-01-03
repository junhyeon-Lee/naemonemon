import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as getx;
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/modules/main/home/home_screen.dart';
import 'package:shovving_pre/modules/sign/sign_controller/sign_repository.dart';
import 'package:shovving_pre/util/dio/dio_api.dart';
import 'package:shovving_pre/util/sundry_function/dialog/dialog.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/profile/inti_profile_controller.dart';

import '../../modules/sign/sign_controller/splash_controller.dart';

int productRegister = 0;

class DioCustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {


    safePrint('### REQUEST [method: ${options.method}] PATH: ${options.path}');
    safePrint('@@@header@@@:${options.headers}');
    safePrint('@@@bbodyy@@@:${options.data}');
    safePrint('@@@queryy@@@:${options.queryParameters}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    indicatorController.completeLoading();
    safePrint(
      '### RESPONSE [status : ${response.statusCode}] PATH: ${response.requestOptions.path}',
    );
    safePrint(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    indicatorController.completeLoading();
    safePrint('get error in Dio Error');

    if(err.response?.data['message'].toString() == "User Doesn't Exist"){
      ///해야하는 것은 소셜 정보를 클리어 하고 시작점으로 되돌리는 것
      getx.Get.find<SplashController>().notOverrideUserInfo();
    }

    safePrint('자자 여기');
    safePrint('${err.response?.statusCode} ${err.response?.data['message']}' ?? '');

    if(err.response?.data['message'].toString() == "User Doesn't Exist"){
      safePrint('신규 회원');

      getx.Get.back();
      getx.Get.find<InitProfileController>().isGuideStep = false;
      getx.Get.find<InitProfileController>().update();
    }

    // if (err.response?.data['message'].toString().substring(0, 23) == 'The user login type is ') {
    //   String type = err.response?.data['message'].toString().substring(23, 24) == '1'
    //       ? '카카오'
    //       : err.response?.data['message'].toString().substring(23, 24) == '2'
    //           ? '구글'
    //           : err.response?.data['message'].toString().substring(23, 24) == '3'
    //               ? '네이버'
    //               : '노비스';
    //   SignRepository signRepository = SignRepository();
    //   if (err.response?.data['message'].toString().substring(23, 24) == '1') {
    //     showDefaultDialog('해당 기기로 생성된 계정이 조회되었습니다.\n$type로 로그인을 진행하시겠습니까?', '진행', '취소', signRepository.spKakao, SystemNavigator.pop);
    //   } else if (err.response?.data['message'].toString().substring(23, 24) == '2') {
    //     showDefaultDialog('해당 기기로 생성된 계정이 조회되었습니다.\n$type로 로그인을 진행하시겠습니까?', '진행', '취소', signRepository.spGoogle, SystemNavigator.pop);
    //   } else if (err.response?.data['message'].toString().substring(23, 24) == '3') {
    //     showDefaultDialog('해당 기기로 생성된 계정이 조회되었습니다.\n$type로 로그인을 진행하시겠습니까?', '진행', '취소', signRepository.spNaver, SystemNavigator.pop);
    //   } else if (err.response?.data['message'].toString().substring(23, 24) == '5') {
    //
    //     ///여기서 그냥 업데이트 하면 된다는거 아닙니까?
    //     //showDefaultDialog('해당 소셜 정보와 연결된 계정이 없습니다.\n이 계정과 이 소셜정보를 연결하시겠습니까?', '진행', '취소', signRepository.updateTempSocialInfo, getx.Get.back);
    //     safePrint('이게 신규 유저 케이스');
    //     await getx.Get.find<InitProfileController>().noviceLogin();
    //     await getx.Get.find<InitProfileController>().socialLogin();
    //
    //
    //   }
    // } else if (err.response?.data['message'].toString().substring(0, 23) == 'The user login email is') {
    //   String type = err.response?.data['message'].toString().substring(23, err.response?.data['message'].toString().length) ?? '';
    //   showDefaultDialog('해당 기기로 생성된 계정이 조회되었습니다.\n$type계정을\n사용해서 로그인해주세요.', '진행', '취소', emailProgress, SystemNavigator.pop);
    // } else {
    //   var reqOptions = err.requestOptions;
    //   handler.resolve(await _retry(reqOptions));
    // }



  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    safePrint('api retry');
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return await HttpService()
        .to()
        .request<dynamic>(requestOptions.path, data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);
  }
}

emailProgress() {
  getx.Get.back;
  getx.Get.find<SplashController>().onInit();
}
