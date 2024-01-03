import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rive/rive.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/modules/main/home/poll/feed_screen/feed_controller.dart';
import 'package:shovving_pre/ui_helper/theme/custom_theme.dart';
import 'package:shovving_pre/users_info_controller.dart';
import 'package:shovving_pre/util/firebase_options.dart';
import 'package:shovving_pre/util/local_repository/local_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'modules/main/home/cart/cart_controller.dart';
import 'modules/main/home/poll/my_poll/poll_controller.dart';
import 'modules/sign/splash_screen.dart';
import 'util/sundry_function/sharing_function/sharing_function.dart';
import 'util/sundry_widget/indicator/indicator.dart';
import 'util/sundry_widget/web_view/webview_getx_controller.dart';

String fcmToken = '';
String appVersion = 'v.1.0.0.1';
bool isAdministrator = true;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channel.id,
    channel.name,
    channelDescription: channel.description,
    icon: '@mipmap/launcher_icon',
  );

  safePrint('푸시 함수 작동');
  LocalRepository localRepository = LocalRepository();

  bool isSocialState = await localRepository.getSocialPushState();
  safePrint(isSocialState);



  String body = message.notification?.body ?? '';
  if (body.contains('님이 당신의 투표에 참여했어요.') ||
      body.contains('님이 당신의 투표에 댓글을 남겼어요.') ||
      body.contains('님이 당신의 투표에 좋아요를 남겼어요.') ||
      body.contains('님이 당신의 댓글에 좋아요를 남겼어요.') ||
      body.contains('님의 투표가 종료되었어요. 지금 결과를 확인해보세요.')) {

    if(isSocialState){
      safePrint('푸시를 보냅니다');
      await FlutterLocalNotificationsPlugin().show(
        0,
        message.notification?.title ?? "",
       'terst',
       // message.notification?.body ?? "",
        NotificationDetails(android: androidPlatformChannelSpecifics),
      );
    }else{safePrint('푸시를 보내지 않습니다');}

  }else{
    safePrint('이벤트 푸시');
    await FlutterLocalNotificationsPlugin().show(
      0,
      message.notification?.title ?? "",
      message.notification?.body ?? "",
      NotificationDetails(android: androidPlatformChannelSpecifics),
    );
  }





}


final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  ///알림 권한 위치 변경 필요
  PermissionStatus status = await Permission.notification.status;
  Map<Permission, PermissionStatus> statuses = await [Permission.notification].request();

  await _flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(),
    ),
  );

  ///파이어베이스 토큰
  await Firebase.initializeApp(name: 'fireOption', options: DefaultFirebaseOptions.currentPlatform);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);



  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  ///포그라운드 푸시
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    safePrint(message);
    safePrint('fcm 포그라운드 수신');
    safePrint(message.notification?.title.toString());
    safePrint(message.notification?.body.toString());
    safePrint(message.data?.toString());
    safePrint('Message data: ${message.data}');
    _firebaseMessagingBackgroundHandler(message);
  });

  ///고정 컨트롤러
  final feedController = Get.put<FeedController>(FeedController(), permanent: true);
  final pollController = Get.put<PollController>(PollController(), permanent: true);
  final homeController = Get.put<HomeController>(HomeController(), permanent: true);
  final userInfoController = Get.put<UserInfoController>(UserInfoController(), permanent: true);
  final cartController = Get.put<CartController>(CartController(), permanent: true);
  final webViewGetXController = Get.put<WebViewGetXController>(WebViewGetXController(), permanent: true);
  final indicatorController = Get.put<IndicatorController>(IndicatorController(), permanent: true);

  ///고정 컨트롤러

  String? firebaseToken = await FirebaseMessaging.instance.getToken();
  fcmToken = firebaseToken ?? '';

  ///카카오 세팅
  KakaoSdk.init(nativeAppKey: '9fbc241e8b936d177d706de29f671650');
  runApp(const MyApp());
}

final userInfoController = Get.find<UserInfoController>();

final homeController = Get.find<HomeController>();
final cartController = Get.find<CartController>();
final pollController = Get.find<PollController>();
final webViewGetXController = Get.find<WebViewGetXController>();
final indicatorController = Get.find<IndicatorController>();
final feedController = Get.find<FeedController>();



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await FkUserAgent.init();
      initPlatformState();
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    safePrint('@@@@@@@@@@');
    safePrint('앱 상태가 변했습니다.');
    safePrint(state);
    safePrint('@@@@@@@@@@');

    if (state == AppLifecycleState.resumed) {
      homeController.update();
      SharingRepository sharingRepository = SharingRepository();
      sharingRepository.clipboardShare();
      homeController.update();
    }
  }




  Future<void> initPlatformState() async {
    String? platformVersion;
    try {
      platformVersion = FkUserAgent.userAgent!;
    } on PlatformException {
      platformVersion = null;
    }
    if (!mounted) return;
    userInfoController.setAgent(platformVersion);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme: CustomTheme.mainTheme,
          initialRoute: '/',
          navigatorKey: navigatorKey,
          builder: FToastBuilder(),
          getPages: [
            GetPage(name: '/', page: () => const SplashScreen()),
          ],
        );
      },
    );
  }
}

///이미지 느낌표 이슈 관련 코드
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

var channel = const AndroidNotificationChannel(
  'shovving-pre', // id
  'shovving-pre', // name
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);

