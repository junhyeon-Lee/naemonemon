import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/cart_screen/cart_controller.dart';
import 'package:shovving_pre/modules/main/home/group_screen/group_controller.dart';
import 'package:shovving_pre/util/safe_print.dart';

class LocalRepository {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  static const myCartListKey = '_myCartListKey';

  void updateMyCartList(List<UrlData> myCartList) async {
    safePrint('@@@=>update now list');
    var pref = await _pref;

    List<String> localUrlDataList=[];

    for (int i = 0; i < myCartList.length; i++) {
      localUrlDataList.add(jsonEncode(myCartList[i]));
    }

    pref.setStringList(myCartListKey, localUrlDataList);
    Get.find<CartController>().updateNowList(myCartList);

  }

  Future<void> findMyCartList() async {
    safePrint('@@@=>get now list');
    var pref = await _pref;
    var localUrlDataList = pref.getStringList(myCartListKey)??[];
    safePrint('now list length:${localUrlDataList.length}');
    List<UrlData> myUrlDataList = [];

    if (localUrlDataList.isNotEmpty) {
      for (int i = 0; i < localUrlDataList.length; i++) {
        myUrlDataList.add(UrlData.fromJson(jsonDecode(localUrlDataList[i])));
      }
    }
      Get.find<CartController>().updateNowList(myUrlDataList);
  }

  Future<void> deleteCartList(List<UrlData> nowCartList, List<bool> stateList, List<String> idList) async {
    safePrint('@@@=>delete now list');
    var pref = await _pref;

    List<UrlData> myUrlDataList = [];
    List<String> newUrlDataList = [];

    for(int i=0; i<nowCartList.length; i++){
      bool isContain = false;

        if(idList.contains(nowCartList[i].id)){
          isContain =true;
        }

      if(isContain){
        // Get.find<CartController>().cartItemState.removeAt(i);
        // Get.find<CartController>().selectedCartItemState.removeAt(i);
      }else{
        myUrlDataList.add(nowCartList[i]);
      }
    }

    for(int i=0; i<myUrlDataList.length; i++){
        newUrlDataList.add(jsonEncode(myUrlDataList[i]));
    }

    pref.setStringList(myCartListKey, newUrlDataList);
    Get.find<CartController>().updateNowList(myUrlDataList);
    Get.find<CartController>().filterNowCartList(Get.find<GroupController>().groupId);
  }

  // Future<void> cartItemAddGroup(List<UrlData> nowCartList,) async {
  //   var pref = await _pref;
  //
  //   List<UrlData> myUrlDataList = [];
  //   List<String> newUrlDataList = [];
  //
  //
  //   for(int i=0; i<stateList.length; i++){
  //     if(stateList[i]==true){
  //       Get.find<CartController>().cartItemState.removeAt(i);
  //       Get.find<CartController>().selectedCartItemState.removeAt(i);
  //     }else{
  //       myUrlDataList.add(nowCartList[i]);
  //     }
  //   }
  //
  //   for(int i=0; i<myUrlDataList.length; i++){
  //     newUrlDataList.add(jsonEncode(myUrlDataList[i]));
  //   }
  //
  //   pref.setStringList(myCartListKey, newUrlDataList);
  //   Get.find<CartController>().updateNowList(myUrlDataList);
  // }
}
