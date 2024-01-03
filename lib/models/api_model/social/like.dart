import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:shovving_pre/models/api_model/users/other_user_info.dart';
import 'package:shovving_pre/models/api_model/users/users_info.dart';
part 'like.freezed.dart';
part 'like.g.dart';

@freezed
class Like with _$Like {
  factory Like({
    required int id,
    required int userId,
    int? commentId,
    required int targetId,
    required int type,
    required String createdAt,
    required String updatedAt,
    required OtherUserInfo user
  }) = _Like;

  factory Like.fromJson(Map<String, dynamic> json) =>
      _$LikeFromJson(json);
}

