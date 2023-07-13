// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UrlData _$$_UrlDataFromJson(Map<String, dynamic> json) => _$_UrlData(
      id: json['id'] as String,
      url: json['url'] as String,
      image: json['image'] as String?,
      title: json['title'] as String?,
      group: (json['group'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_UrlDataToJson(_$_UrlData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'image': instance.image,
      'title': instance.title,
      'group': instance.group,
    };
