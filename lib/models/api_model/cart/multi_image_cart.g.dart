// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_image_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MultiImageCart _$$_MultiImageCartFromJson(Map<String, dynamic> json) =>
    _$_MultiImageCart(
      id: json['id'] as int?,
      userID: json['userID'] as int?,
      localId: json['localId'] as String,
      url: json['url'] as String,
      image: (json['image'] as List<dynamic>).map((e) => e as String).toList(),
      title: json['title'] as String?,
      groupIds: json['groupIds'] as String,
      isDeleted: json['isDeleted'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$_MultiImageCartToJson(_$_MultiImageCart instance) =>
    <String, dynamic>{
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
    };
