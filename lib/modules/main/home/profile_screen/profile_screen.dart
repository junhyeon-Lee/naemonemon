import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/ui_helper/common_widget/common_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppbar(
          title: '하하',
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Hero(
                tag: 'my_profile',
                child: Container(
                  width: 230,
                  height: 230,
                child: ClipOval(
                  child: AspectRatio(
                    aspectRatio: 1.0, // Maintain a 1:1 aspect ratio for a circular shape
                    child: Image.asset(CIconPath.sample),
                  ),
                ),
                ),
              ),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                 Text('User Nick'),
              ],
            )
          ],
        ));
  }
}
