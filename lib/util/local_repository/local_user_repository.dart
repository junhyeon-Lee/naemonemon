import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shovving_pre/models/api_model/users/users_info.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

class LocalUserRepository{
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  static const userTokenKey = '_userTokenKey';
  static const userInfo = '_userInfoKey';
  static const groupOrderKey = '_groupOrderKey';
  static const socialKey = '_socialKey';

  Future<void> setAccessToken(String accessToken) async {
    safePrint('@@@=>set accessToken');
    var pref = await _pref;
    await pref.setString(userTokenKey, accessToken);
  }
  Future<String?> getAccessToken(String accessToken) async {
    safePrint('@@@=>get accessToken');
    var pref = await _pref;
    return pref.getString(userTokenKey);
  }
  Future<void> deleteAccessToken(String accessToken) async {
    safePrint('@@@=>delete accessToken');
    var pref = await _pref;
    await pref.remove(userTokenKey);
  }

  Future<void> setUsersInfo(UsersInfo usersInfo) async{
    safePrint('@@@=>set users info');
    var pref = await _pref;
    String userInfoString = jsonEncode(usersInfo);
    await pref.setString(userInfo, userInfoString);
  }
  Future<UsersInfo?> getUsersInfo() async{
    safePrint('@@@=>get users info');
    var pref = await _pref;
    String? usersInfoString = pref.getString(userInfo);

    if(usersInfoString!=null){
      return UsersInfo.fromJson(jsonDecode(usersInfoString));
    }

    return null;

  }

  Future<void> setSocialToken(String socialToken, int loginType) async {
    safePrint('@@@=>set socialToken');
    var pref = await _pref;
    await pref.setString(socialKey, '$socialToken,$loginType');

  }
  Future<List<String>?> getSocialToken() async {
    safePrint('@@@=>get socialToken');
    var pref = await _pref;
    String? socialInfo =  pref.getString(socialKey);
    if(socialInfo !=null){
      return socialInfo.split(',');
    }
    return null;
  }
  Future<void> deleteSocialToken() async {
    safePrint('@@@=>delete socialToken');
    var pref = await _pref;
    await pref.remove(socialKey);
  }


  Future<void> setGroupOrder(List<String> groupIdList) async {
    safePrint('@@@=>set groupOrder');
    var pref = await _pref;
    await pref.setStringList(groupOrderKey, groupIdList);

  }
  Future<List<String>?> getAGroupOrder() async {
    safePrint('@@@=>get groupOrder');
    var pref = await _pref;
    return pref.getStringList(groupOrderKey);
  }
  Future<Future<bool>> deleteAGroupOrder() async {
    safePrint('@@@=>get delete groupOrder');
    var pref = await _pref;
    return pref.remove(groupOrderKey);
  }
}