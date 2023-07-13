import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shovving_pre/modules/main/home/home_screen.dart';
import 'package:shovving_pre/modules/main/home/poll_screen/poll_create_screen.dart';
import 'package:shovving_pre/modules/sign/login_screen.dart';
import 'package:shovving_pre/ui_helper/theme/custom_theme.dart';

Future<void> main() async {
  KakaoSdk.init(nativeAppKey: '9fbc241e8b936d177d706de29f671650');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: CustomTheme.mainTheme,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
      ],
    );
  }
}
