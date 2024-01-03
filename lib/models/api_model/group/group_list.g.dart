// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupList _$$_GroupListFromJson(Map<String, dynamic> json) => _$_GroupList(
      groupList: (json['groupList'] as List<dynamic>)
          .map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GroupListToJson(_$_GroupList instance) =>
    <String, dynamic>{
      'groupList': instance.groupList,
    };
