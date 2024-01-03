import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shovving_pre/models/api_model/cart/cart.dart';
import 'package:shovving_pre/models/api_model/social/comment.dart';
import 'package:shovving_pre/models/api_model/social/like.dart';
import 'package:shovving_pre/models/api_model/users/other_user_info.dart';
import 'package:shovving_pre/models/api_model/users/users_info.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';

import '../../api_model/users/poll_users_info.dart';
part 'poll.freezed.dart';
part 'poll.g.dart';

@freezed
class Poll with _$Poll {
  factory Poll({
    required int id,
    required int userId,
    required String pollComment,
    required String itemIds,
    required List<int> numberOfVotes,
    required List<String> itemComment,
    List<int>? finalChoice,
    String? finalComment,
    required int isDeleted,
    required int state,
    required String profileImage,
    required int colorIndex,
    required String createAt,
    String? updateAt,
    required List<Cart> items,
    required bool like,
    required int likeLength,
    required List<Comment> comments,
    List<int>? joins,
    PollUsersInfo? user
  }) = _Poll;

  factory Poll.fromJson(Map<String, dynamic> json) =>
      _$PollFromJson(json);
}

