// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommentLike _$$_CommentLikeFromJson(Map<String, dynamic> json) =>
    _$_CommentLike(
      id: json['id'] as int,
      userId: json['userId'] as int,
      pollId: json['pollId'] as int?,
      commentId: json['commentId'] as int?,
      targetId: json['targetId'] as int,
      type: json['type'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$_CommentLikeToJson(_$_CommentLike instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'pollId': instance.pollId,
      'commentId': instance.commentId,
      'targetId': instance.targetId,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
