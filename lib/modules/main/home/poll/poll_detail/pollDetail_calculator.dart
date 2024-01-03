import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/api_model/social/comment_like.dart';
import 'package:shovving_pre/models/api_model/social/like.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

///이미지 풀
List<List<String>> getFullImage(Poll pollData) {
  List<String> itemsIds = pollData.itemIds.split(',');
  itemsIds.remove('');

  List<List<String>> fullImageList = [];

  for (int i = 0; i < itemsIds.length; i++) {
    for (int j = 0; j < pollData.items.length; j++) {
      if (itemsIds[i] == pollData.items[j].id.toString()) {
        fullImageList.add([pollData.items[j].image ?? '']);
      }
    }
  }
  //서브 삽입
  for (int i = 0; i < pollData.itemComment.length; i++) {
    if (pollData.itemComment[i].length > 1) {
      fullImageList[int.parse(pollData.itemComment[i].substring(0, 1))].add(pollData.itemComment[i].substring(1));
    } else {}
  }

  return fullImageList;
}

///이미지 썸네일
List<String> getItemImage(Poll pollData) {
  List<String> itemsIds = pollData.itemIds.split(',');
  itemsIds.remove('');

  List<String> itemsImageList = [];

  for (int i = 0; i < itemsIds.length; i++) {
    for (int j = 0; j < pollData.items.length; j++) {
      if (itemsIds[i] == pollData.items[j].id.toString()) {
        itemsImageList.add(pollData.items[j].image ?? '');
      }
    }
  }
  return itemsImageList;
}

///스플릿 포인트
List<int> getSplitPoint(Poll pollData, List<List<String>> fullImageList) {
  List<int> splitPoint = [];
  int imageListLength = 0;
  for (int i = 0; i < pollData.items.length; i++) {
    splitPoint.add(0);
    for (int j = 0; j < fullImageList[i].length; j++) {
      imageListLength++;
      splitPoint[i]++;
    }
  }
  return splitPoint;
}

///풀 이미지 길이
int getFullImageLength(Poll pollData, List<List<String>> fullImageList) {
  int imageListLength = 0;
  for (int i = 0; i < pollData.items.length; i++) {
    for (int j = 0; j < fullImageList[i].length; j++) {
      imageListLength++;
    }
  }
  return imageListLength;
}

///내가 좋아요를 눌렀는지에 대해
bool myStatePollLike(List<Like> likeList) {
  List<int> likeIdList = [];
  if (likeList.isNotEmpty) {
    for (int i = 0; i < likeList.length; i++) {
      likeIdList.add(likeList[i].userId);
    }
  }

  if (likeIdList.contains(userInfoController.usersInfo?.id)) {
    return true;
  } else {
    return false;
  }
}

bool myStateCommentLike(List<CommentLike> likeList) {
  List<int> likeIdList = [];
  if (likeList.isNotEmpty) {
    for (int i = 0; i < likeList.length; i++) {
      likeIdList.add(likeList[i].userId);
    }
  }

  if (likeIdList.contains(userInfoController.usersInfo?.id)) {
    return true;
  } else {
    return false;
  }
}


int? mostVotes(List<int> voteNumber) {
  List<int> joins = [];
  for (int i = 0; i < voteNumber.length; i++) {
    joins.add(voteNumber[i]);
  }

  joins.sort();

  int max = joins.last;
  int mostVotes = voteNumber.indexOf(max);

  if (max == 0) {
    return null;
  } else {
    return mostVotes;
  }
}

int? votesRanking(List<int> voteNumber, int selectedIndex) {
  List<int> joins = [];
  for (int i = 0; i < voteNumber.length; i++) {
    joins.add(voteNumber[i]);
  }

  joins.sort((a, b) => b.compareTo(a));

  int votesRanking = joins.indexOf(voteNumber[selectedIndex]);

  if (voteNumber[selectedIndex] == 0) {
    return null;
  } else {
    return votesRanking + 1;
  }
}

bool alreadyJoin(List<int>? joins, int selectedIndex) {
  if (joins == null) {
    return false;
  } else if (joins.isEmpty) {
    return false;
  } else {
    if (joins![selectedIndex] == 0) {
      return false;
    } else {
      return true;
    }
  }
}

List<int> getJoinData(Poll pollData) {
  List<int> joinData = [];

  int length =0;
  if(pollData.items.length == 1){
    length = 2;
  }else{
    length = pollData.items.length;
  }

  for (int i = 0; i < length; i++) {
    joinData.add(0);
    if (pollData.joins!.isNotEmpty) {
      if (pollData.joins![i] != 0) {
        joinData[i] = 1;
      }
    }
  }
  return joinData;
}

List<int> setJoinData(int selectedIndex, List<int> joinData, int itemLength) {
  List<int> tempJoinData = [];
  if (joinData.isEmpty) {
    for (int i = 0; i < itemLength; i++) {
      if (selectedIndex == i) {
        tempJoinData.add(1);
      } else {
        tempJoinData.add(0);
      }
    }
    return tempJoinData;
  } else {
    if (joinData[selectedIndex] != 0) {
      return tempJoinData;
    } else {
      for (int i = 0; i < joinData.length; i++) {
        if (selectedIndex == i) {
          tempJoinData.add(1);
        } else {
          tempJoinData.add(0);
        }
      }
      return tempJoinData;
    }
  }
}

bool commentBlindChecker(List<int> join, List<int>? finalChoice, bool isMine){

  if(isMine){
    return false;
  }else{
    if(finalChoice!=null){
      return false;
    }else{
      if(join.isEmpty){
        return true;
      }else{
        return false;
      }
    }

  }




}
