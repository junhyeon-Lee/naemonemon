import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/modules/main/home/poll/my_poll/poll_controller.dart';

import '../../../../../ui_helper/common_ui_helper.dart';

class MyPollDetailScreen extends StatelessWidget {
  const MyPollDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return GetBuilder<PollController>(builder: (pollController) {
      return Scaffold(
        body: PageView.builder(
          controller: pollController.myPollPageController,
          scrollDirection: Axis.vertical,
          itemCount: pollController.myPollList.length,
            itemBuilder: (BuildContext context, int index){
              return  SizedBox(width: Get.width, height: Get.height,
                child: Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.width,
                      child: CachedNetworkImage(
                        imageUrl: pollController.myPollList[index].items[0].image!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: CColor.gray.withOpacity(0.3),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    const Text('상세 페이지 입니당'),
                  ],
                ),
              );

        })

//2023-10-06 04:01:10.549



       ,
      );
    });
  }
}
