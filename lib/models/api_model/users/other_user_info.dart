import 'package:freezed_annotation/freezed_annotation.dart';
part 'other_user_info.freezed.dart';
part 'other_user_info.g.dart';

@freezed
class OtherUserInfo with _$OtherUserInfo {
  factory OtherUserInfo(
      {required int id,
        String? nickName,
        String? profileImage,
        String? email,
      }) = _OtherUserInfo;

  factory OtherUserInfo.fromJson(Map<String, dynamic> json) => _$OtherUserInfoFromJson(json);
}
