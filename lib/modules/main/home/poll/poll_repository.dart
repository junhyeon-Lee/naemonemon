import 'package:dio/dio.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/api_model/cart/cart.dart';
import 'package:shovving_pre/models/api_model/poll/api_poll.dart';
import 'package:shovving_pre/models/api_model/poll/callback_poll.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/util/dio/api_constants.dart';
import 'package:shovving_pre/util/dio/dio_api.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

import 'poll_detail/pollDetail_calculator.dart';

class PollRepository {
  static final PollRepository _repository = PollRepository._intrnal();

  factory PollRepository() => _repository;

  PollRepository._intrnal();

  Dio dio = HttpService().to();

  Future<List<Poll>?> setPollList() async {
    safePrint('@@@=>try get poll list');
    try {
      safePrint('@@@=>try get poll list');
      final response = await dio.get(APIConstants.polls);
      if (response.statusCode == 201 || response.statusCode == 200) {
        safePrint('@@@=>try get poll list');
        List<ApiPoll> getPollList = (response.data as List<dynamic>).map((e) => ApiPoll.fromJson(e as Map<String, dynamic>)).toList();
        List<Poll> localPollList = [];
        if (getPollList.isNotEmpty) {
          for (int i = 0; i < getPollList.length; i++) {
            List<int>? intList;

            if (getPollList[i].finalChoice == '') {
            } else {
              List<String> stringList = getPollList[i].finalChoice!.split(',');
              intList = stringList.map((string) => int.parse(string)).toList();
            }

            ///여기서 순서 세팅 할꺼야
            //아이템 순서를 리스트로 세팅 했여
            List<String> itemsIds = getPollList[i].itemIds.split(',');
            itemsIds.remove('');

            ///여기서는 아이템의 순서만을 배치하겠습니다.
            List<Cart> tempItemsList = [];
            for (int a = 0; a < itemsIds.length; a++) {
              for (int b = 0; b < getPollList[i].items.length; b++) {
                if (itemsIds[a] == getPollList[i].items[b].id.toString()) {
                  //아이템의 순서대로 각 썸네일을 풀이미지 리스트의 각 항목에 삽입 그리고 그냥 이이템도
                  tempItemsList.add(getPollList[i].items[b]);
                }
              }
            }

            List<int> joinsList = [];
            if (getPollList[i].joins == null) {
            } else {
              List<String> tempJoins = getPollList[i].joins!.split(',');
              tempJoins.remove('');
              for (int i = 0; i < tempJoins.length; i++) {
                joinsList.add(int.parse(tempJoins[i]));
              }
            }

            int likeLength = 0;
            if(getPollList[i].likes==null){
              likeLength =0;
            }else{
              likeLength=   getPollList[i].likes!.length;
            }

            List<String> novString = getPollList[i].numberOfVotes.split(',');

            List<int> novList = novString.map((string) => int.parse(string)).toList();
            localPollList.insert(
              0,
              Poll(
                  id: getPollList[i].id,
                  userId: getPollList[i].userId,
                  pollComment: getPollList[i].pollComment,
                  itemIds: getPollList[i].itemIds,
                  numberOfVotes: novList,
                  itemComment: getPollList[i].itemComment.split(','),
                  finalChoice: intList,
                  finalComment: getPollList[i].finalComment,
                  isDeleted: getPollList[i].isDeleted,
                  state: getPollList[i].state,
                  profileImage: getPollList[i].profileImage,
                  colorIndex: getPollList[i].colorIndex,
                  createAt: getPollList[i].createdAt,
                  updateAt: getPollList[i].updatedAt,
                  items: tempItemsList,
                  joins: joinsList,
                  like: myStatePollLike(getPollList[i].likes ?? []),
                  likeLength: likeLength,
                  comments: getPollList[i].comments ?? [],
                  user: getPollList[i].user
              ),
            );
          }

          return localPollList; //


          // Move this line outside the for loop
        }
      }
    } catch (e) {
      safePrint('error in get poll list : $e');
    }
    return null;
  }

  Future<CallBackPoll?> postPoll(List<int> items, String? pollComment, bool isPublic, String? pollImages) async {
    safePrint('@@@=>try post poll');

    String tempItemString = "";
    String tempItemComment = '';
    String tempItemNoV = '';
    tempItemString = '${items[0]},$tempItemString';
    tempItemNoV += '0,0';
    tempItemComment += ',';
    if (items.length > 1) {
      for (int i = 1; i < items.length; i++) {
        tempItemString = '${items[i]},$tempItemString';

        if (i == 1) {
        } else {
          tempItemNoV += ',0';
          tempItemComment += ',';
        }
      }
    }

    try {
      final response = await dio.post(APIConstants.polls, data: {
        "pollComment": pollComment,
        "itemIds": tempItemString,
        "numberOfVotes": tempItemNoV,
        "itemComment": pollImages ?? tempItemComment,
        "isDeleted": 0,
        "state": isPublic ? 2 : 1,
        "profileImage": userInfoController.usersInfo!.profileImage,
        "colorIndex": 0
      });
      if (response.statusCode == 201 || response.statusCode == 200) {
        CallBackPoll callBackPoll = CallBackPoll.fromJson(response.data);
        safePrint(callBackPoll);
        return callBackPoll;
      }
    } catch (e) {
      safePrint('error in set group list : $e');
    }
    return null;
  }

  Future<void> deletePoll(int pollId) async {
    safePrint('@@@=>try delete poll');
    try {
      final response = await dio.patch(
        '${APIConstants.polls}/$pollId',
        data: {
          "isDeleted": 1,
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        await pollController.setPollList();
      }
    } catch (e) {
      safePrint('error in set group list : $e');
    }
  }

  Future<void> patchPollFinal(int id, List<int> finalChoice,) async {
    safePrint('@@@=>try finish poll');

    try {
      final response = await dio.patch(
        '${APIConstants.pollFinish}/$id',
        data: {"finalChoice": finalChoice.join(','), "finalComment": 'a'},
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        //pollController.setPollList();
      }
    } catch (e) {
      safePrint('error in finish poll : $e');
    }
  }

  Future<void> patchPollComment(int id, String pollComment,) async {
    safePrint('@@@=>try patch poll');


    try {
      final response = await dio.patch(
        '${APIConstants.polls}/$id',
        data: {"pollComment": pollComment},
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        //pollController.setPollList();
      }
    } catch (e) {
      safePrint('error in patch poll : $e');
    }
  }

  Future<Poll?> getPollById(int id,) async {
    safePrint('@@@=>try get poll by id');

    try {
      final response = await dio.get('${APIConstants.polls}/$id');
      if (response.statusCode == 201 || response.statusCode == 200) {
        ApiPoll getApiPoll = ApiPoll.fromJson(response.data);
        List<int>? intList;
        if (getApiPoll.finalChoice == '') {
        } else {
          List<String> stringList = getApiPoll.finalChoice!.split(',');
          intList = stringList.map((string) => int.parse(string)).toList();
        }

        List<String> novString = getApiPoll.numberOfVotes.split(',');
        List<int> novList = novString.map((string) => int.parse(string)).toList();

        List<int> joinsList = [];
        if (getApiPoll.joins == null) {
        } else {
          List<String> tempJoins = getApiPoll.joins!.split(',');
          tempJoins.remove('');
          for (int i = 0; i < tempJoins.length; i++) {
            joinsList.add(int.parse(tempJoins[i]));
          }
        }

        int likeLength = 0;
        if(getApiPoll.likes==null){
          likeLength =0;
        }else{
          likeLength=   getApiPoll.likes!.length;
        }

        Poll pollByID = Poll(
            id: getApiPoll.id,
            userId: getApiPoll.userId,
            pollComment: getApiPoll.pollComment,
            itemIds: getApiPoll.itemIds,
            numberOfVotes: novList,
            finalChoice: intList,
            itemComment: getApiPoll.itemComment.split(','),
            isDeleted: getApiPoll.isDeleted,
            state: getApiPoll.state,
            profileImage: getApiPoll.profileImage,
            colorIndex: getApiPoll.colorIndex,
            createAt: getApiPoll.createdAt,
            updateAt: getApiPoll.updatedAt,
            items: getApiPoll.items,
            like: myStatePollLike(getApiPoll.likes ?? []),
            likeLength: likeLength,
            comments: getApiPoll.comments ?? [],
            joins: joinsList,
            user: getApiPoll.user);

        return pollByID;
      }
    } catch (e) {
      safePrint('error in get poll by id : $e');
    }
    return null;
  }










  Future<List<Poll>?> getFeedList(int skip) async {
    safePrint('@@@=>try get feed list');
    try {
      safePrint('@@@=>try get feed list');
      final response = await dio.get('${APIConstants.feed}?limit=30&skip=$skip');
      safePrint(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        safePrint('@@@=>try get feed list');


        List<ApiPoll> getPollList = (response.data as List<dynamic>).map((e) => ApiPoll.fromJson(e as Map<String, dynamic>)).toList();

        List<Poll> localPollList = [];
        if (getPollList.isNotEmpty) {
          for (int i = 0; i < getPollList.length; i++) {

            List<int>? intList;

            if (getPollList[i].finalChoice == '') {
            } else {
              List<String> stringList = getPollList[i].finalChoice!.split(',');
              intList = stringList.map((string) => int.parse(string)).toList();
            }

            List<int> joinsList = [];
            if (getPollList[i].joins == null) {
            } else {
              List<String> tempJoins = getPollList[i].joins!.split(',');
              tempJoins.remove('');
              for (int i = 0; i < tempJoins.length; i++) {
                joinsList.add(int.parse(tempJoins[i]));
              }
            }

            ///여기서 순서 세팅 할꺼야
            //아이템 순서를 리스트로 세팅 했여
            List<String> itemsIds = getPollList[i].itemIds.split(',');
            itemsIds.remove('');

            ///여기서는 아이템의 순서만을 배치하겠습니다.
            List<Cart> tempItemsList = [];
            for (int a = 0; a < itemsIds.length; a++) {
              for (int b = 0; b < getPollList[i].items.length; b++) {
                if (itemsIds[a] == getPollList[i].items[b].id.toString()) {
                  //아이템의 순서대로 각 썸네일을 풀이미지 리스트의 각 항목에 삽입 그리고 그냥 이이템도
                  tempItemsList.add(getPollList[i].items[b]);
                }
              }
            }

            int likeLength = 0;
            if(getPollList[i].likes==null){
              likeLength =0;
            }else{
              likeLength=   getPollList[i].likes!.length;
            }




            List<String> novString = getPollList[i].numberOfVotes.split(',');
            List<int> novList = novString.map((string) => int.parse(string)).toList();

            localPollList.insert(
              0,
              Poll(
                  id: getPollList[i].id,
                  userId: getPollList[i].userId,
                  pollComment: getPollList[i].pollComment,
                  itemIds: getPollList[i].itemIds,
                  numberOfVotes: novList,
                  itemComment: getPollList[i].itemComment.split(','),
                  finalChoice: intList,
                  finalComment: getPollList[i].finalComment,
                  isDeleted: getPollList[i].isDeleted,
                  state: getPollList[i].state,
                  profileImage: getPollList[i].profileImage,
                  colorIndex: getPollList[i].colorIndex,
                  createAt: getPollList[i].createdAt,
                  updateAt: getPollList[i].updatedAt,
                  items: tempItemsList,
                  like: myStatePollLike(getPollList[i].likes ?? []),
                  likeLength: likeLength,
                  comments: getPollList[i].comments ?? [],
                  joins: joinsList,
                  user: getPollList[i].user),
            );


          }
          return localPollList; // Move this line outside the for loop
        }
      }
    } catch (e) {
      safePrint('error in get poll list : $e');
    }
    return null;
  }

  Future<List<Poll>?> getJoinedPollList(int skip) async {
    safePrint('@@@=>try get joined Poll list');
    try {
      safePrint('@@@=>try get feed list');
      final response = await dio.get('${APIConstants.feed}?includeJoin=true&limit=20&skip=$skip');
      safePrint(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        safePrint('@@@=>try get joined Poll list');
        safePrint('넣고 있어?');

        List<ApiPoll> getPollList = (response.data as List<dynamic>).map((e) => ApiPoll.fromJson(e as Map<String, dynamic>)).toList();
        safePrint('넣고 있어?');
        safePrint(getPollList.length);
        List<Poll> localPollList = [];
        if (getPollList.isNotEmpty) {
          for (int i = 0; i < getPollList.length; i++) {

            List<int>? intList;

            if (getPollList[i].finalChoice == '') {
            } else {
              List<String> stringList = getPollList[i].finalChoice!.split(',');
              intList = stringList.map((string) => int.parse(string)).toList();
            }

            List<int> joinsList = [];
            if (getPollList[i].joins == null) {
            } else {
              List<String> tempJoins = getPollList[i].joins!.split(',');
              tempJoins.remove('');
              for (int i = 0; i < tempJoins.length; i++) {
                joinsList.add(int.parse(tempJoins[i]));
              }
            }

            ///여기서 순서 세팅 할꺼야
            //아이템 순서를 리스트로 세팅 했여
            List<String> itemsIds = getPollList[i].itemIds.split(',');
            itemsIds.remove('');

            ///여기서는 아이템의 순서만을 배치하겠습니다.
            List<Cart> tempItemsList = [];
            for (int a = 0; a < itemsIds.length; a++) {
              for (int b = 0; b < getPollList[i].items.length; b++) {
                if (itemsIds[a] == getPollList[i].items[b].id.toString()) {
                  //아이템의 순서대로 각 썸네일을 풀이미지 리스트의 각 항목에 삽입 그리고 그냥 이이템도
                  tempItemsList.add(getPollList[i].items[b]);
                }
              }
            }

            int likeLength = 0;
            if(getPollList[i].likes==null){
              likeLength =0;
            }else{
              likeLength=   getPollList[i].likes!.length;
            }




            List<String> novString = getPollList[i].numberOfVotes.split(',');
            List<int> novList = novString.map((string) => int.parse(string)).toList();

            safePrint('넣고 있어?');
            localPollList.insert(
              0,
              Poll(
                  id: getPollList[i].id,
                  userId: getPollList[i].userId,
                  pollComment: getPollList[i].pollComment,
                  itemIds: getPollList[i].itemIds,
                  numberOfVotes: novList,
                  itemComment: getPollList[i].itemComment.split(','),
                  finalChoice: intList,
                  finalComment: getPollList[i].finalComment,
                  isDeleted: getPollList[i].isDeleted,
                  state: getPollList[i].state,
                  profileImage: getPollList[i].profileImage,
                  colorIndex: getPollList[i].colorIndex,
                  createAt: getPollList[i].createdAt,
                  updateAt: getPollList[i].updatedAt,
                  items: tempItemsList,
                  like: myStatePollLike(getPollList[i].likes ?? []),
                  likeLength: likeLength,
                  comments: getPollList[i].comments ?? [],
                  joins: joinsList,
                  user: getPollList[i].user),
            );


            safePrint(localPollList.length);
            safePrint('조인을 한적이 없는 계정인데');

          }
          return localPollList; // Move this line outside the for loop
        }
      }
    } catch (e) {
      safePrint('error in get poll list : $e');
    }
    return null;
  }




  Future<void> socialPollJoin(
    int id,
    List<int> joinData,
  ) async {
    safePrint('@@@=>try social join');

    try {
      final response = await dio.patch(
        '${APIConstants.socialPollJoin}/$id',
        data: {"joinData": joinData.join(','), "votedUserDeviceToken": userInfoController.usersInfo?.deviceToken ?? ''},
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        safePrint('투표 성공 했심더');
      }
    } catch (e) {
      safePrint('error in finish poll : $e');
    }
  }
}
