import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shovving_pre/models/api_model/cart/cart.dart';
import 'package:shovving_pre/models/api_model/users/users_info.dart';
import 'package:shovving_pre/models/local_model/group/group.dart';

import '../users/poll_users_info.dart';
part 'callback_poll.freezed.dart';
part 'callback_poll.g.dart';

@freezed
class CallBackPoll with _$CallBackPoll {
  factory CallBackPoll({
    required int id,
    required int userId,
    required String pollComment,
    required String itemIds,
    required String numberOfVotes,
    required String itemComment,
    String? finalChoice,
    String? finalComment,
    required int isDeleted,
    required String state,
    required String profileImage,
    required int colorIndex,
    required String createdAt,
    String? joins,
    String? updatedAt,
    PollUsersInfo? user
  }
      ) = _CallBackPoll;

  factory CallBackPoll.fromJson(Map<String, dynamic> json) => _$CallBackPollFromJson(json);
}

