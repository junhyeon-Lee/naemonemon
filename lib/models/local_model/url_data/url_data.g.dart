// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UrlData _$$_UrlDataFromJson(Map<String, dynamic> json) => _$_UrlData(
      id: json['id'] as int?,
      userID: json['userID'] as int?,
      localId: json['localId'] as String,
      url: json['url'] as String,
      image: json['image'] as String?,
      title: json['title'] as String?,
      group: (json['group'] as List<dynamic>).map((e) => e as String).toList(),
      isDeleted: json['isDeleted'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$_UrlDataToJson(_$_UrlData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'localId': instance.localId,
      'url': instance.url,
      'image': instance.image,
      'title': instance.title,
      'group': instance.group,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
