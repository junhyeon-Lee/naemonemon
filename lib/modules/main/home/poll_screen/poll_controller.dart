
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/util/safe_print.dart';

class PollController extends GetxController{

  @override
  Future<void> onInit() async {
    ///슬롯 리스트에 랜덤 데이터 한개 세팅
    slotList.add(slotData[Random().nextInt(9)]);
    pollCommentFocusNode = FocusNode();
    super.onInit();
  }
  @override
  void dispose() {
    pollCommentFocusNode.dispose();
    super.dispose();
  }


  ScrollController scrollController = ScrollController();
  TextEditingController pollCommentTextController = TextEditingController();
  late FocusNode pollCommentFocusNode;
  void unFocusCommentField(){
    pollCommentFocusNode.unfocus();
  }



  List<String> slotData = [
    "Help me!\nI'm not sure which\nproduct to buy.",
    "Ah....It's so damn hard to\nchoose.",
    "Pick this one I will trust\nyour sense",
    '동해물과 백두산이\n마르고 닳도록 하느님이 보우하사\n우리나라만세',
    '무궁화 삼천리 화려강산\n대한사람 대한으로 길이 보전하세',
    '이 기상과 이 맘으로\n충성을 다하여\n괴로우나 즐거우나',
    '나라 사랑하세\n무궁화 삼천리 화려강산\n대한사람 대한으로 길이 보전하세',
    '노는게 제일 좋아 친구들 모여라\n언제나 즐거워\n개구쟁이 뽀로로',
    '눈 덮힌 숲속마을\n꼬마펭귄 나가신다 언제나\n즐거워 뽀롱뽀롱 뽀로로'];
  List<String> slotList = [];
  bool manualTypeMode = false;

  Future<void> slotRandomSetting() async {
   ///돌리기 전에 슬롯 리스트에 데이를 삽입
    if(manualTypeMode==false){
      for(int i=0; i<slotData.length; i++){
        slotList.add(slotData[i]);
      }
      slotList.add(slotData[Random().nextInt(9)]);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 700),
          curve: Curves.ease,
        );
      });
      update();
    }
  }

  void manualCommentSet(){
    slotList = [pollCommentTextController.text];

   // slotList.last = pollCommentTextController.text;
    manualTypeMode?manualTypeMode=false:manualTypeMode=true;
    pollCommentTextController.clear();
    update();
  }

  typeMode(){
    manualTypeMode?manualTypeMode=false:manualTypeMode=true;
    update();
  }

}