import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shovving_pre/models/api_model/social/comment_like.dart';
import 'package:shovving_pre/models/api_model/users/other_user_info.dart';

import 'like.dart';
part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  factory Comment({
    required int id,
    required int userId,
    required String side,
    required String comment,
    required int isDeleted,
    required String createdAt,
    required String updatedAt,
    required List<CommentLike> likes,
    required OtherUserInfo user,
    int? likeLength,
    bool? like
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

