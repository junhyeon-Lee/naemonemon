// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Poll _$$_PollFromJson(Map<String, dynamic> json) => _$_Poll(
      id: json['id'] as int,
      userId: json['userId'] as int,
      pollComment: json['pollComment'] as String,
      itemIds: json['itemIds'] as String,
      numberOfVotes: (json['numberOfVotes'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      itemComment: (json['itemComment'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      finalChoice: (json['finalChoice'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      finalComment: json['finalComment'] as String?,
      isDeleted: json['isDeleted'] as int,
      state: json['state'] as int,
      profileImage: json['profileImage'] as String,
      colorIndex: json['colorIndex'] as int,
      createAt: json['createAt'] as String,
      updateAt: json['updateAt'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => Cart.fromJson(e as Map<String, dynamic>))
          .toList(),
      like: json['like'] as bool,
      likeLength: json['likeLength'] as int,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      joins: (json['joins'] as List<dynamic>?)?.map((e) => e as int).toList(),
      user: json['user'] == null
          ? null
          : PollUsersInfo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PollToJson(_$_Poll instance) => <String, dynamic>{
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
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'items': instance.items,
      'like': instance.like,
      'likeLength': instance.likeLength,
      'comments': instance.comments,
      'joins': instance.joins,
      'user': instance.user,
    };
