// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Cart _$$_CartFromJson(Map<String, dynamic> json) => _$_Cart(
      id: json['id'] as int?,
      userID: json['userID'] as int?,
      localId: json['localId'] as String,
      url: json['url'] as String,
      image: json['image'] as String?,
      title: json['title'] as String?,
      groupIds: json['groupIds'] as String,
      isDeleted: json['isDeleted'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      numberOfVote: json['numberOfVote'] as int?,
    );

Map<String, dynamic> _$$_CartToJson(_$_Cart instance) => <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'localId': instance.localId,
      'url': instance.url,
      'image': instance.image,
      'title': instance.title,
      'groupIds': instance.groupIds,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'numberOfVote': instance.numberOfVote,
    };
