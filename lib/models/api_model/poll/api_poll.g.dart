// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ApiPoll _$$_ApiPollFromJson(Map<String, dynamic> json) => _$_ApiPoll(
      id: json['id'] as int,
      userId: json['userId'] as int,
      pollComment: json['pollComment'] as String,
      itemIds: json['itemIds'] as String,
      numberOfVotes: json['numberOfVotes'] as String,
      itemComment: json['itemComment'] as String,
      finalChoice: json['finalChoice'] as String?,
      finalComment: json['finalComment'] as String?,
      isDeleted: json['isDeleted'] as int,
      state: json['state'] as int,
      profileImage: json['profileImage'] as String,
      colorIndex: json['colorIndex'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => Cart.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: (json['likes'] as List<dynamic>?)
          ?.map((e) => Like.fromJson(e as Map<String, dynamic>))
          .toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      joins: json['joins'] as String?,
      user: json['user'] == null
          ? null
          : PollUsersInfo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ApiPollToJson(_$_ApiPoll instance) =>
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
      'updatedAt': instance.updatedAt,
      'items': instance.items,
      'likes': instance.likes,
      'comments': instance.comments,
      'joins': instance.joins,
      'user': instance.user,
    };
