import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/modules/main/home/poll/poll_detail/poll_detail_controller.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

import '../poll_repository.dart';

class PollController extends GetxController{

  PollRepository pollRepository = PollRepository();
  List<Poll> myPollList = [];
  List<Poll> joinedPollList = [];

  late PageController myPollPageController;
  setMyPollPageIndex(int index){
    myPollPageController =PageController(initialPage: index);
    update();
  }



  setPollList() async {
    myPollList = await pollRepository.setPollList()??[];
    update();
  }
  deletePoll(Poll data, index){

    myPollList.removeAt(index);
    update();
    pollRepository.deletePoll(data.id);
    setPollList();
    update();
  }

  bool isMyPoll = true;
  changeLeft(){
    isMyPoll = true;
    update();
  }
  changeRight(){
    isMyPoll = false;
    update();
  }


  setJoinedPollList() async {
    safePrint('조인드 리스트');
    List<Poll> tempFeedList = await pollRepository.getJoinedPollList(0) ?? [];
    for (int i = 0; i < tempFeedList.length; i++) {
      joinedPollList.add(tempFeedList[i]);

    }
    safePrint('조인드 리스트');
    safePrint(tempFeedList.length);
    safePrint(joinedPollList.length);
  }
  refreshJoinedList() async {
    indicatorController.nowLoading();
    update();
    joinedSkip = 0;
    List<Poll> tempFeedList = await pollRepository.getJoinedPollList(joinedSkip) ?? [];
    joinedPollList = [];
    for (int i = 0; i < tempFeedList.length; i++) {
      joinedPollList.add(tempFeedList[i]);
    }
    update();
  }




  bool ifJoinedListLoading = false;
  int joinedSkip = 0;

  getNextJoinedList() async {
    if (homeController.joinedListScrollController.position.extentAfter < 100 && ifJoinedListLoading == false) {
      ifJoinedListLoading = true;
      joinedSkip += 20;
      update();
      homeController.update();

      List<Poll> tempFeedList = await pollRepository.getJoinedPollList(joinedSkip) ?? [];
      for (int i = 0; i < tempFeedList.length; i++) {
        joinedPollList.add(tempFeedList[i]);
      }

      ifJoinedListLoading = false;
      update();
      homeController.update();
    }
  }



  finalChoice(Poll pollData,index, selectedIndex) async {
    indicatorController.nowLoading();
    update();
    Get.find<PollDetailController>().update();
    List<int> finalChoice = [];

    if(pollData.items.length>2){
      if (pollData.finalChoice == null) {
        for (int i = 0; i < pollData.items.length; i++) {
          finalChoice.add(0);
        }
        finalChoice[selectedIndex] = 1;
      } else {
        finalChoice = pollData.finalChoice!;
        finalChoice[selectedIndex] = 1;
      }
    }else{
      if(selectedIndex ==0 ){
        finalChoice = [1,0];
      }else{
        finalChoice = [0,1];
      }
    }






    PollRepository pollRepository = PollRepository();
    await pollRepository.patchPollFinal(pollData.id, finalChoice);

    Poll? getPollData = await pollRepository.getPollById(pollData.id);


    if (getPollData != null) {
      myPollList[index] = myPollList[index].copyWith(
          numberOfVotes: getPollData.numberOfVotes,
          finalChoice:  getPollData.finalChoice
      );

    }

    Get.find<PollDetailController>().selectItem(0);
    update();
    Get.find<PollDetailController>().update();

  }


  generalFinalChoice(Poll pollData,index, List<int> finalChoice) async {
    indicatorController.nowLoading();
    update();
    Get.find<PollDetailController>().update();

    PollRepository pollRepository = PollRepository();
    await pollRepository.patchPollFinal(pollData.id, finalChoice);

    Poll? getPollData = await pollRepository.getPollById(pollData.id);


    if (getPollData != null) {
      myPollList[index] = myPollList[index].copyWith(
          numberOfVotes: getPollData.numberOfVotes,
          finalChoice:  getPollData.finalChoice
      );

    }

    Get.find<PollDetailController>().selectItem(0);
    update();
    Get.find<PollDetailController>().update();

  }
}