import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shovving_pre/models/api_model/users/other_user_info.dart';
part 'comment_like.freezed.dart';
part 'comment_like.g.dart';

@freezed
class CommentLike with _$CommentLike {
  factory CommentLike({
    required int id,
    required int userId,
    int? pollId,
    int? commentId,
    required int targetId,
    required int type,
    required String createdAt,
    required String updatedAt,
  }) = _CommentLike;

  factory CommentLike.fromJson(Map<String, dynamic> json) =>
      _$CommentLikeFromJson(json);
}

