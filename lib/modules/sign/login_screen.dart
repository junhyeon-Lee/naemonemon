import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/modules/sign/login_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/safe_print.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (loginController) {
          return Scaffold(
            body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 150,),
                GestureDetector(
                  onTap: () async {
                    safePrint('카카오');
                    loginController.loginWithKakao();
                  },
                  child: CommonContainer(width: 100, height: 100,
                    containerColor: Colors.green,
                    child: const Center(child: Text('카카오'),),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    safePrint('구글');
                    loginController.loginWithGoogle();
                  },
                  child: CommonContainer(width: 100, height: 100,
                    containerColor: Colors.yellow,
                    child: const Center(child: Text('구글'),),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        safePrint('네이버');
                        loginController.loginWithNaver();
                      },
                      child: CommonContainer(width: 100, height: 100,
                        containerColor: Colors.blue,
                        child: const Center(child: Text('네이버'),),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        safePrint('네이버');
                        loginController.logoutWithNaver();
                      },
                      child: CommonContainer(width: 100, height: 100,
                        containerColor: Colors.red,
                        child: const Center(child: Text('네이버 로그아웃'),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 150,),
              ],
            ),
          );
        },
      );
  }
}
