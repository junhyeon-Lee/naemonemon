// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'callback_poll.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CallBackPoll _$CallBackPollFromJson(Map<String, dynamic> json) {
  return _CallBackPoll.fromJson(json);
}

/// @nodoc
mixin _$CallBackPoll {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get pollComment => throw _privateConstructorUsedError;
  String get itemIds => throw _privateConstructorUsedError;
  String get numberOfVotes => throw _privateConstructorUsedError;
  String get itemComment => throw _privateConstructorUsedError;
  String? get finalChoice => throw _privateConstructorUsedError;
  String? get finalComment => throw _privateConstructorUsedError;
  int get isDeleted => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get profileImage => throw _privateConstructorUsedError;
  int get colorIndex => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get joins => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  PollUsersInfo? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CallBackPollCopyWith<CallBackPoll> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallBackPollCopyWith<$Res> {
  factory $CallBackPollCopyWith(
          CallBackPoll value, $Res Function(CallBackPoll) then) =
      _$CallBackPollCopyWithImpl<$Res, CallBackPoll>;
  @useResult
  $Res call(
      {int id,
      int userId,
      String pollComment,
      String itemIds,
      String numberOfVotes,
      String itemComment,
      String? finalChoice,
      String? finalComment,
      int isDeleted,
      String state,
      String profileImage,
      int colorIndex,
      String createdAt,
      String? joins,
      String? updatedAt,
      PollUsersInfo? user});

  $PollUsersInfoCopyWith<$Res>? get user;
}

/// @nodoc
class _$CallBackPollCopyWithImpl<$Res, $Val extends CallBackPoll>
    implements $CallBackPollCopyWith<$Res> {
  _$CallBackPollCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? pollComment = null,
    Object? itemIds = null,
    Object? numberOfVotes = null,
    Object? itemComment = null,
    Object? finalChoice = freezed,
    Object? finalComment = freezed,
    Object? isDeleted = null,
    Object? state = null,
    Object? profileImage = null,
    Object? colorIndex = null,
    Object? createdAt = null,
    Object? joins = freezed,
    Object? updatedAt = freezed,
    Object? user = freezed,
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
      pollComment: null == pollComment
          ? _value.pollComment
          : pollComment // ignore: cast_nullable_to_non_nullable
              as String,
      itemIds: null == itemIds
          ? _value.itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfVotes: null == numberOfVotes
          ? _value.numberOfVotes
          : numberOfVotes // ignore: cast_nullable_to_non_nullable
              as String,
      itemComment: null == itemComment
          ? _value.itemComment
          : itemComment // ignore: cast_nullable_to_non_nullable
              as String,
      finalChoice: freezed == finalChoice
          ? _value.finalChoice
          : finalChoice // ignore: cast_nullable_to_non_nullable
              as String?,
      finalComment: freezed == finalComment
          ? _value.finalComment
          : finalComment // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
      colorIndex: null == colorIndex
          ? _value.colorIndex
          : colorIndex // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      joins: freezed == joins
          ? _value.joins
          : joins // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PollUsersInfo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PollUsersInfoCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $PollUsersInfoCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CallBackPollCopyWith<$Res>
    implements $CallBackPollCopyWith<$Res> {
  factory _$$_CallBackPollCopyWith(
          _$_CallBackPoll value, $Res Function(_$_CallBackPoll) then) =
      __$$_CallBackPollCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int userId,
      String pollComment,
      String itemIds,
      String numberOfVotes,
      String itemComment,
      String? finalChoice,
      String? finalComment,
      int isDeleted,
      String state,
      String profileImage,
      int colorIndex,
      String createdAt,
      String? joins,
      String? updatedAt,
      PollUsersInfo? user});

  @override
  $PollUsersInfoCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_CallBackPollCopyWithImpl<$Res>
    extends _$CallBackPollCopyWithImpl<$Res, _$_CallBackPoll>
    implements _$$_CallBackPollCopyWith<$Res> {
  __$$_CallBackPollCopyWithImpl(
      _$_CallBackPoll _value, $Res Function(_$_CallBackPoll) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? pollComment = null,
    Object? itemIds = null,
    Object? numberOfVotes = null,
    Object? itemComment = null,
    Object? finalChoice = freezed,
    Object? finalComment = freezed,
    Object? isDeleted = null,
    Object? state = null,
    Object? profileImage = null,
    Object? colorIndex = null,
    Object? createdAt = null,
    Object? joins = freezed,
    Object? updatedAt = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_CallBackPoll(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      pollComment: null == pollComment
          ? _value.pollComment
          : pollComment // ignore: cast_nullable_to_non_nullable
              as String,
      itemIds: null == itemIds
          ? _value.itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfVotes: null == numberOfVotes
          ? _value.numberOfVotes
          : numberOfVotes // ignore: cast_nullable_to_non_nullable
              as String,
      itemComment: null == itemComment
          ? _value.itemComment
          : itemComment // ignore: cast_nullable_to_non_nullable
              as String,
      finalChoice: freezed == finalChoice
          ? _value.finalChoice
          : finalChoice // ignore: cast_nullable_to_non_nullable
              as String?,
      finalComment: freezed == finalComment
          ? _value.finalComment
          : finalComment // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
      colorIndex: null == colorIndex
          ? _value.colorIndex
          : colorIndex // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      joins: freezed == joins
          ? _value.joins
          : joins // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PollUsersInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CallBackPoll implements _CallBackPoll {
  _$_CallBackPoll(
      {required this.id,
      required this.userId,
      required this.pollComment,
      required this.itemIds,
      required this.numberOfVotes,
      required this.itemComment,
      this.finalChoice,
      this.finalComment,
      required this.isDeleted,
      required this.state,
      required this.profileImage,
      required this.colorIndex,
      required this.createdAt,
      this.joins,
      this.updatedAt,
      this.user});

  factory _$_CallBackPoll.fromJson(Map<String, dynamic> json) =>
      _$$_CallBackPollFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final String pollComment;
  @override
  final String itemIds;
  @override
  final String numberOfVotes;
  @override
  final String itemComment;
  @override
  final String? finalChoice;
  @override
  final String? finalComment;
  @override
  final int isDeleted;
  @override
  final String state;
  @override
  final String profileImage;
  @override
  final int colorIndex;
  @override
  final String createdAt;
  @override
  final String? joins;
  @override
  final String? updatedAt;
  @override
  final PollUsersInfo? user;

  @override
  String toString() {
    return 'CallBackPoll(id: $id, userId: $userId, pollComment: $pollComment, itemIds: $itemIds, numberOfVotes: $numberOfVotes, itemComment: $itemComment, finalChoice: $finalChoice, finalComment: $finalComment, isDeleted: $isDeleted, state: $state, profileImage: $profileImage, colorIndex: $colorIndex, createdAt: $createdAt, joins: $joins, updatedAt: $updatedAt, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallBackPoll &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.pollComment, pollComment) ||
                other.pollComment == pollComment) &&
            (identical(other.itemIds, itemIds) || other.itemIds == itemIds) &&
            (identical(other.numberOfVotes, numberOfVotes) ||
                other.numberOfVotes == numberOfVotes) &&
            (identical(other.itemComment, itemComment) ||
                other.itemComment == itemComment) &&
            (identical(other.finalChoice, finalChoice) ||
                other.finalChoice == finalChoice) &&
            (identical(other.finalComment, finalComment) ||
                other.finalComment == finalComment) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.colorIndex, colorIndex) ||
                other.colorIndex == colorIndex) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.joins, joins) || other.joins == joins) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      pollComment,
      itemIds,
      numberOfVotes,
      itemComment,
      finalChoice,
      finalComment,
      isDeleted,
      state,
      profileImage,
      colorIndex,
      createdAt,
      joins,
      updatedAt,
      user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CallBackPollCopyWith<_$_CallBackPoll> get copyWith =>
      __$$_CallBackPollCopyWithImpl<_$_CallBackPoll>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CallBackPollToJson(
      this,
    );
  }
}

abstract class _CallBackPoll implements CallBackPoll {
  factory _CallBackPoll(
      {required final int id,
      required final int userId,
      required final String pollComment,
      required final String itemIds,
      required final String numberOfVotes,
      required final String itemComment,
      final String? finalChoice,
      final String? finalComment,
      required final int isDeleted,
      required final String state,
      required final String profileImage,
      required final int colorIndex,
      required final String createdAt,
      final String? joins,
      final String? updatedAt,
      final PollUsersInfo? user}) = _$_CallBackPoll;

  factory _CallBackPoll.fromJson(Map<String, dynamic> json) =
      _$_CallBackPoll.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get pollComment;
  @override
  String get itemIds;
  @override
  String get numberOfVotes;
  @override
  String get itemComment;
  @override
  String? get finalChoice;
  @override
  String? get finalComment;
  @override
  int get isDeleted;
  @override
  String get state;
  @override
  String get profileImage;
  @override
  int get colorIndex;
  @override
  String get createdAt;
  @override
  String? get joins;
  @override
  String? get updatedAt;
  @override
  PollUsersInfo? get user;
  @override
  @JsonKey(ignore: true)
  _$$_CallBackPollCopyWith<_$_CallBackPoll> get copyWith =>
      throw _privateConstructorUsedError;
}
