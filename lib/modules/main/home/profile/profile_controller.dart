import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/api_model/users/users_info.dart';
import 'package:shovving_pre/models/api_model/users/users_login.dart';
import 'package:shovving_pre/modules/sign/sign_controller/sign_repository.dart';
import 'package:shovving_pre/modules/sign/sign_controller/splash_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/users_info_controller.dart';
import 'package:shovving_pre/util/local_repository/local_user_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/profile/nickname_preset.dart';
import 'package:video_player/video_player.dart';

class ProfileController extends GetxController{


  @override
  Future<void> onInit() async {
    safePrint('로그인 타입');
    safePrint(userInfoController.usersInfo?.loginType);

    nowUsersInfo = Get.find<UserInfoController>().usersInfo;

    leftWord = NickNamePreset.leftWord[Random().nextInt(270)];
    rightWord = NickNamePreset.rightWord[Random().nextInt(390)];
    textEditingController = TextEditingController();
    textFocusNode = FocusNode();
    super.onInit();
  }
  LocalUserRepository localUserRepository = LocalUserRepository();




  String? settingImage;
  String profilePath = userInfoController.usersInfo!.profileImage??ImagePath.presetProfile[0];



  UsersInfo? nowUsersInfo;
  File? userSelfImage;



  Future<UsersInfo?> getUsersInfo() async {
    return await localUserRepository.getUsersInfo();
  }


///닉네임 변경
  bool isNicknameChangeMode = false;
  late FocusNode textFocusNode;
  late TextEditingController textEditingController;
  String leftWord = '';
  String rightWord = '';

  openNicknameChangeMode(){
    isNicknameChangeMode = true;
    update();
  }
  closeNicknameChangeMode(){
    isNicknameChangeMode = false;
    update();
  }


  leftSlot() {
    textFocusNode.unfocus();
    textEditingController.clear();
    leftWord = NickNamePreset.leftWord[Random().nextInt(270)];
    update();
  }

  rightSlot() {
    textFocusNode.unfocus();
    textEditingController.clear();
    rightWord = NickNamePreset.rightWord[Random().nextInt(390)];
    update();
  }


  SignRepository signRepository = SignRepository();
  userInitUpdate() async {
    String nickName = '$leftWord$rightWord';
    if(textEditingController.text.isNotEmpty){
      nickName=textEditingController.text;
    }


    safePrint('뭐지요');
    safePrint(profilePath);

    UsersInfo? response = await signRepository.updateUsersInfo(nickName, profilePath);
    update();
  }

  ///소셜로그인을 하고 해당 정보를 통해 로그인 api를 호출하고 소셜 토큰을 갈아끼우는 함수
  Future<void> socialLogin(int loginType) async {

    String socialToken ='';

    SignRepository signRepository = SignRepository();
    LocalUserRepository localUserRepository = LocalUserRepository();
    if(loginType == 1){
      socialToken= await signRepository.signWithKaKao()??'';
    }else if(loginType ==2){
      socialToken= await signRepository.signWithGoogle()??"";
    }else if(loginType ==3){
      socialToken= await signRepository.signWithNaver()??'';
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(socialToken);

    // if(decodedToken['email'].toString().contains('@')){
    //   UsersInfo? response = await signRepository.updateUsersSocialInfo(loginType, decodedToken['email'].toString());
    //   update();
    // }

    ///여기서는 업데이트


    // UserLogin? noviceLoginResponse = await signRepository.loginWithSocial(loginType, socialToken);
    // if(noviceLoginResponse!=null){
    //   UsersInfo? response = await signRepository.getUsersInfo();
    //   if(response!=null){
    //     localUserRepository.setUsersInfo(response);
    //   }
    //
    // }else{
    //
    // }

  }

  showLogoutBottomSheet(){
    Get.bottomSheet(

        Container(
          height: 200, width: Get.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),color: Colors.white,
          ),


          child: Column(children: [
            const SizedBox(height: 6,),
            Container(width: 60, height: 6,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),),

            const SizedBox(height: 10,),

            Text('로그아웃',style: CTextStyle.light20.copyWith(height: 40/20),),
            const SizedBox(height: 20,),

            Text('로그아웃 하시겠습니까?',style: CTextStyle.light16.copyWith(height: 20/16),textAlign: TextAlign.center,),
            const SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      Get.back();
                    },
                    child: Container(width: 130, height: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(36)),
                        border: Border.all(width: 1, color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(CIconPath.close,width: 32,),
                          const SizedBox(width: 6,),
                          Text('취소',style: CTextStyle.bold14.copyWith(color: Colors.black),)
                        ],),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){


                      signRepository.userLogout();

                    },
                    child: Container(width: 130, height: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(36)),
                        border: Border.all(width: 1, color: Colors.black),
                        color: Colors.black,
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(CIconPath.checkItem,width: 32,color: Colors.white,),
                          const SizedBox(width: 6,),
                          Text('확인',style: CTextStyle.bold14,)
                        ],),
                    ),
                  ),
                ],
              ),
            )




          ],),


        )

    );
  }



}