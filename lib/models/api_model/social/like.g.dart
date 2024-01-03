// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Like _$$_LikeFromJson(Map<String, dynamic> json) => _$_Like(
      id: json['id'] as int,
      userId: json['userId'] as int,
      commentId: json['commentId'] as int?,
      targetId: json['targetId'] as int,
      type: json['type'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      user: OtherUserInfo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LikeToJson(_$_Like instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'commentId': instance.commentId,
      'targetId': instance.targetId,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'user': instance.user,
    };
