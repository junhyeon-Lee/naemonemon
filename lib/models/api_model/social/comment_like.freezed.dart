// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_like.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommentLike _$CommentLikeFromJson(Map<String, dynamic> json) {
  return _CommentLike.fromJson(json);
}

/// @nodoc
mixin _$CommentLike {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int? get pollId => throw _privateConstructorUsedError;
  int? get commentId => throw _privateConstructorUsedError;
  int get targetId => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentLikeCopyWith<CommentLike> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentLikeCopyWith<$Res> {
  factory $CommentLikeCopyWith(
          CommentLike value, $Res Function(CommentLike) then) =
      _$CommentLikeCopyWithImpl<$Res, CommentLike>;
  @useResult
  $Res call(
      {int id,
      int userId,
      int? pollId,
      int? commentId,
      int targetId,
      int type,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class _$CommentLikeCopyWithImpl<$Res, $Val extends CommentLike>
    implements $CommentLikeCopyWith<$Res> {
  _$CommentLikeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? pollId = freezed,
    Object? commentId = freezed,
    Object? targetId = null,
    Object? type = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      pollId: freezed == pollId
          ? _value.pollId
          : pollId // ignore: cast_nullable_to_non_nullable
              as int?,
      commentId: freezed == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as int?,
      targetId: null == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CommentLikeCopyWith<$Res>
    implements $CommentLikeCopyWith<$Res> {
  factory _$$_CommentLikeCopyWith(
          _$_CommentLike value, $Res Function(_$_CommentLike) then) =
      __$$_CommentLikeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int userId,
      int? pollId,
      int? commentId,
      int targetId,
      int type,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class __$$_CommentLikeCopyWithImpl<$Res>
    extends _$CommentLikeCopyWithImpl<$Res, _$_CommentLike>
    implements _$$_CommentLikeCopyWith<$Res> {
  __$$_CommentLikeCopyWithImpl(
      _$_CommentLike _value, $Res Function(_$_CommentLike) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? pollId = freezed,
    Object? commentId = freezed,
    Object? targetId = null,
    Object? type = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_CommentLike(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      pollId: freezed == pollId
          ? _value.pollId
          : pollId // ignore: cast_nullable_to_non_nullable
              as int?,
      commentId: freezed == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as int?,
      targetId: null == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CommentLike implements _CommentLike {
  _$_CommentLike(
      {required this.id,
      required this.userId,
      this.pollId,
      this.commentId,
      required this.targetId,
      required this.type,
      required this.createdAt,
      required this.updatedAt});

  factory _$_CommentLike.fromJson(Map<String, dynamic> json) =>
      _$$_CommentLikeFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final int? pollId;
  @override
  final int? commentId;
  @override
  final int targetId;
  @override
  final int type;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'CommentLike(id: $id, userId: $userId, pollId: $pollId, commentId: $commentId, targetId: $targetId, type: $type, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommentLike &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.pollId, pollId) || other.pollId == pollId) &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, pollId, commentId,
      targetId, type, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommentLikeCopyWith<_$_CommentLike> get copyWith =>
      __$$_CommentLikeCopyWithImpl<_$_CommentLike>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentLikeToJson(
      this,
    );
  }
}

abstract class _CommentLike implements CommentLike {
  factory _CommentLike(
      {required final int id,
      required final int userId,
      final int? pollId,
      final int? commentId,
      required final int targetId,
      required final int type,
      required final String createdAt,
      required final String updatedAt}) = _$_CommentLike;

  factory _CommentLike.fromJson(Map<String, dynamic> json) =
      _$_CommentLike.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  int? get pollId;
  @override
  int? get commentId;
  @override
  int get targetId;
  @override
  int get type;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_CommentLikeCopyWith<_$_CommentLike> get copyWith =>
      throw _privateConstructorUsedError;
}
