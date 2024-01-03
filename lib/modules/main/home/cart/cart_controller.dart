import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/cart/cart_repository.dart';
import 'package:shovving_pre/util/local_repository/local_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/sharing_function/sharing_function.dart';
import 'package:shovving_pre/util/sundry_function/url_previewer/src/parser/base.dart';

import '../../../../ui_helper/common_ui_helper.dart';

class CartController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await localRepository.findMyCartList();
    sharingRepository.getSharedUrl(nowCartList);
    filterNowCartList('all');

    Future.delayed(const Duration(seconds: 3),(){
      sharingRepository.clipboardShare();
    });


    update();
  }

  LocalRepository localRepository = LocalRepository();
  CartRepository cartRepository = CartRepository();
  SharingRepository sharingRepository = SharingRepository();
  BaseMetaInfo? info;

  ///all cart list
  List<UrlData> nowCartList = [];
  ///filtered cart list
  List<UrlData> filteredCartList = [];

  List<String> selectedCartIdList = [];
  List<UrlData> selectedCartItemList = [];



  updateNowList(List<UrlData> updateList) {
    nowCartList = updateList;
    update();
  }

  fetchDataList(int index, BaseMetaInfo? data) {
    safePrint('@@@=>fetchDataList');
    if (nowCartList[index].title == null || nowCartList[index].image == null) {
      UrlData updatedUrlData =
          UrlData(localId: nowCartList[index].localId, url: nowCartList[index].url, image: data?.image, title: data?.title, group: []);
      List<UrlData> newCartList = [];
      for (int i = 0; i < nowCartList.length; i++) {
        if (i == index) {
          newCartList.add(updatedUrlData);
        } else {
          newCartList.add(nowCartList[i]);
        }
      }

      updateNowList(newCartList);
      update();
    }
  }

  filterNowCartList(String id) {
    filteredCartList = [];
    if (id == 'all') {
      for (int i = 0; i < nowCartList.length; i++) {
        if(nowCartList[i].localId.substring(0,8) != "PollItem"){
          filteredCartList.insert(0, nowCartList[i]);
        }
      }
    }
    update();
  }

  cartItemSelect(String id){
    
    if(selectedCartIdList.contains(id)){
      selectedCartIdList.remove(id);
    }else{
      selectedCartIdList.add(id);
    }
    
    
    update();
    homeController.update();
  }

  cartItemSelectListClear(){
    selectedCartIdList = [];
    selectedCartItemList = [];
    update();
  }

  cartItemDelete() async {

    if(selectedCartIdList.isNotEmpty){
      for(int i=0; i<filteredCartList.length; i++){
        for(int j=0; j<selectedCartIdList.length; j++){
          if(filteredCartList[i].localId == selectedCartIdList[j]){
            selectedCartItemList.add(filteredCartList[i]);
            filteredCartList.removeAt(i);
          }
        }
      }
      cartRepository.deleteCartItem(selectedCartItemList);
      cartItemSelectListClear();
    }

    homeController.changeMode('main');
    update();

  }

  insertPollItem(){
    if(selectedCartIdList.isNotEmpty){
      for(int i=0; i<filteredCartList.length; i++){
        for(int j=0; j<selectedCartIdList.length; j++){
          if(filteredCartList[i].localId == selectedCartIdList[j]){
            selectedCartItemList.add(filteredCartList[i]);
          }
        }
      }
    }

    update();
  }

  showDeleteBottomSheet(){
    Get.bottomSheet(
        Container(
          height: 236, width: Get.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),color: Colors.white,
          ),


          child: Stack(alignment: Alignment.topCenter,

            children: [

            Positioned(
              top: 10,
              child: Container(width: 60, height: 6,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),),
            ),



            Positioned(
                top: 26,
                child: Text('삭제하기',style: CTextStyle.light20.copyWith(height: 40/20),)),

              Positioned(
                  top: 42, left: 24,
                  child: Text('${selectedCartIdList.length.toString()}개 선택됨',style: CTextStyle.light16.copyWith(height: 18/16,color: CColor.redCaution),)),


            Positioned(
                top: 96,
                child: Text('선택한 아이템을 삭제하시겠습니까?',style: CTextStyle.light16.copyWith(height: 20/16),textAlign: TextAlign.center,)),


            Positioned(
              bottom: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap:(){
                        Get.back();
                      },
                      child: Container(width: 130, height: 40,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(36)),
                          border: Border.all(width: 1, color: Colors.black),
                          color: Colors.white,
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(CIconPath.close,width: 32,),
                            const SizedBox(width: 6,),
                            Text('취소',style: CTextStyle.bold14.copyWith(color: Colors.black),)
                          ],),
                      ),
                    ),
                    const SizedBox(width: 50,),
                    GestureDetector(
                      onTap: () async {
                        safePrint('확인 보튼');
                        await cartItemDelete();
                        Get.back();
                      },
                      child: Container(width: 130, height: 40,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(36)),
                          border: Border.all(width: 1, color: Colors.black),
                          color: Colors.black,
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(CIconPath.delete,width: 32,),
                            const SizedBox(width: 6,),
                            Text('삭제',style: CTextStyle.bold14,)
                          ],),
                      ),
                    ),
                  ],
                ),
              ),
            )




          ],),


        )

    );
  }



}
