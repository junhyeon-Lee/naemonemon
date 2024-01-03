// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'other_user_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OtherUserInfo _$OtherUserInfoFromJson(Map<String, dynamic> json) {
  return _OtherUserInfo.fromJson(json);
}

/// @nodoc
mixin _$OtherUserInfo {
  int get id => throw _privateConstructorUsedError;
  String? get nickName => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OtherUserInfoCopyWith<OtherUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtherUserInfoCopyWith<$Res> {
  factory $OtherUserInfoCopyWith(
          OtherUserInfo value, $Res Function(OtherUserInfo) then) =
      _$OtherUserInfoCopyWithImpl<$Res, OtherUserInfo>;
  @useResult
  $Res call({int id, String? nickName, String? profileImage, String? email});
}

/// @nodoc
class _$OtherUserInfoCopyWithImpl<$Res, $Val extends OtherUserInfo>
    implements $OtherUserInfoCopyWith<$Res> {
  _$OtherUserInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickName = freezed,
    Object? profileImage = freezed,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickName: freezed == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OtherUserInfoCopyWith<$Res>
    implements $OtherUserInfoCopyWith<$Res> {
  factory _$$_OtherUserInfoCopyWith(
          _$_OtherUserInfo value, $Res Function(_$_OtherUserInfo) then) =
      __$$_OtherUserInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? nickName, String? profileImage, String? email});
}

/// @nodoc
class __$$_OtherUserInfoCopyWithImpl<$Res>
    extends _$OtherUserInfoCopyWithImpl<$Res, _$_OtherUserInfo>
    implements _$$_OtherUserInfoCopyWith<$Res> {
  __$$_OtherUserInfoCopyWithImpl(
      _$_OtherUserInfo _value, $Res Function(_$_OtherUserInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickName = freezed,
    Object? profileImage = freezed,
    Object? email = freezed,
  }) {
    return _then(_$_OtherUserInfo(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickName: freezed == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OtherUserInfo implements _OtherUserInfo {
  _$_OtherUserInfo(
      {required this.id, this.nickName, this.profileImage, this.email});

  factory _$_OtherUserInfo.fromJson(Map<String, dynamic> json) =>
      _$$_OtherUserInfoFromJson(json);

  @override
  final int id;
  @override
  final String? nickName;
  @override
  final String? profileImage;
  @override
  final String? email;

  @override
  String toString() {
    return 'OtherUserInfo(id: $id, nickName: $nickName, profileImage: $profileImage, email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OtherUserInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, nickName, profileImage, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OtherUserInfoCopyWith<_$_OtherUserInfo> get copyWith =>
      __$$_OtherUserInfoCopyWithImpl<_$_OtherUserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OtherUserInfoToJson(
      this,
    );
  }
}

abstract class _OtherUserInfo implements OtherUserInfo {
  factory _OtherUserInfo(
      {required final int id,
      final String? nickName,
      final String? profileImage,
      final String? email}) = _$_OtherUserInfo;

  factory _OtherUserInfo.fromJson(Map<String, dynamic> json) =
      _$_OtherUserInfo.fromJson;

  @override
  int get id;
  @override
  String? get nickName;
  @override
  String? get profileImage;
  @override
  String? get email;
  @override
  @JsonKey(ignore: true)
  _$$_OtherUserInfoCopyWith<_$_OtherUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
