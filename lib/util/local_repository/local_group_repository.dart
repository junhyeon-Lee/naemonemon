import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shovving_pre/models/local_model/group/group.dart';
import 'package:shovving_pre/modules/main/home/group_screen/group_controller.dart';
import 'package:shovving_pre/util/safe_print.dart';

class LocalGroupRepository{
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  static const groupKey = '_groupKey';

  Future<void> addGroup(Group group) async {
    safePrint('@@@=>add new group');
    var pref = await _pref;
    List<String> localGroupList = pref.getStringList(groupKey) ?? [];
    List<Group> groupList = [];

    ///데이터를 모델화 시켜서 리스트에 추가
    if (localGroupList.isNotEmpty) {
      for (int i = 0; i < localGroupList.length; i++) {
        groupList.add(Group.fromJson(jsonDecode(localGroupList[i])));
      }
    }
    ///새로운 데이터 리스트에 추가
    groupList.add(group);
    ///업데이트 된 리스트를 home controller의 group List에 저장한다.
    Get.find<GroupController>().setGroup(groupList);
    ///새로운 데이터가 추가된 리스트를 로컬에 저장
    localGroupList.clear();
    for (int i = 0; i < groupList.length; i++) {
      localGroupList.add(jsonEncode(groupList[i]));
    }
    ///로컬에 데이터 저장
    await pref.setStringList(groupKey, localGroupList);
  }

  Future<void> editGroup(Group group, int index) async {
    safePrint('@@@=>edit group');
    var pref = await _pref;
    List<String> localGroupList = pref.getStringList(groupKey) ?? [];
    List<Group> groupList = [];

    ///데이터를 모델화 시켜서 리스트에 추가
    if (localGroupList.isNotEmpty) {
      for (int i = 0; i < localGroupList.length; i++) {
        if(index-1==i){
          ///수정된 데이터는 중간에 삽입
          groupList.add(group);
        }else{
          groupList.add(Group.fromJson(jsonDecode(localGroupList[i])));
        }
      }
    }

    ///업데이트 된 리스트를 home controller의 group List에 저장한다.
    Get.find<GroupController>().setGroup(groupList);
    ///새로운 데이터가 추가된 리스트를 로컬에 저장
    localGroupList.clear();
    for (int i = 0; i < groupList.length; i++) {
      localGroupList.add(jsonEncode(groupList[i]));
    }
    ///로컬에 데이터 저장
    await pref.setStringList(groupKey, localGroupList);
  }

  Future<List<Group>> getGroup() async {
    safePrint('@@@=>get group list');
    var pref = await _pref;
    List<String> localGroupList = pref.getStringList(groupKey) ?? [];
    List<Group> groupList = [];
    ///데이터를 모델화 시켜서 리스트에 추가
    if (localGroupList.isNotEmpty) {
      for (int i = 0; i < localGroupList.length; i++) {
        groupList.add(Group.fromJson(jsonDecode(localGroupList[i])));
      }
    }
    return groupList;
  }

  Future<void> deleteGroup(Group group, int index) async {
    safePrint('@@@=>delete group');
    var pref = await _pref;
    List<String> localGroupList = pref.getStringList(groupKey) ?? [];
    List<Group> groupList = [];

    ///데이터를 모델화 시켜서 리스트에 추가
    if (localGroupList.isNotEmpty) {
      for (int i = 0; i < localGroupList.length; i++) {
        if(index-1==i){
          ///수정된 데이터는 중간에 건너뛰기
        }else{
          groupList.add(Group.fromJson(jsonDecode(localGroupList[i])));
        }
      }
    }

    ///업데이트 된 리스트를 home controller의 group List에 저장한다.
    Get.find<GroupController>().setGroup(groupList);
    ///새로운 데이터가 추가된 리스트를 로컬에 저장
    localGroupList.clear();
    for (int i = 0; i < groupList.length; i++) {
      localGroupList.add(jsonEncode(groupList[i]));
    }
    ///로컬에 데이터 저장
    await pref.setStringList(groupKey, localGroupList);
  }
}