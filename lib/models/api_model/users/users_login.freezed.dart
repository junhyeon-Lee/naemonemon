// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_login.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserLogin _$UserLoginFromJson(Map<String, dynamic> json) {
  return _UserLogin.fromJson(json);
}

/// @nodoc
mixin _$UserLogin {
  String get access_token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserLoginCopyWith<UserLogin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLoginCopyWith<$Res> {
  factory $UserLoginCopyWith(UserLogin value, $Res Function(UserLogin) then) =
      _$UserLoginCopyWithImpl<$Res, UserLogin>;
  @useResult
  $Res call({String access_token});
}

/// @nodoc
class _$UserLoginCopyWithImpl<$Res, $Val extends UserLogin>
    implements $UserLoginCopyWith<$Res> {
  _$UserLoginCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? access_token = null,
  }) {
    return _then(_value.copyWith(
      access_token: null == access_token
          ? _value.access_token
          : access_token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserLoginCopyWith<$Res> implements $UserLoginCopyWith<$Res> {
  factory _$$_UserLoginCopyWith(
          _$_UserLogin value, $Res Function(_$_UserLogin) then) =
      __$$_UserLoginCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String access_token});
}

/// @nodoc
class __$$_UserLoginCopyWithImpl<$Res>
    extends _$UserLoginCopyWithImpl<$Res, _$_UserLogin>
    implements _$$_UserLoginCopyWith<$Res> {
  __$$_UserLoginCopyWithImpl(
      _$_UserLogin _value, $Res Function(_$_UserLogin) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? access_token = null,
  }) {
    return _then(_$_UserLogin(
      access_token: null == access_token
          ? _value.access_token
          : access_token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserLogin implements _UserLogin {
  _$_UserLogin({required this.access_token});

  factory _$_UserLogin.fromJson(Map<String, dynamic> json) =>
      _$$_UserLoginFromJson(json);

  @override
  final String access_token;

  @override
  String toString() {
    return 'UserLogin(access_token: $access_token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserLogin &&
            (identical(other.access_token, access_token) ||
                other.access_token == access_token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, access_token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserLoginCopyWith<_$_UserLogin> get copyWith =>
      __$$_UserLoginCopyWithImpl<_$_UserLogin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserLoginToJson(
      this,
    );
  }
}

abstract class _UserLogin implements UserLogin {
  factory _UserLogin({required final String access_token}) = _$_UserLogin;

  factory _UserLogin.fromJson(Map<String, dynamic> json) =
      _$_UserLogin.fromJson;

  @override
  String get access_token;
  @override
  @JsonKey(ignore: true)
  _$$_UserLoginCopyWith<_$_UserLogin> get copyWith =>
      throw _privateConstructorUsedError;
}
