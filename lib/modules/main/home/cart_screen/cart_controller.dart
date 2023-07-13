import 'package:get/get.dart';
import 'package:shovving_pre/models/local_model/group/group.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/group_screen/group_controller.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/util/local_repository/local_repository.dart';
import 'package:shovving_pre/util/safe_print.dart';
import 'package:shovving_pre/util/sharing_function/sharing_function.dart';
import 'package:shovving_pre/util/url_previewer/src/parser/base.dart';

class CartController extends GetxController{
  @override
  Future<void> onInit() async {
    super.onInit();
    await localRepository.findMyCartList();
    sharingRepository.getSharedUrl(nowCartList);
    filteredCartList = nowCartList;
    update();
  }

  LocalRepository localRepository = LocalRepository();
  SharingRepository sharingRepository = SharingRepository();

  BaseMetaInfo? info;
  ///all cart list
  List<UrlData> nowCartList = [];
  ///filtered cart list
  List<UrlData> filteredCartList = [];
  List<int> cartItemState =[];
  List<bool> selectedCartItemState =[];
  List<List<Group>> assignedGroupList = [];
  bool deleteMode = false; //0=default, 1=deleteMode
  List<String> selectedIdList = [];


  updateNowList(List<UrlData> updateList){
    //현재 리스트를 업데이트 하는 함수, 같이 딸려있는 list 두개도 같이 초기화 해줘야한다.
    nowCartList =updateList;
    updateItemState();
    updateSelectedItemState();
    update();
  }
  fetchDataList(int index, BaseMetaInfo? data){
    safePrint('@@@=>fetchDataList');
    if(nowCartList[index].title==null||nowCartList[index].image==null){
      UrlData updatedUrlData = UrlData(
          id: nowCartList[index].id,
          url: nowCartList[index].url,
          image: data?.image,
          title: data?.title,
        group: []
      );
      List<UrlData> newCartList = [];
      for(int i=0; i<nowCartList.length; i++){
        if(i==index){
          newCartList.add(updatedUrlData);
        }else{
          newCartList.add(nowCartList[i]);
        }
      }

      updateNowList(newCartList);
      update();
    }
  }
  cartItemActive(int index, bool left){
    if(cartItemState[index]==1||cartItemState[index]==2){
      cartItemState = List<int>.generate(cartItemState.length, (i) => 0);
      update();
    }else{
      cartItemState = List<int>.generate(cartItemState.length, (i) => i == index ? left?1:2 : 0);
      update();
    }
    deleteMode =false;
    Get.find<HomeController>().updateHomeController();
  }
  updateItemState(){
    safePrint('@@@=>update item State');
    cartItemState = List<int>.generate(nowCartList.length, (i) => 0);
  }
  updateSelectedItemState(){
    safePrint('@@@=>update selected itemState');
    selectedCartItemState = List<bool>.generate(nowCartList.length, (i) => false);
    update();
  }
  openDeleteMode(){

    deleteMode = true;
    Get.find<HomeController>().updateHomeController();
    update();
  }
  closeDeleteMode(){
    deleteMode = false;
    Get.find<HomeController>().updateHomeController();
    update();
  }
  selectedCartListSelect(int index, String id){
    if(index ==-1){
      updateSelectedItemState();
      selectedIdList = [];
    }else{
      selectedCartItemState = List<bool>.generate(cartItemState.length, (i) => i==index?true:false);
      selectedIdList.add(id);


    }
    update();
  }
  addDelete(int index, String id){
    selectedCartItemState[index]? selectedCartItemState[index]=false:selectedCartItemState[index] = true;
    ///아이디가 있다면 뺴고 없으면 넣어야지
    if(selectedIdList.contains(id)){
      selectedIdList.remove(id);
    }else{
      selectedIdList.add(id);
    }

    update();
  }
  cartListDelete(){
    safePrint('지우기 함수');
    localRepository.deleteCartList(nowCartList,selectedCartItemState, selectedIdList);
    deleteMode =false;
    Get.find<HomeController>().updateHomeController();
    update();
  }
  cartItemAddGroup(int index){

    String groupData = Get.find<GroupController>().groupList[Get.find<GroupController>().selectGroupIndex-1].groupId;

    List<String> newGroupList = [];
    bool existGroup = false;
    bool isAction = false;
    for(int i=0; i<nowCartList[index].group.length; i++){
      if(groupData == nowCartList[index].group[i]){
        /// 돌리다 보니 이 그룹이 이미 존재하네?
        existGroup = true;
        isAction = true;
        }else{
        ///계속 정상적으로 돌리는중
        existGroup = false;
        }

      ///해당되지 않는 상황이라면 쭉 add하면 됨
      if(existGroup){

      }else{
        newGroupList.add(nowCartList[index].group[i]);
      }
    }
    ///액션이 아무것도 없었다면 즉 중복되지 않았었다면
    if(isAction==false){
      newGroupList.add(groupData);
    }

    UrlData newUrlData = nowCartList[index].copyWith(group: newGroupList);

    ///여기까지가 새로운 그룹 리스트 만들기 이제 이걸 인덱스에 해당하틑 cart리스트에 업데이트


    List<UrlData> newCartList = [];
    for(int i=0; i<nowCartList.length; i++){
      if(i==index){
        newCartList.add(newUrlData);
      }else{
        newCartList.add(nowCartList[i]);
      }
    }

    updateNowList(newCartList);
    localRepository.updateMyCartList(newCartList);
    safePrint(nowCartList);
  }


  filterNowCartList(String id){
    safePrint(nowCartList.length);
    ///아이디를 받아서 필터링 합니다.
    ///디폴트 상태의 필터링이 필요합니다. 이는 all 아이템을 tab하는 순간이 좋겠군요.
    filteredCartList = [];

    if(id == 'all'){
      filteredCartList = nowCartList;
      safePrint(filteredCartList.length);

    }else{
      for(int i=0; i<nowCartList.length; i++){

        bool isContain = false;
        if(nowCartList[i].group.contains(id)){isContain =true;}

        if(isContain){
          filteredCartList.add(nowCartList[i]);
        }

      }
      safePrint(filteredCartList.length);
    }
    update();
  }




}