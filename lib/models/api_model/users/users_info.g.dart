// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UsersInfo _$$_UsersInfoFromJson(Map<String, dynamic> json) => _$_UsersInfo(
      id: json['id'] as int,
      nickName: json['nickName'] as String?,
      profileImage: json['profileImage'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      deviceToken: json['deviceToken'] as String,
      loginType: json['loginType'] as String,
      userState: json['userState'] as String,
      withdrawReason: json['withdrawReason'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$$_UsersInfoToJson(_$_UsersInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickName': instance.nickName,
      'profileImage': instance.profileImage,
      'email': instance.email,
      'gender': instance.gender,
      'deviceToken': instance.deviceToken,
      'loginType': instance.loginType,
      'userState': instance.userState,
      'withdrawReason': instance.withdrawReason,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'fcmToken': instance.fcmToken,
    };
