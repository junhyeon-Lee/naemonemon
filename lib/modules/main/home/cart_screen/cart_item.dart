import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/cart_screen/cart_controller.dart';
import 'package:shovving_pre/modules/main/home/group_screen/group_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';

import 'cart_item_group.dart';
import 'cart_screen.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, this.fData, this.sData, required this.index,}) : super(key: key);

  final UrlData? fData;
  final UrlData? sData;
  final int index;

  @override
  Widget build(BuildContext context) {
    final groupController = Get.put(GroupController());

    return GetBuilder<CartController>(
    builder: (cartController) {

      return  Stack(
        children: [
          ///이 위젯은 항상 존재 해야만 합니다. 최상단의 위치에서
          if(index==0)
            const CartListFirstItem(),


          ///이 위젯은 좌측의 아이템 위젯입니다. 하지만 stack위치떄문에 이 위젯은 해당 항목이 활성화되면 위쪽에 동일한 위젯이 오버레이 됩니다.
          if(index!=0&&fData!=null)
            Visibility(

            visible: cartController.cartItemState[index*2-1]!=1&&index!=0,
            child:
            InkWell(
              onTap: () {
                if(cartController.deleteMode){
                  cartController.addDelete(index*2-1, fData!.id);
                }else if(groupController.designateMode){
                  cartController.cartItemAddGroup(index*2-1);
                }else{
                  cartController.cartItemActive(index * 2 - 1, true);
                }

              },
              child: Stack(alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: (Get.width-90)/2,
                    height:(Get.width-90)/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(fData!.image!),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 6,
                      child: SizedBox(width: (Get.width-90)/2-20,
                        child: RichText(
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: fData!.title,
                                style: CTextStyle.regular10
                            ),
                            overflow: TextOverflow.ellipsis),
                      )),

                  IgnorePointer(
                    ignoring: groupController.designateMode == false,
                    child: AnimatedOpacity(
                        opacity: groupController.designateMode?1:0,
                        duration: const Duration(milliseconds: 500),
                        child: CartItemGroup(index: index*2-1,)),
                  ),
                  if(cartController.selectedCartItemState[index*2-1])
                    Positioned(bottom: (Get.width-90)/4-25,
                      child: CommonContainer(
                        width: 50, height: 50, radius: 100, containerColor: Colors.white,
                        child: Center(
                          child: CommonContainer(
                            width: 46, height: 46, containerColor: Colors.black, radius: 100,
                            child: Center(child: SvgPicture.asset(CIconPath.delete,width: 24,)),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),

          ///이 위젯은 오른쪽 아이템의 컨트롤러 입니다. 오른쪽 아이템이 활성화 되면 나타납니다.
          if(sData!=null)
          AnimatedPositioned(
              right: cartController.cartItemState[index*2]==2?(Get.width-90)/2+10:0,
              duration: const Duration(milliseconds: 500),
              child: IgnorePointer(
                ignoring: cartController.cartItemState[index*2]!=2,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: cartController.cartItemState[index*2]==2?1:0,
                  child: CommonContainer(
                    width: (Get.width-90)/2,
                    height:(Get.width-90)/2,
                    containerColor: Colors.white.withOpacity(0.8),
                    radius: 6,
                    child: Center(
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){


                                cartController.openDeleteMode();
                                cartController.updateItemState();
                                cartController.selectedCartListSelect(index*2, sData!.id);





                            },
                            child: CommonContainer(
                              width: ((Get.width-90)/2-30)/2, height: ((Get.width-90)/2-30)/2, radius: 6,
                              containerColor: CColor.deepBlueBlack,
                              child: Center(child: SvgPicture.asset(CIconPath.delete)),
                            ),
                          ),
                          const SizedBox(width: 4,),
                          CommonContainer(
                            width: ((Get.width-90)/2-30)/2, height: ((Get.width-90)/2-30)/2, radius: 6,
                            containerColor: CColor.blueGreen,
                            child: Center(child: SvgPicture.asset(CIconPath.poll)),
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
              )


          ),

          ///오른쪽 아이템 입니다.
          if(sData!=null)
            Positioned(right: 0,
              child: Container(
                child:

                InkWell(
                  onTap: () {
                    if(cartController.deleteMode){
                    cartController.addDelete(index*2, sData!.id);
                    }else if(groupController.designateMode){
                    cartController.cartItemAddGroup(index*2);
                    }else{
                      cartController.cartItemActive(index*2, false);
                    }
                  },
                  child: Stack(alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: (Get.width-90)/2,
                        height:(Get.width-90)/2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(sData!.image!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 6,
                          child: SizedBox(width: (Get.width-90)/2-20,
                            child: RichText(
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: sData!.title,
                                    style: CTextStyle.regular10
                                ),
                                overflow: TextOverflow.ellipsis),
                          )),


                      ///여기에 그룹 이미지를 넣어 봅시다.
                      IgnorePointer(
                        ignoring: groupController.designateMode == false,
                        child: AnimatedOpacity(
                            opacity: groupController.designateMode?1:0,
                            duration: const Duration(milliseconds: 500),
                            child: CartItemGroup(index: index*2,)),
                      ),





                      if(cartController.selectedCartItemState[index*2])
                        Positioned(bottom: (Get.width-90)/4-25,
                          child: CommonContainer(
                            width: 50, height: 50, radius: 100, containerColor: Colors.white,
                            child: Center(
                              child: CommonContainer(
                                width: 46, height: 46, containerColor: Colors.black, radius: 100,
                                child: Center(child: SvgPicture.asset(CIconPath.delete,width: 24,)),
                              ),
                            ),
                          ),
                        )

                    ],
                  ),
                ),
              ),
            ),





          ///왼쪽 아이템의 컨트롤러 입니다.
          if(index!=0&&fData!=null)
            AnimatedPositioned(
              left: cartController.cartItemState[index*2-1]==1?(Get.width-90)/2+10:0,
              duration: const Duration(milliseconds: 500),
              child: IgnorePointer(
                ignoring: cartController.cartItemState[index*2-1]!=1,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: cartController.cartItemState[index*2-1]==1?1:0,
                  child: GestureDetector(
                    onTap: (){
                      cartController.cartItemActive(index*2-1, true);
                      cartController.selectedCartListSelect(index*2-1, fData!.id);
                    },
                    child: CommonContainer(
                      width: (Get.width-90)/2,
                      height:(Get.width-90)/2,
                      containerColor: Colors.white.withOpacity(0.8),
                      radius: 6,
                      child: Center(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){

                                  if(cartController.cartItemState[index*2-1]==1){
                                    cartController.openDeleteMode();
                                    cartController.updateItemState();
                                    cartController.selectedCartListSelect(index*2-1, fData!.id);
                                  }else{
                                    cartController.cartItemActive(index*2-1, true);
                                  }


                              },
                              child: CommonContainer(
                                width: ((Get.width-90)/2-30)/2, height: ((Get.width-90)/2-30)/2, radius: 6,
                                containerColor: CColor.deepBlueBlack,
                                child: Center(child: SvgPicture.asset(CIconPath.delete)),
                              ),
                            ),
                            const SizedBox(width: 4,),
                            CommonContainer(
                              width: ((Get.width-90)/2-30)/2, height: ((Get.width-90)/2-30)/2, radius: 6,
                              containerColor: CColor.blueGreen,
                              child: Center(child: SvgPicture.asset(CIconPath.poll)),
                            ),
                          ],
                        ),
                      ),

                    ),
                  ),
                ),
              )


          ),

          ///오버레이되는 왼쪽 아이템입니다.
          if(index!=0&&fData!=null)
            Visibility(
            visible: cartController.cartItemState[index*2-1]==1,
            child:
            // fData!.image==null?
            // AnyLinkPreview(
            //   index: index*2-1,
            //   removeElevation:true,
            //   link: fData!.url,
            //   displayDirection: UIDirection.uiDirectionHorizontal,
            //   backgroundColor: Colors.grey[300],
            //   errorWidget: Container(
            //     color: Colors.grey[300],
            //     child: const Text('에러!'),
            //   ),
            //   errorImage: 'https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg',
            // ):
            InkWell(
              onTap: () {
                if(cartController.deleteMode){
                  cartController.addDelete(index*2-1, fData!.id);
                }else if(groupController.designateMode){
                  cartController.cartItemAddGroup(index*2-1);
                }else{
                  cartController.cartItemActive(index*2-1, true);
                }
              },
              child: Stack(alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: (Get.width-90)/2,
                    height:(Get.width-90)/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(fData!.image!),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 6,
                      child: SizedBox(width: (Get.width-90)/2-20,
                        child: RichText(
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: fData!.title,
                                style: CTextStyle.regular10
                            ),
                            overflow: TextOverflow.ellipsis),
                      )),

                  IgnorePointer(
                    ignoring: groupController.designateMode == false,
                    child: AnimatedOpacity(
                        opacity: groupController.designateMode?1:0,
                        duration: const Duration(milliseconds: 500),
                        child: CartItemGroup(index: index*2-1,)),
                  ),

                  if(cartController.selectedCartItemState[index*2-1])
                    Positioned(bottom: (Get.width-90)/4-25,
                      child: CommonContainer(
                        width: 50, height: 50, radius: 100, containerColor: Colors.white,
                        child: Center(
                          child: CommonContainer(
                            width: 46, height: 46, containerColor: Colors.black, radius: 100,
                            child: Center(child: SvgPicture.asset(CIconPath.delete,width: 24,)),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}










// sData!.image==null?
// AnyLinkPreview(
//   index: index*2,
//   removeElevation:true,
//   link: sData!.url,
//   displayDirection: UIDirection.uiDirectionHorizontal,
//   backgroundColor: Colors.grey[300],
//   errorWidget: Container(
//     color: Colors.grey[300],
//     child: const Text('에러!'),
//   ),
//   errorImage: 'https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg',
// ):