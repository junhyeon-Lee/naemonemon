import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/models/local_model/group/group.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/cart_screen/cart_controller.dart';
import 'package:shovving_pre/modules/main/home/group_screen/group_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/local_repository/local_repository.dart';
import 'package:shovving_pre/util/safe_print.dart';

class CartItemGroup extends StatefulWidget {
  const CartItemGroup({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<CartItemGroup> createState() => _CartItemGroupState();
}

class _CartItemGroupState extends State<CartItemGroup> {

  final groupWidth = (Get.width-90)/6;
  final itemWidth = (Get.width-90)/2;
  final centerPosition = (Get.width-90)/4-(Get.width-90)/12;

  List<int> color = [0,0,0,0];
  List<int> icon = [-1,-1,-1,-1];


  @override
  Widget build(BuildContext context) {
    List<String> itemGroupList = Get.find<CartController>().nowCartList[widget.index].group;
    List<UrlData> nowCartList = Get.find<CartController>().nowCartList;

    ///일단 첫번째 이 아이디의 그룹이 내 그룹에 존재하는지를 먼저 체크 해야 합니다.
    ///만약 이 아이디가 내 그룹리스트에 존재하지 않는다면 제거해야 합니다. 가리는게 아니라 제거


    ///얘는 이제 모든 것이 정상적인 상황이라면 이렇게 하면 된다는 함수
    for(int i=0; i<4; i++){
      if(i<itemGroupList.length){
        Group? groupData = Get.find<GroupController>().getGroupInfo(itemGroupList[i]);

        if(groupData==null){
          icon[i] = -1;
        }else{
          color[i] = groupData.groupColorId;
          icon[i] = groupData.groupIconId;
        }


      }else{
        //여기는 리스트 외의 반복 즉 위에서만 처리하면 된다.
        icon[i] = -1;
      }
    }







    return SizedBox(
      width: itemWidth,
      height:itemWidth,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            left: itemGroupList.length>1?20:centerPosition, top: itemGroupList.length<3?centerPosition:20,
            child: AnimatedOpacity(
              opacity: icon[0]==-1?0:1,
              duration: const Duration(milliseconds: 500),
              child: CommonContainer(
                width: groupWidth, height: groupWidth, radius: 100, containerColor: Colors.white,
                child: Center(
                  child: CommonContainer(
                    width: groupWidth-4, height: groupWidth-4, containerColor: GColor.gColorList[color[0]][0], radius: 100,
                    child: Visibility(
                      visible: icon[0]!=-1,
                      child: Center(
                        child: SvgPicture.asset(GIconPath.gIconList[icon[0]+1]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            right: 20, top: itemGroupList.length<3?centerPosition:20,
            child: AnimatedOpacity(
              opacity: icon[1]==-1?0:1,
              duration: const Duration(milliseconds: 500),
              child: CommonContainer(
                width: groupWidth, height: groupWidth, radius: 100, containerColor: Colors.white,
                child: Center(
                  child: CommonContainer(
                    width: groupWidth-4, height: groupWidth-4, containerColor: GColor.gColorList[color[1]][0], radius: 100,
                    child: Visibility(
                      visible: icon[1]!=-1,
                      child: Center(
                        child: SvgPicture.asset(GIconPath.gIconList[icon[1]+1]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            left: itemGroupList.length<4?centerPosition:20, bottom: 20,
            child: AnimatedOpacity(
              opacity: icon[2]==-1?0:1,
              duration: const Duration(milliseconds: 500),
              child: CommonContainer(
                width: groupWidth, height: groupWidth, radius: 100, containerColor: Colors.white,
                child: Center(
                  child: CommonContainer(
                    width: groupWidth-4, height: groupWidth-4, containerColor: GColor.gColorList[color[2]][0], radius: 100,
                    child: Visibility(
                      visible: icon[2]!=-1,
                      child: Center(
                        child: SvgPicture.asset(GIconPath.gIconList[icon[2]+1]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            right: 20, bottom: 20,
            child: AnimatedOpacity(
              opacity: icon[3]==-1?0:1,
              duration: const Duration(milliseconds: 500),
              child: CommonContainer(
                width: groupWidth, height: groupWidth, radius: 100, containerColor: Colors.white,
                child: Center(
                  child: CommonContainer(
                    width: groupWidth-4, height: groupWidth-4, containerColor: GColor.gColorList[color[3]][0], radius: 100,
                    child: Visibility(
                      visible: icon[3]!=-1,
                      child: Center(
                        child: SvgPicture.asset(GIconPath.gIconList[icon[3]+1]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
