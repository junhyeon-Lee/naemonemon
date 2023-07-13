import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/modules/main/home/cart_screen/cart_controller.dart';
import 'package:shovving_pre/modules/main/home/cart_screen/cart_item.dart';
import 'package:shovving_pre/modules/main/home/group_screen/group_controller.dart';
import 'package:shovving_pre/modules/main/home/home_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';

Widget cartScreen(){
  final homeController = Get.put(HomeController());
  final groupController = Get.put(GroupController());
  return GetBuilder<CartController>(
    builder: (cartController) {
      return
          GestureDetector(
            onPanUpdate: (details) {
              if(cartController.deleteMode==false){
                if (details.delta.dx < 0) {

                  if(groupController.designateMode){
                    groupController.closeDesignateMode();
                  }
                  homeController.swipeRight();
                }
                if (details.delta.dx > 0) {
                  homeController.swipeLeft();
                }
              }

            },
            child: SizedBox(width: Get.width-80,
              child:
              cartController.filteredCartList.isEmpty?
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CartListFirstItem()
                ],
              ):
              Column(
                children: [
                  ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: ((cartController.filteredCartList.length+1)/2).ceil(),
                          itemBuilder: (BuildContext ctx, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child:
                              cartController.filteredCartList.isEmpty? CartItem(index: index):
                              index==0? CartItem(sData: cartController.filteredCartList[index],index: index, fData: cartController.filteredCartList[index],):
                              cartController.filteredCartList.length>index*2?
                              CartItem(fData: cartController.filteredCartList[index*2-1],sData: cartController.filteredCartList[index*2],index: index,):
                              CartItem(fData: cartController.filteredCartList[index*2-1],index: index,),
                            );
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

    },
  );
}




class CartListFirstItem extends StatelessWidget {
  const CartListFirstItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupController = Get.put(GroupController());
    return GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
              child:  groupController.groupMode?
              groupController.designateMode?
              GestureDetector(
                onTap: (){
                  groupController.closeDesignateMode();
                },
                child: Container(
                  width: (Get.width-90)/2,
                  height:(Get.width-90)/2,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: Colors.white,
                  ),

                  child: Center(child: Text('Select the\nitems to\nadd group',style: CTextStyle.bold16,textAlign: TextAlign.center,)),
                ),
              ):
              GestureDetector(
                onTap: (){
                  groupController.enterDesignateMode();
                  cartController.filterNowCartList('all');
                },
                child: Container(
                  width: (Get.width-90)/2,
                  height:(Get.width-90)/2,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: Colors.white,
                  ),

                  child: Center(child: Text('Do you want\nadd group?',style: CTextStyle.bold16,textAlign: TextAlign.center,)),
                ),
              ):
              InkWell(
                onTap: () {

                },
                child: Container(
                  width: (Get.width-90)/2,
                  height:(Get.width-90)/2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(CIconPath.addIcon),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
          );
        });
  }
}
