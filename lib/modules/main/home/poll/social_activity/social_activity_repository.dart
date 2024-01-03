import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/api_model/cart/cart.dart';
import 'package:shovving_pre/models/api_model/poll/api_poll.dart';
import 'package:shovving_pre/models/api_model/poll/callback_poll.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/util/dio/api_constants.dart';
import 'package:shovving_pre/util/dio/dio_api.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

class SocialActivityRepository {
  static final SocialActivityRepository _repository = SocialActivityRepository._intrnal();

  factory SocialActivityRepository() => _repository;

  SocialActivityRepository._intrnal();

  Dio dio = HttpService().to();

  Future<void> sampleCommentPost(int pollId, String side, String comment) async {
    safePrint('@@@=>post Comment');
    try {
      final response = await dio.post(APIConstants.comment, data: {
        "pollId": pollId,
        "side": side,
        "comment": comment,
      });
      if (response.statusCode == 201 || response.statusCode == 200) {
        pollController.setPollList();
      }
    } catch (e) {
      safePrint('error in post comment test : $e');
    }
  }

  Future<void> likePost(int targetId, int type ) async {
    ///type 1= 댓글 , type 2 = 투표
    safePrint('@@@=>post Comment');
    try {
      final response = await dio.post(APIConstants.likes, data: {
        "targetId": targetId,
        "type": type,
      });
      if (response.statusCode == 201 || response.statusCode == 200) {
        safePrint('좋아요 호출 완료');



      }
    } catch (e) {
      safePrint('error in post Likes : $e');
    }
  }

  Future<void> reportPost(int type, int reportedUserId, int reportedItemId, int reason, String description) async {
    safePrint('@@@=>post Report');
    try {
      final response = await dio.post(APIConstants.report, data: {
        "reportedToUserId": reportedUserId,
        "type": type,
        "reportedItemId": reportedItemId,
        "reason": reason,
        "description": description,
        "isDeleted": 0
      });
    } catch (e) {
      safePrint('error in post comment test : $e');
    }
  }



}
