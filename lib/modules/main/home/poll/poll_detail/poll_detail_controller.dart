import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/modules/main/home/cart/cart_repository.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_repository.dart';
import 'package:shovving_pre/modules/main/home/poll/social_activity/social_activity_repository.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/local_repository/local_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:flutter/material.dart';
import 'package:shovving_pre/util/sundry_function/sharing_function/sharing_function.dart';
import 'package:shovving_pre/util/sundry_function/url_previewer/any_link_preview.dart';
import 'package:shovving_pre/util/sundry_widget/toast/toast.dart';
import 'package:shovving_pre/util/sundry_widget/web_view/web_view_screen.dart';

import '../../../../../models/local_model/poll/poll.dart';

class PollDetailController extends GetxController {


  int commentSheetState = 0;
  bool commentExtraSheetState = false;
  bool commentExtraRiveState = false;
  bool likeRiveState = false;

  changeCommentSheetState(int index) {
    if(index!=2){
      commentExtraSheetState = false;
    }
    commentSheetState = index;
    update();
  }
  openExtraSheet(){
    if(commentExtraSheetState){
      commentExtraSheetState= false;
      update();
    }else{
      commentExtraSheetState = true;
      changeCommentSheetState(2);
    }


  }


  ///댓글 활성화에 따른 페이지뷰 컨트롤
  int selectedItemIndex = 0;

  selectItem(int index) {
    selectedItemIndex = index;
    update();
  }

  secondItem(int itemsLength) {
    int secondIndex = (selectedItemIndex + 1) % itemsLength;
    return secondIndex;
  }

  thirdItem(int itemsLength) {
    int thirdItem = (selectedItemIndex + 2) % itemsLength;
    return thirdItem;
  }



  List<String> alphabetList = List.generate(26, (index) {
    String alphabet = String.fromCharCode(65 + index);
    return alphabet;
  });

  PollRepository pollRepository = PollRepository();

  deletePoll(Poll pollData) async {
   await pollRepository.deletePoll(pollData.id);
   update();
   pollController.update();
   Get.back();

  }
  joinSocialPoll(int id, List<int> joinData,  int pollLocation, List<int> beforeJoin) async {
    // indicatorController.nowLoading();
    //update();

    List<int> updateJoinData = [];
    if(beforeJoin.length == joinData.length){
      for(int i=0; i<joinData.length; i++){
        if(joinData[i] == 1){
          updateJoinData.add(1);
        }else{
          updateJoinData.add(beforeJoin[i]);
        }
      }
    }else{
      updateJoinData = joinData;
    }



   await pollRepository.socialPollJoin(id, joinData,);
   ///투표는 잘 되니까 이제 그거 패치해서 다시 업데이트하기
    ///폴바이로 싱글 패치해서 그 위치 인덱스에 데이터 꽂아줍시다.
    ///데이터는 피드 리스트에 다이렉트로 꽂아보자 일단.
    Poll? patchedPoll = await pollRepository.getPollById(id);

    if(patchedPoll!=null){
      feedController.feedList[pollLocation] = feedController.feedList[pollLocation].copyWith(joins: updateJoinData, numberOfVotes: patchedPoll.numberOfVotes);
      feedController.update();
    }

    indicatorController.completeLoading();
    update();
  }


  showDeleteBottomSheet(Poll pollData){
    Get.bottomSheet(

        Container(
      height: 236, width: Get.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),color: Colors.white,
          ),


          child: Column(children: [
            const SizedBox(height: 6,),
            Container(width: 60, height: 6,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),),

            const SizedBox(height: 10,),

            Text('삭제하기',style: CTextStyle.light20.copyWith(height: 40/20),),
            const SizedBox(height: 20,),
            
            Text('정말로 투표를 삭제하시겠습니까?\n삭제된 투표의 모든 정보는 사라집니다.',style: CTextStyle.light16.copyWith(height: 20/16),textAlign: TextAlign.center,),
            const SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  GestureDetector(
                    onTap: () async {

                      Get.back();
                      ///한칸 뒤로 그리고 인디케이터 그리고 그 뭐냐 완료되면 나머지 오케이 ㄱ

                      indicatorController.nowLoading();
                      update();

                      await deletePoll(pollData);

                      update();
                      showDefaultMiddleToast('투표가 정상적으로 삭제 되었습니다.');



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
            )
            
            
            
            
          ],),


    )

    );
  }



  bool isExpanded = false;
  pollCommentClose(){
    isExpanded = false;
    update();
  }
  pollCommentExpanded(){
    isExpanded = true;
    update();
  }


  PageController imageListPageController = PageController();



  postComment(int id, String comment, List<int> joins, index, type) async {
    SocialActivityRepository socialActivityRepository = SocialActivityRepository();

    await socialActivityRepository.sampleCommentPost(id, joins.join(','), comment);

    ///보내고 업데이트 해야죠?
    Poll? patchedPoll = await pollRepository.getPollById(id);
    if(patchedPoll!=null){

      if(type==1){
        safePrint('내 투표 댓글 없데이트');
        pollController.myPollList[index] = pollController.myPollList[index].copyWith(comments: patchedPoll.comments);
        pollController.update();
      }
      else if(type==2){
        safePrint('피드 댓글 없데이트');
        feedController.feedList[index] = feedController.feedList[index].copyWith(comments: patchedPoll.comments);
        feedController.update();
      }
      else if(type==3){
        safePrint('내 참여 투표 댓글 없데이트');
        pollController.joinedPollList[index] = pollController.joinedPollList[index].copyWith(comments: patchedPoll.comments);
        pollController.update();
      }



    }
    update();



  }




  /// pollDetail에서 나갈 때 해야하는 처리
  pollDetailOut(int type){
    /// type 1==general 2== vs 3==yn
    isExpanded=false;


    isAddCartMode = false;
    if(type==1){
      imageListPageController.jumpToPage(0);
    }

    changeCommentSheetState(0);

  }



  addCartItem(String url) async {
    LocalRepository localRepository = LocalRepository();
    List<UrlData> nowCartList = cartController.nowCartList;

    BaseMetaInfo? info;
    info = await getUrlData(url);

    UrlData? tempData = verificationThumbnailImage(info, 'UrlData temp ${DateTime.now()}',url);

    nowCartList.add(tempData);
    CartRepository cartRepository = CartRepository();
    cartRepository.addNewCart(tempData);
    localRepository.updateMyCartList(nowCartList);
    cartController.filterNowCartList('all');

    showMiddleToastWithImage('저장되었습니다' , tempData.image??'');
    update();
  }
  alreadyInMyCart(){
    showDefaultMiddleToast('이미 저장되어있는 정보입니다.');
  }

  bool isAddCartMode = false;

  openAddCartMode(){
    isAddCartMode = true;
    update();
  }

  closeAddCartMode(){
    isAddCartMode = false;
    update();
  }


  ///좋아요 타이머



  int nowCount = 0;
  // int nowCommentCount =0;

  void likeStateLocalAction(bool like, int likeLength, int id, int index,int dataType, int type){
    nowCount++;

    if(dataType ==1){
      if(like){
        pollController.myPollList[index] = pollController.myPollList[index].copyWith(like: false, likeLength: likeLength-1);
        pollController.update();
      }else{
        pollController.myPollList[index] = pollController.myPollList[index].copyWith(like: true, likeLength: likeLength+1);
        pollController.update();
      }
    }
    else if(dataType ==2){
      if(like){
        feedController.feedList[index] = feedController.feedList[index].copyWith(like: false, likeLength: likeLength-1);
        feedController.update();
      }else{
        feedController.feedList[index] = feedController.feedList[index].copyWith(like: true, likeLength: likeLength+1);
        feedController.update();
      }
    }
    else{
      if(like){
        pollController.joinedPollList[index] = pollController.joinedPollList[index].copyWith(like: false, likeLength: likeLength-1);
        pollController.update();
      }else{
        pollController.joinedPollList[index] = pollController.joinedPollList[index].copyWith(like: true, likeLength: likeLength+1);
        pollController.update();
      }
    }

    likeTimer(nowCount, id, index, type);
    update();
  }

  likeTimer(int likeCount, int id, int index, int type){

    Future.delayed(const Duration(seconds: 2),() async {

      if(likeCount ==nowCount ){
        SocialActivityRepository socialRepository = SocialActivityRepository();
        await socialRepository.likePost(id, type);
      }

    });

  }

  commentLike(int id) async {
    SocialActivityRepository socialRepository = SocialActivityRepository();
    await socialRepository.likePost(id, 1);
  }








TextEditingController commentTextController = TextEditingController();





  seeDetailUrl(String url){
    safePrint('폴 디테일의 시 디테일');
    Get.to(WebViewScreen(firstUrl: url));
    update();
  }






  ///report
  bool pollReportState = false;
  int reportReason = -1;
  TextEditingController reportReasonController = TextEditingController();

  reportComment(int reportedUserId, int reportedItemId, int type) async {
    SocialActivityRepository socialActivityRepository = SocialActivityRepository();
    if(reportReason!=-1){
      await socialActivityRepository.reportPost(type, reportedUserId, reportedItemId, reportReason, reportReasonController.text,);
    }
  }



}
