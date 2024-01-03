import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

class ItemImageViewScreen extends StatefulWidget {
  const ItemImageViewScreen({Key? key, required this.imageList, required this.selectedIndex, required this.imageListLength, required this.splitPoint}) : super(key: key);

  final List<List<String>> imageList;
  final int selectedIndex;
  final int imageListLength;
  final List<int> splitPoint;

  @override
  State<ItemImageViewScreen> createState() => _ItemImageViewScreenState();
}

class _ItemImageViewScreenState extends State<ItemImageViewScreen> {
  late PageController pageController;
  late ScrollController scrollController;
  late int selectedIndex;
  bool navigatorShow = true;


  int getPullIndex (int index){

    int tempIndex =0;

    for(int i=0; i<index; i++){

      tempIndex+=widget.imageList[i].length;


    }


    return tempIndex;
  }

  @override
  void initState() {

    Future.delayed(const Duration(seconds: 1),(){
      navigatorShow=false;
    });
    selectedIndex = widget.selectedIndex;
    pageController = PageController(initialPage: getPullIndex(selectedIndex));
    scrollController = ScrollController(initialScrollOffset:(98.0)*(selectedIndex) );

    super.initState();
  }

  @override

  Widget build(BuildContext context) {

    List<String> alphabetList = List.generate(26, (index) {
      String alphabet = String.fromCharCode(65 + index);
      return alphabet;
    });

    List<int> itemAndIndex (int index){
     List<int> tempData = [];
     int itemNumber = 0 ;
     int imageNumber = index;

     int splitAdd =0;

     for(int i=0; i<widget.splitPoint.length; i++){
       splitAdd+=widget.splitPoint[i];
       if(index+1>splitAdd){
         itemNumber++;
         imageNumber-=widget.splitPoint[i];
       }
     }
     tempData.add(itemNumber);
     tempData.add(imageNumber);

     return tempData;
    }







    return  Scaffold(
      body: Stack(alignment: Alignment.center,
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            color: Colors.black,
          ),
          //뒤로가기



          ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: PageView.builder(
              onPageChanged: (page){
                selectedIndex = itemAndIndex(page)[0];
                scrollController.jumpTo((98.0)*(selectedIndex));
                navigatorShow=true;
                setState(() {

                });
                Future.delayed(const Duration(seconds: 1),(){
                  navigatorShow=false;
                  setState(() {

                  });
                });
              },
              controller:  pageController,
              itemCount: widget.imageListLength,
              itemBuilder: (BuildContext context, int index) {


                  return CachedNetworkImage(
                    imageUrl: widget.imageList[itemAndIndex(index)[0]][itemAndIndex(index)[1]],
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => Container(
                      color: CColor.gray.withOpacity(0.3),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  );





              },
            ),
          ),
          Positioned(
            bottom: 185,
            child: Container(
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: Colors.black.withOpacity(0.3),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4,4,4,4,),
                child: SizedBox(height: 12, width: 12.0*(widget.imageList.length)+4*(widget.imageList.length-1),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imageList.length,
                    itemBuilder: (BuildContext context, int index){
                      if(selectedIndex == index){
                        return whiteCircle(true);
                      }else{
                        return whiteCircle(false);
                      }

                    }, separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 4);
                  },),
                ),
              ),













            ),
          ),
          Positioned(
            bottom: 40,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: navigatorShow?1:0,
              child: SizedBox(
                  width: 88,
                  height: 126,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        CIconPath.pollDetailBase02,
                        fit: BoxFit.fitWidth,
                        color: Colors.white,
                      ),
                      Positioned(
                          top: 6,
                          child: SvgPicture.asset(
                            CIconPath.pollDetailBase03,
                          )),

                    ],
                  )),
            ),
          ),
          Positioned(        bottom: 40-5,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: navigatorShow?1:0,
              child: Container(
                decoration:  const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4,4,4,4,),
                  child: SizedBox(height: 126, width: Get.width,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.imageList.length,
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: (){
                            selectedIndex = index;
                            pageController.animateToPage(index, duration: const Duration(milliseconds: 100), curve: Curves.ease);
                            scrollController.jumpTo((98.0)*(selectedIndex));

                          },
                          child: Padding(
                            padding:
                            index==0? EdgeInsets.only(left:(Get.width-88)/2):
                            index==widget.imageList.length-1?EdgeInsets.only(right:(Get.width-88)/2+10):

                            EdgeInsets.zero,
                            child: Column(mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    width: 88,
                                    height: 108,
                                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                                    child: Center(
                                      child: SizedBox(
                                        width: 80,
                                        height: 100,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 80,
                                                height: 80,
                                                child: CachedNetworkImage(
                                                  imageUrl:widget.imageList[index][0],
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => Container(
                                                    color: CColor.gray.withOpacity(0.3),
                                                  ),
                                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                                ),
                                              ),
                                              Container(
                                                width: 80,
                                                height: 20,
                                                color: index==selectedIndex?const Color(0xffF8A940):CColor.brightGray,
                                                child: Center(
                                                  child: Text(
                                                    //'B',
                                                    alphabetList[index],
                                                    style: CTextStyle.heavy12,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 10);
                    },),
                  ),
                ),













              ),
            ),
          ),




          Positioned(
              top: 59.h,
              left: 25.w,
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: SvgPicture.asset(
                  CIconPath.back26p,
                  color: Colors.white,
                  width: 26,
                ),
              )),









          //메뉴 바
        ],
      ),
    );
  }

  Widget whiteCircle(bool isSelected){
    return Stack(
      children: [
        Container(
          width:  12, height: 12,
          decoration:  BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(width: 2, color: Colors.white),
              color: isSelected?Colors.transparent:Colors.white
          ),
          // child:  Center(
          //   child: Container(
          //     width:  8, height: 8,
          //     decoration: BoxDecoration(
          //         borderRadius: const BorderRadius.all(Radius.circular(12)),
          //         color: isSelected?Colors.white:Colors.black
          //     ),
          //   ),
          // ),
        ),

      ],
    );
  }
}