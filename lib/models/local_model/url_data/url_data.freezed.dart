// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'url_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UrlData _$UrlDataFromJson(Map<String, dynamic> json) {
  return _UrlData.fromJson(json);
}

/// @nodoc
mixin _$UrlData {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  List<String> get group => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UrlDataCopyWith<UrlData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlDataCopyWith<$Res> {
  factory $UrlDataCopyWith(UrlData value, $Res Function(UrlData) then) =
      _$UrlDataCopyWithImpl<$Res, UrlData>;
  @useResult
  $Res call(
      {String id,
      String url,
      String? image,
      String? title,
      List<String> group});
}

/// @nodoc
class _$UrlDataCopyWithImpl<$Res, $Val extends UrlData>
    implements $UrlDataCopyWith<$Res> {
  _$UrlDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? image = freezed,
    Object? title = freezed,
    Object? group = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UrlDataCopyWith<$Res> implements $UrlDataCopyWith<$Res> {
  factory _$$_UrlDataCopyWith(
          _$_UrlData value, $Res Function(_$_UrlData) then) =
      __$$_UrlDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String url,
      String? image,
      String? title,
      List<String> group});
}

/// @nodoc
class __$$_UrlDataCopyWithImpl<$Res>
    extends _$UrlDataCopyWithImpl<$Res, _$_UrlData>
    implements _$$_UrlDataCopyWith<$Res> {
  __$$_UrlDataCopyWithImpl(_$_UrlData _value, $Res Function(_$_UrlData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? image = freezed,
    Object? title = freezed,
    Object? group = null,
  }) {
    return _then(_$_UrlData(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      group: null == group
          ? _value._group
          : group // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UrlData implements _UrlData {
  _$_UrlData(
      {required this.id,
      required this.url,
      this.image,
      this.title,
      required final List<String> group})
      : _group = group;

  factory _$_UrlData.fromJson(Map<String, dynamic> json) =>
      _$$_UrlDataFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final String? image;
  @override
  final String? title;
  final List<String> _group;
  @override
  List<String> get group {
    if (_group is EqualUnmodifiableListView) return _group;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_group);
  }

  @override
  String toString() {
    return 'UrlData(id: $id, url: $url, image: $image, title: $title, group: $group)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UrlData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._group, _group));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, image, title,
      const DeepCollectionEquality().hash(_group));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UrlDataCopyWith<_$_UrlData> get copyWith =>
      __$$_UrlDataCopyWithImpl<_$_UrlData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UrlDataToJson(
      this,
    );
  }
}

abstract class _UrlData implements UrlData {
  factory _UrlData(
      {required final String id,
      required final String url,
      final String? image,
      final String? title,
      required final List<String> group}) = _$_UrlData;

  factory _UrlData.fromJson(Map<String, dynamic> json) = _$_UrlData.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String? get image;
  @override
  String? get title;
  @override
  List<String> get group;
  @override
  @JsonKey(ignore: true)
  _$$_UrlDataCopyWith<_$_UrlData> get copyWith =>
      throw _privateConstructorUsedError;
}
