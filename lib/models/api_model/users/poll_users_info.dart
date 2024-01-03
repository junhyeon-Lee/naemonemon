import 'package:freezed_annotation/freezed_annotation.dart';
part 'poll_users_info.freezed.dart';
part 'poll_users_info.g.dart';

@freezed
class PollUsersInfo with _$PollUsersInfo {
  factory PollUsersInfo(
      {required int id,
        String? nickName,
        String? profileImage,
        String? email,
        int? gender,
        required String deviceToken,
        required int loginType,
        required int userState,
        String? withdrawReason,
        required String createdAt,
        required String updatedAt,
        String? fcmToken

      }) = _PollUsersInfo;

  factory PollUsersInfo.fromJson(Map<String, dynamic> json) => _$PollUsersInfoFromJson(json);
}
