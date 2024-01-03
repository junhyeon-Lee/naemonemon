import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shovving_pre/models/api_model/cart/cart.dart';
import 'package:shovving_pre/models/api_model/social/comment.dart';
import 'package:shovving_pre/models/api_model/social/like.dart';
import 'package:shovving_pre/models/api_model/users/users_info.dart';
import 'package:shovving_pre/models/local_model/group/group.dart';

import '../users/poll_users_info.dart';
part 'api_poll.freezed.dart';
part 'api_poll.g.dart';

@freezed
class ApiPoll with _$ApiPoll {
  factory ApiPoll({
    required int id,
    required int userId,
    required String pollComment,
    required String itemIds,
    required String numberOfVotes,
    required String itemComment,
    String? finalChoice,
    String? finalComment,
    required int isDeleted,
    required int state,
    required String profileImage,
    required int colorIndex,
    required String createdAt,
    String? updatedAt,
    required List<Cart> items,
    List<Like>? likes,
    List<Comment>? comments,
    String? joins,
    PollUsersInfo? user
  }
  ) = _ApiPoll;

  factory ApiPoll.fromJson(Map<String, dynamic> json) => _$ApiPollFromJson(json);
}

