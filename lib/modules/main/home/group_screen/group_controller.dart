import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/models/local_model/group/group.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/cart_screen/cart_controller.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/ui_helper/icon_path/group_icon_path.dart';
import 'package:shovving_pre/util/local_repository/local_group_repository.dart';
import 'package:shovving_pre/util/local_repository/local_repository.dart';

class GroupController extends GetxController {
  @override
  Future<void> onInit() async {
    //포커스 노드
    groupNameFocusNode = FocusNode();
    //그룹 데이터 가져오기
    groupList = await localGroupRepository.getGroup();
    super.onInit();
  }
  @override
  void dispose() {
    groupNameFocusNode.dispose();
    super.dispose();
  }

  LocalGroupRepository localGroupRepository = LocalGroupRepository();
  TextEditingController groupNameController = TextEditingController();
  late FocusNode groupNameFocusNode;

  bool designateMode = false;
  bool groupMode = false;

  RxString groupName = ''.obs;
  RxInt groupColor = 0.obs;
  RxInt groupIcon = 1.obs;
  String groupId = '';

  int selectGroupIndex = 0;

  List<Group> groupList = [];

  void unFocusNameField(){
    groupNameFocusNode.unfocus();
    if(selectGroupIndex!=0&&selectGroupIndex!=-1){
      editGroup(selectGroupIndex);
    }
  }

  ///색상 선택
  void selectColor(int index) {
    groupNameFocusNode.unfocus();
    groupColor.value = index;
    if(selectGroupIndex!=0&&selectGroupIndex!=-1){
      editGroup(selectGroupIndex);
    }
  }
  void selectIcon(int index) {
    groupNameFocusNode.unfocus();
    groupIcon.value = index;
    groupName.value = GIconPath.gIconList[groupIcon.value + 1].replaceAll('assets/svgs/group/', '').replaceAll('.svg', '');
    if(selectGroupIndex!=0&&selectGroupIndex!=-1){
      editGroup(selectGroupIndex);
    }
  }
  void setGroup(List<Group> list){
    groupList = list;
    update();
  }
  void selectGroup(int index){
      selectGroupIndex=index;
      groupMode = true;
      if(index!=0&&index!=-1){
        groupNameController.clear();
        groupName.value = groupList[index-1].groupName;
        groupColor.value = groupList[index-1].groupColorId;
        groupIcon.value = groupList[index-1].groupIconId;
        groupId = groupList[index-1].groupId;

      }else{
        groupMode = false;
        groupNameController.clear();
        groupName.value = '';
        groupColor.value = 0;
        groupIcon.value = 1;
        groupId = '';

      }
    Get.find<HomeController>().update();
      update();
  }
//deleteGroup
  Future<void> addGroup() async {
    if (groupNameController.text.isEmpty && groupName.value == '') {
    }
    else {
      await localGroupRepository.addGroup(Group(
          groupName: groupNameController.text.isEmpty ? groupName.value : groupNameController.text,
          groupColorId: groupColor.value,
          groupIconId: groupIcon.value,
          groupId: 'tempId ${DateTime.now()}')).then((value) {
        groupNameController.clear();
        groupName.value = '';
        groupColor.value = 0;
        groupIcon.value = 1;
        groupId = '';
      });
    }
  }
  Future<void> editGroup(int index) async {
    if (groupNameController.text.isEmpty && groupName.value == '') {
    }
    else {
      await localGroupRepository.editGroup(Group(
          groupName: groupNameController.text.isEmpty ? groupName.value : groupNameController.text,
          groupColorId: groupColor.value,
          groupIconId: groupIcon.value,
          groupId: groupId),index).then((value) {
      });
    }

  }
  Future<void> deleteGroup(int index) async{
    //이거로 다 찾아내야 한다.
    String deletedGroupId = groupId;
    await localGroupRepository.deleteGroup(Group(
        groupName: groupNameController.text.isEmpty ? groupName.value : groupNameController.text,
        groupColorId: groupColor.value,
        groupIconId: groupIcon.value,
        groupId: groupId),index).then((value) {
      groupNameController.clear();
      groupName.value = '';
      groupColor.value = 0;
      groupIcon.value = 1;
      groupId ='';
      selectGroupIndex=-1;
      update();
    });


    List<UrlData> newUrlList = [];
    //현재 리스트 모든 항목에 대하여 반복
    for(int i=0; i<Get.find<CartController>().nowCartList.length; i++){

      //리스트의 하나의 항목의 그룹 안에서 찾아내기
      List<String> newGroup = [];
      for(int j=0; j<Get.find<CartController>().nowCartList[i].group.length; j++){

        if(deletedGroupId == Get.find<CartController>().nowCartList[i].group[j]){

          //삭제된 아이디가 여기에 존재 한다면 스킵
        }else{
          newGroup.add(Get.find<CartController>().nowCartList[i].group[j]);
        }
      }

      UrlData newUrlData = Get.find<CartController>().nowCartList[i].copyWith(group: newGroup);
      newUrlList.add(newUrlData);


    }

    Get.find<CartController>().updateNowList(newUrlList);
    LocalRepository localRepository = LocalRepository();
    localRepository.updateMyCartList(newUrlList);






  }

  void closeGroupMode(){
    selectGroupIndex = 0;
    unFocusNameField();
    update();
  }

  void slideAction(){
    if(selectGroupIndex==-1){
      addGroup();
    }else if(selectGroupIndex ==0){
     null;
    }else{
      //editGroup(selectGroupIndex);
      deleteGroup(selectGroupIndex);
    }
  }

  void enterDesignateMode(){
    designateMode = true;
    Get.find<HomeController>().update();
    update();
  }
  void closeDesignateMode(){
    designateMode = false;
    Get.find<HomeController>().update();
    Get.find<CartController>().update();
    Get.find<CartController>().filterNowCartList(groupId);
    update();
  }

  Group? getGroupInfo(String groupId){
    for(int i=0; i<groupList.length; i++){

      if(groupId == groupList[i].groupId){
        return groupList[i];
      }

    }

    return null;
  }

}
