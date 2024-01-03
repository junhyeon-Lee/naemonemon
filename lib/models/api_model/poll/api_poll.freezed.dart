// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_poll.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ApiPoll _$ApiPollFromJson(Map<String, dynamic> json) {
  return _ApiPoll.fromJson(json);
}

/// @nodoc
mixin _$ApiPoll {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get pollComment => throw _privateConstructorUsedError;
  String get itemIds => throw _privateConstructorUsedError;
  String get numberOfVotes => throw _privateConstructorUsedError;
  String get itemComment => throw _privateConstructorUsedError;
  String? get finalChoice => throw _privateConstructorUsedError;
  String? get finalComment => throw _privateConstructorUsedError;
  int get isDeleted => throw _privateConstructorUsedError;
  int get state => throw _privateConstructorUsedError;
  String get profileImage => throw _privateConstructorUsedError;
  int get colorIndex => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  List<Cart> get items => throw _privateConstructorUsedError;
  List<Like>? get likes => throw _privateConstructorUsedError;
  List<Comment>? get comments => throw _privateConstructorUsedError;
  String? get joins => throw _privateConstructorUsedError;
  PollUsersInfo? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiPollCopyWith<ApiPoll> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiPollCopyWith<$Res> {
  factory $ApiPollCopyWith(ApiPoll value, $Res Function(ApiPoll) then) =
      _$ApiPollCopyWithImpl<$Res, ApiPoll>;
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
      int state,
      String profileImage,
      int colorIndex,
      String createdAt,
      String? updatedAt,
      List<Cart> items,
      List<Like>? likes,
      List<Comment>? comments,
      String? joins,
      PollUsersInfo? user});

  $PollUsersInfoCopyWith<$Res>? get user;
}

/// @nodoc
class _$ApiPollCopyWithImpl<$Res, $Val extends ApiPoll>
    implements $ApiPollCopyWith<$Res> {
  _$ApiPollCopyWithImpl(this._value, this._then);

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
    Object? updatedAt = freezed,
    Object? items = null,
    Object? likes = freezed,
    Object? comments = freezed,
    Object? joins = freezed,
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
              as int,
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
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Cart>,
      likes: freezed == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<Like>?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>?,
      joins: freezed == joins
          ? _value.joins
          : joins // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_ApiPollCopyWith<$Res> implements $ApiPollCopyWith<$Res> {
  factory _$$_ApiPollCopyWith(
          _$_ApiPoll value, $Res Function(_$_ApiPoll) then) =
      __$$_ApiPollCopyWithImpl<$Res>;
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
      int state,
      String profileImage,
      int colorIndex,
      String createdAt,
      String? updatedAt,
      List<Cart> items,
      List<Like>? likes,
      List<Comment>? comments,
      String? joins,
      PollUsersInfo? user});

  @override
  $PollUsersInfoCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_ApiPollCopyWithImpl<$Res>
    extends _$ApiPollCopyWithImpl<$Res, _$_ApiPoll>
    implements _$$_ApiPollCopyWith<$Res> {
  __$$_ApiPollCopyWithImpl(_$_ApiPoll _value, $Res Function(_$_ApiPoll) _then)
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
    Object? updatedAt = freezed,
    Object? items = null,
    Object? likes = freezed,
    Object? comments = freezed,
    Object? joins = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_ApiPoll(
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
              as int,
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
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Cart>,
      likes: freezed == likes
          ? _value._likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<Like>?,
      comments: freezed == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>?,
      joins: freezed == joins
          ? _value.joins
          : joins // ignore: cast_nullable_to_non_nullable
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
class _$_ApiPoll implements _ApiPoll {
  _$_ApiPoll(
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
      this.updatedAt,
      required final List<Cart> items,
      final List<Like>? likes,
      final List<Comment>? comments,
      this.joins,
      this.user})
      : _items = items,
        _likes = likes,
        _comments = comments;

  factory _$_ApiPoll.fromJson(Map<String, dynamic> json) =>
      _$$_ApiPollFromJson(json);

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
  final int state;
  @override
  final String profileImage;
  @override
  final int colorIndex;
  @override
  final String createdAt;
  @override
  final String? updatedAt;
  final List<Cart> _items;
  @override
  List<Cart> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<Like>? _likes;
  @override
  List<Like>? get likes {
    final value = _likes;
    if (value == null) return null;
    if (_likes is EqualUnmodifiableListView) return _likes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Comment>? _comments;
  @override
  List<Comment>? get comments {
    final value = _comments;
    if (value == null) return null;
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? joins;
  @override
  final PollUsersInfo? user;

  @override
  String toString() {
    return 'ApiPoll(id: $id, userId: $userId, pollComment: $pollComment, itemIds: $itemIds, numberOfVotes: $numberOfVotes, itemComment: $itemComment, finalChoice: $finalChoice, finalComment: $finalComment, isDeleted: $isDeleted, state: $state, profileImage: $profileImage, colorIndex: $colorIndex, createdAt: $createdAt, updatedAt: $updatedAt, items: $items, likes: $likes, comments: $comments, joins: $joins, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApiPoll &&
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
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other._likes, _likes) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.joins, joins) || other.joins == joins) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
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
        updatedAt,
        const DeepCollectionEquality().hash(_items),
        const DeepCollectionEquality().hash(_likes),
        const DeepCollectionEquality().hash(_comments),
        joins,
        user
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApiPollCopyWith<_$_ApiPoll> get copyWith =>
      __$$_ApiPollCopyWithImpl<_$_ApiPoll>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ApiPollToJson(
      this,
    );
  }
}

abstract class _ApiPoll implements ApiPoll {
  factory _ApiPoll(
      {required final int id,
      required final int userId,
      required final String pollComment,
      required final String itemIds,
      required final String numberOfVotes,
      required final String itemComment,
      final String? finalChoice,
      final String? finalComment,
      required final int isDeleted,
      required final int state,
      required final String profileImage,
      required final int colorIndex,
      required final String createdAt,
      final String? updatedAt,
      required final List<Cart> items,
      final List<Like>? likes,
      final List<Comment>? comments,
      final String? joins,
      final PollUsersInfo? user}) = _$_ApiPoll;

  factory _ApiPoll.fromJson(Map<String, dynamic> json) = _$_ApiPoll.fromJson;

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
  int get state;
  @override
  String get profileImage;
  @override
  int get colorIndex;
  @override
  String get createdAt;
  @override
  String? get updatedAt;
  @override
  List<Cart> get items;
  @override
  List<Like>? get likes;
  @override
  List<Comment>? get comments;
  @override
  String? get joins;
  @override
  PollUsersInfo? get user;
  @override
  @JsonKey(ignore: true)
  _$$_ApiPollCopyWith<_$_ApiPoll> get copyWith =>
      throw _privateConstructorUsedError;
}
