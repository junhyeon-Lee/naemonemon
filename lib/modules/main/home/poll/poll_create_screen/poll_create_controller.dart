import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shovving_pre/main.dart';

import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/poll/my_poll/my_poll_screen.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_repository.dart';

import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/sharing_function/sharing_function.dart';

class PollCreateController extends GetxController {

  PollRepository pollRepository = PollRepository();

  @override
  void onInit() {
    galleryScrollController = ScrollController()..addListener(getNextGallery);
    super.onInit();
  }
  late final ScrollController galleryScrollController;

  int galleySkip =0;
  bool isGalleyLoading = false;
  bool isOver = false;
  List<AssetEntity> images = [];
  getNextGallery() async {


    if (galleryScrollController.position.extentAfter < 100 && isGalleyLoading == false&&isOver==false) {
      safePrint('다음 갤러리');
      safePrint(galleySkip);
      isGalleyLoading = true;
      galleySkip += 1;
      update();

      List<AssetPathEntity> album = await PhotoManager.getAssetPathList(type: RequestType.image);
      List<AssetEntity> tempImages = await album[0].getAssetListPaged(page: galleySkip, size: 24);
      if(tempImages.isEmpty){
        isOver = true;
      }
      images+=tempImages;

      isGalleyLoading = false;
      update();
    }

  }



  bool isPollPublic = true;

  tapPollPublicL() {
    isPollPublic = true;
    update();
  }

  tapPollPublicR() {
    isPollPublic = false;
    update();
  }

  List<UrlData> pollItems = [];
  List<int> isSelected = [];
  List<UrlData> urlPollItem=[];

  setPollItems(List<UrlData> dataList) {
    for (int i = 0; i < dataList.length; i++) {
      pollItems.add(dataList[i]);
    }
    update();
  }

  selectImage(int index) {
    if (isSelected.contains(index)) {
      isSelected.remove(index);
    } else {
        isSelected.add(index);
    }
    update();
  }
  selectItemImage(int index, int count) {
    if (isSelected.contains(index)) {
      isSelected.remove(index);
    } else {
      if(count+isSelected.length !=4){
        isSelected.add(index);
      }

    }
    update();
  }

  selectImageClose() {
    isSelected = [];
    update();
  }

  TextEditingController pollComment = TextEditingController();
  TextEditingController urlPollItemController = TextEditingController();

  String itemImages = '';
  setItemImages(List<String> images){
    itemImages+=images.join(',');
    itemImages+=',';
  }

  List<List<String>> eachItemImage = [];
  setEachItemImage(){
    eachItemImage = [];


    for(int i=0; i<pollItems.length; i++){

      eachItemImage.add([]);
    }

    List<String> images = itemImages.split(',');

    for(int i=0; i<images.length; i++){



      if(images[i]!=''){
        String index = images[i].substring(0,1);
        String body = images[i].substring(1);
        eachItemImage[int.parse(index)].add(body);
      }

    }

    update();

  }

  deleteEachImage(int index, int itemIndex){
    String image = '$index${eachItemImage[index][itemIndex]}';
    eachItemImage[index].removeAt(itemIndex);
    List<String> images = itemImages.split(',');
    images.remove(image);
    itemImages = images.join(',');

    update();
  }


  createPoll() async {
    indicatorController.nowLoading();
    update();
    List<int> itemsId = [];

    for(int i=0; i<pollItems.length; i++){
      itemsId.insert(0,pollItems[i].id!);
    }


   await pollRepository.postPoll(itemsId, pollComment.text, isPollPublic, itemImages);
   Get.back();
   await pollController.setPollList();
   Get.to( const MyPollScreen(),transition:Transition.rightToLeft);
  }


  bool isTypingNow = false;
  int textLength = 0;

  UrlData? searchedData;

  void isTypingEnd(int preLength){
    Future.delayed(const Duration(seconds: 1),() async {
      if(preLength == textLength){

        SharingRepository sharingRepository = SharingRepository();
        UrlData localId = await sharingRepository.urlPollItem(urlPollItemController.text);

        if(urlPollItemController.text.isNotEmpty){
          searchedData = localId;

          update();
        }else{
          //텍스트 길이가 0라면 null로 변경해서 배경까지 없앤드아
          searchedData = null;
          update();
        }
      }
    });
  }

  Future<String?> registerUrlItem() async {
    SharingRepository sharingRepository = SharingRepository();
    if(searchedData!=null){
      UrlData urlData = await sharingRepository.registerUrlPollItem(searchedData!);
      return urlData.localId;
    }
    return null;

  }




}
