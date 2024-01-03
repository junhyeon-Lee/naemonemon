import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

import '../../modules/main/home/cart/cart_repository.dart';

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
    cartController.updateNowList(myCartList);


  }

  void initUpdateMyCartList(List<UrlData> myCartList) async {
    safePrint('@@@=>update now list');
    var pref = await _pref;

    List<String> localUrlDataList=[];

    for (int i = 0; i < myCartList.length; i++) {
      localUrlDataList.add(jsonEncode(myCartList[i]));
    }

    pref.setStringList(myCartListKey, localUrlDataList);
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
    cartController.updateNowList(myUrlDataList);
  }

  Future<void> deleteCartList(List<UrlData> nowCartList, List<bool> stateList, List<String> idList) async {
    safePrint('@@@=>delete now list');
    var pref = await _pref;

    List<UrlData> myUrlDataList = [];
    List<String> newUrlDataList = [];
    List<UrlData> beDeletedCart = [];

    for(int i=0; i<nowCartList.length; i++){
      bool isContain = false;

        if(idList.contains(nowCartList[i].localId)){
          isContain =true;
        }

      if(isContain){

        beDeletedCart.add(nowCartList[i]);
      }else{
        myUrlDataList.add(nowCartList[i]);
      }
    }

    for(int i=0; i<myUrlDataList.length; i++){
        newUrlDataList.add(jsonEncode(myUrlDataList[i]));
    }

    pref.setStringList(myCartListKey, newUrlDataList);
    cartController.updateNowList(myUrlDataList);

    CartRepository cartRepository = CartRepository();
    cartRepository.deleteCart(beDeletedCart);


  }

  setUsedUrlList(String newUrl) async {
    var pref = await _pref;
    List<String> usedUrlList = await getUsedUrlList();
    usedUrlList.add(newUrl);
    await pref.setStringList('setUsedUrlList', usedUrlList);
  }

  Future<List<String>> getUsedUrlList() async {
    var pref = await _pref;
    List<String> usedUrlList = pref.getStringList('setUsedUrlList')??[];
    return usedUrlList;
  }

  static const marketingPushState = 'marketingPushState';
  static const socialPushState = 'socialPushState';

  setMarketingPushState(bool isMarketing) async {
    var pref = await _pref;
    await pref.setBool(marketingPushState, isMarketing);

  }
  setSocialState(bool isSocial) async {
    var pref = await _pref;
    await pref.setBool(socialPushState, isSocial);
  }

  Future<bool> getMarketingPushState() async {
    var pref = await _pref;
    bool marketingPushState = pref.getBool('marketingPushState')??true;
    return marketingPushState;
  }

  Future<bool> getSocialPushState() async {
    var pref = await _pref;
    bool socialPushState = pref.getBool('socialPushState')??true;
    return socialPushState;
  }


}
