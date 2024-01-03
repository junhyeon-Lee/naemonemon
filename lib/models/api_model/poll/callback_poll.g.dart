// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callback_poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CallBackPoll _$$_CallBackPollFromJson(Map<String, dynamic> json) =>
    _$_CallBackPoll(
      id: json['id'] as int,
      userId: json['userId'] as int,
      pollComment: json['pollComment'] as String,
      itemIds: json['itemIds'] as String,
      numberOfVotes: json['numberOfVotes'] as String,
      itemComment: json['itemComment'] as String,
      finalChoice: json['finalChoice'] as String?,
      finalComment: json['finalComment'] as String?,
      isDeleted: json['isDeleted'] as int,
      state: json['state'] as String,
      profileImage: json['profileImage'] as String,
      colorIndex: json['colorIndex'] as int,
      createdAt: json['createdAt'] as String,
      joins: json['joins'] as String?,
      updatedAt: json['updatedAt'] as String?,
      user: json['user'] == null
          ? null
          : PollUsersInfo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CallBackPollToJson(_$_CallBackPoll instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'pollComment': instance.pollComment,
      'itemIds': instance.itemIds,
      'numberOfVotes': instance.numberOfVotes,
      'itemComment': instance.itemComment,
      'finalChoice': instance.finalChoice,
      'finalComment': instance.finalComment,
      'isDeleted': instance.isDeleted,
      'state': instance.state,
      'profileImage': instance.profileImage,
      'colorIndex': instance.colorIndex,
      'createdAt': instance.createdAt,
      'joins': instance.joins,
      'updatedAt': instance.updatedAt,
      'user': instance.user,
    };
