import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/ui_helper/common_widget/common_appbar.dart';
import 'package:shovving_pre/util/local_repository/local_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({Key? key}) : super(key: key);

  @override
  State<AppSettingScreen> createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      PermissionStatus status = await Permission.notification.status;
      isMarketing = await localRepository.getMarketingPushState();
      isSocial = status.isGranted;
      setState(() {});
    });
    super.initState();
  }

  LocalRepository localRepository = LocalRepository();

  bool isMarketing = true;
  bool isSocial = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.brightGray,
      appBar: CommonAppbar(title: '앱 설정'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: SizedBox(
            width: Get.width - 40,
            height: 170-64,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Get.width - 40,
                  height: 40,
                  color: Colors.black,
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        '알람 설정',
                        style: CTextStyle.regular10.copyWith(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width: Get.width - 40,
                //   height: 64,
                //   color: Colors.white,
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           '마케팅 알람 수신',
                //           style: CTextStyle.light14,
                //         ),
                //         GestureDetector(
                //           onTap: () {
                //             setState(() {
                //               isMarketing ? isMarketing = false : isMarketing = true;
                //               localRepository.setMarketingPushState(isMarketing);
                //             });
                //           },
                //           child: Stack(
                //             children: [
                //               AnimatedContainer(
                //                 width: 60,
                //                 height: 28,
                //                 decoration: BoxDecoration(
                //                     borderRadius: const BorderRadius.all(Radius.circular(30)), color: isMarketing ? CColor.lavender : CColor.gray),
                //                 duration: const Duration(milliseconds: 150),
                //               ),
                //               AnimatedPositioned(
                //                 top: 4,
                //                 left: isMarketing ? 36 : 7,
                //                 duration: const Duration(milliseconds: 150),
                //                 child: Container(
                //                   width: 20,
                //                   height: 20,
                //                   decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white),
                //                   child: Center(
                //                     child: Container(
                //                       width: isMarketing ? 14 : 8,
                //                       height: isMarketing ? 4 : 8,
                //                       decoration: BoxDecoration(
                //                           borderRadius: const BorderRadius.all(Radius.circular(30)),
                //                           color: isMarketing ? CColor.lavender : CColor.gray),
                //                     ),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                Container(
                  width: Get.width - 40,
                  height: 2,
                  color: CColor.brightGray,
                ),
                Container(
                  width: Get.width - 40,
                  height: 64,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '알람 수신',
                          style: CTextStyle.light14,
                        ),
                        GestureDetector(
                          onTap: () async {

                              await openAppSettings().whenComplete((){
                                setState(() {
                                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
                                    PermissionStatus status = await Permission.notification.status;
                                    isSocial = status.isGranted;
                                  });
                                });
                              });


                          },
                          child: Stack(
                            children: [
                              AnimatedContainer(
                                width: 60,
                                height: 28,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(30)), color: isSocial ? CColor.lavender : CColor.gray),
                                duration: const Duration(milliseconds: 150),
                              ),
                              AnimatedPositioned(
                                top: 4,
                                left: isSocial ? 36 : 7,
                                duration: const Duration(milliseconds: 150),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white),
                                  child: Center(
                                    child: Container(
                                      width: isSocial ? 14 : 8,
                                      height: isSocial ? 4 : 8,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(30)), color: isSocial ? CColor.lavender : CColor.gray),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
