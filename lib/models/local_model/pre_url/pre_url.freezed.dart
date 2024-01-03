// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_url.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PreUrl _$PreUrlFromJson(Map<String, dynamic> json) {
  return _PreUrl.fromJson(json);
}

/// @nodoc
mixin _$PreUrl {
  String get image => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreUrlCopyWith<PreUrl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreUrlCopyWith<$Res> {
  factory $PreUrlCopyWith(PreUrl value, $Res Function(PreUrl) then) =
      _$PreUrlCopyWithImpl<$Res, PreUrl>;
  @useResult
  $Res call({String image, String url, String name});
}

/// @nodoc
class _$PreUrlCopyWithImpl<$Res, $Val extends PreUrl>
    implements $PreUrlCopyWith<$Res> {
  _$PreUrlCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? url = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PreUrlCopyWith<$Res> implements $PreUrlCopyWith<$Res> {
  factory _$$_PreUrlCopyWith(_$_PreUrl value, $Res Function(_$_PreUrl) then) =
      __$$_PreUrlCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String image, String url, String name});
}

/// @nodoc
class __$$_PreUrlCopyWithImpl<$Res>
    extends _$PreUrlCopyWithImpl<$Res, _$_PreUrl>
    implements _$$_PreUrlCopyWith<$Res> {
  __$$_PreUrlCopyWithImpl(_$_PreUrl _value, $Res Function(_$_PreUrl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? url = null,
    Object? name = null,
  }) {
    return _then(_$_PreUrl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PreUrl implements _PreUrl {
  _$_PreUrl({required this.image, required this.url, required this.name});

  factory _$_PreUrl.fromJson(Map<String, dynamic> json) =>
      _$$_PreUrlFromJson(json);

  @override
  final String image;
  @override
  final String url;
  @override
  final String name;

  @override
  String toString() {
    return 'PreUrl(image: $image, url: $url, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PreUrl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, image, url, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PreUrlCopyWith<_$_PreUrl> get copyWith =>
      __$$_PreUrlCopyWithImpl<_$_PreUrl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PreUrlToJson(
      this,
    );
  }
}

abstract class _PreUrl implements PreUrl {
  factory _PreUrl(
      {required final String image,
      required final String url,
      required final String name}) = _$_PreUrl;

  factory _PreUrl.fromJson(Map<String, dynamic> json) = _$_PreUrl.fromJson;

  @override
  String get image;
  @override
  String get url;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_PreUrlCopyWith<_$_PreUrl> get copyWith =>
      throw _privateConstructorUsedError;
}
