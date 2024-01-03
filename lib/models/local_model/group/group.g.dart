// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Group _$$_GroupFromJson(Map<String, dynamic> json) => _$_Group(
      id: json['id'] as int?,
      localId: json['localId'] as String,
      groupName: json['groupName'] as String,
      groupColorId: json['groupColorId'] as int,
      groupIconId: json['groupIconId'] as int,
      isDeleted: json['isDeleted'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$_GroupToJson(_$_Group instance) => <String, dynamic>{
      'id': instance.id,
      'localId': instance.localId,
      'groupName': instance.groupName,
      'groupColorId': instance.groupColorId,
      'groupIconId': instance.groupIconId,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
