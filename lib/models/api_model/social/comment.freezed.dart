// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get side => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  int get isDeleted => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  List<CommentLike> get likes => throw _privateConstructorUsedError;
  OtherUserInfo get user => throw _privateConstructorUsedError;
  int? get likeLength => throw _privateConstructorUsedError;
  bool? get like => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {int id,
      int userId,
      String side,
      String comment,
      int isDeleted,
      String createdAt,
      String updatedAt,
      List<CommentLike> likes,
      OtherUserInfo user,
      int? likeLength,
      bool? like});

  $OtherUserInfoCopyWith<$Res> get user;
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? side = null,
    Object? comment = null,
    Object? isDeleted = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? likes = null,
    Object? user = null,
    Object? likeLength = freezed,
    Object? like = freezed,
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
      side: null == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<CommentLike>,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as OtherUserInfo,
      likeLength: freezed == likeLength
          ? _value.likeLength
          : likeLength // ignore: cast_nullable_to_non_nullable
              as int?,
      like: freezed == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OtherUserInfoCopyWith<$Res> get user {
    return $OtherUserInfoCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$_CommentCopyWith(
          _$_Comment value, $Res Function(_$_Comment) then) =
      __$$_CommentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int userId,
      String side,
      String comment,
      int isDeleted,
      String createdAt,
      String updatedAt,
      List<CommentLike> likes,
      OtherUserInfo user,
      int? likeLength,
      bool? like});

  @override
  $OtherUserInfoCopyWith<$Res> get user;
}

/// @nodoc
class __$$_CommentCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$_Comment>
    implements _$$_CommentCopyWith<$Res> {
  __$$_CommentCopyWithImpl(_$_Comment _value, $Res Function(_$_Comment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? side = null,
    Object? comment = null,
    Object? isDeleted = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? likes = null,
    Object? user = null,
    Object? likeLength = freezed,
    Object? like = freezed,
  }) {
    return _then(_$_Comment(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      side: null == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value._likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<CommentLike>,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as OtherUserInfo,
      likeLength: freezed == likeLength
          ? _value.likeLength
          : likeLength // ignore: cast_nullable_to_non_nullable
              as int?,
      like: freezed == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Comment implements _Comment {
  _$_Comment(
      {required this.id,
      required this.userId,
      required this.side,
      required this.comment,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt,
      required final List<CommentLike> likes,
      required this.user,
      this.likeLength,
      this.like})
      : _likes = likes;

  factory _$_Comment.fromJson(Map<String, dynamic> json) =>
      _$$_CommentFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final String side;
  @override
  final String comment;
  @override
  final int isDeleted;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  final List<CommentLike> _likes;
  @override
  List<CommentLike> get likes {
    if (_likes is EqualUnmodifiableListView) return _likes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likes);
  }

  @override
  final OtherUserInfo user;
  @override
  final int? likeLength;
  @override
  final bool? like;

  @override
  String toString() {
    return 'Comment(id: $id, userId: $userId, side: $side, comment: $comment, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, likes: $likes, user: $user, likeLength: $likeLength, like: $like)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Comment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.side, side) || other.side == side) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._likes, _likes) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.likeLength, likeLength) ||
                other.likeLength == likeLength) &&
            (identical(other.like, like) || other.like == like));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      side,
      comment,
      isDeleted,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_likes),
      user,
      likeLength,
      like);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommentCopyWith<_$_Comment> get copyWith =>
      __$$_CommentCopyWithImpl<_$_Comment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentToJson(
      this,
    );
  }
}

abstract class _Comment implements Comment {
  factory _Comment(
      {required final int id,
      required final int userId,
      required final String side,
      required final String comment,
      required final int isDeleted,
      required final String createdAt,
      required final String updatedAt,
      required final List<CommentLike> likes,
      required final OtherUserInfo user,
      final int? likeLength,
      final bool? like}) = _$_Comment;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$_Comment.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get side;
  @override
  String get comment;
  @override
  int get isDeleted;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  List<CommentLike> get likes;
  @override
  OtherUserInfo get user;
  @override
  int? get likeLength;
  @override
  bool? get like;
  @override
  @JsonKey(ignore: true)
  _$$_CommentCopyWith<_$_Comment> get copyWith =>
      throw _privateConstructorUsedError;
}
