// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      id: json['id'] as int,
      userId: json['userId'] as int,
      side: json['side'] as String,
      comment: json['comment'] as String,
      isDeleted: json['isDeleted'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      likes: (json['likes'] as List<dynamic>)
          .map((e) => CommentLike.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: OtherUserInfo.fromJson(json['user'] as Map<String, dynamic>),
      likeLength: json['likeLength'] as int?,
      like: json['like'] as bool?,
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'side': instance.side,
      'comment': instance.comment,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'likes': instance.likes,
      'user': instance.user,
      'likeLength': instance.likeLength,
      'like': instance.like,
    };
