import 'package:freezed_annotation/freezed_annotation.dart';
part 'users_info.freezed.dart';
part 'users_info.g.dart';

@freezed
class UsersInfo with _$UsersInfo {
  factory UsersInfo(
      {required int id,
      String? nickName,
      String? profileImage,
      String? email,
      String? gender,
      required String deviceToken,
      required String loginType,
      required String userState,
      String? withdrawReason,
      required String createdAt,
      required String updatedAt,
      String? fcmToken

      }) = _UsersInfo;

  factory UsersInfo.fromJson(Map<String, dynamic> json) => _$UsersInfoFromJson(json);
}
