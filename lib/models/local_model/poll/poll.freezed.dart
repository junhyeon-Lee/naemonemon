// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Poll _$PollFromJson(Map<String, dynamic> json) {
  return _Poll.fromJson(json);
}

/// @nodoc
mixin _$Poll {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get pollComment => throw _privateConstructorUsedError;
  String get itemIds => throw _privateConstructorUsedError;
  List<int> get numberOfVotes => throw _privateConstructorUsedError;
  List<String> get itemComment => throw _privateConstructorUsedError;
  List<int>? get finalChoice => throw _privateConstructorUsedError;
  String? get finalComment => throw _privateConstructorUsedError;
  int get isDeleted => throw _privateConstructorUsedError;
  int get state => throw _privateConstructorUsedError;
  String get profileImage => throw _privateConstructorUsedError;
  int get colorIndex => throw _privateConstructorUsedError;
  String get createAt => throw _privateConstructorUsedError;
  String? get updateAt => throw _privateConstructorUsedError;
  List<Cart> get items => throw _privateConstructorUsedError;
  bool get like => throw _privateConstructorUsedError;
  int get likeLength => throw _privateConstructorUsedError;
  List<Comment> get comments => throw _privateConstructorUsedError;
  List<int>? get joins => throw _privateConstructorUsedError;
  PollUsersInfo? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollCopyWith<Poll> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollCopyWith<$Res> {
  factory $PollCopyWith(Poll value, $Res Function(Poll) then) =
      _$PollCopyWithImpl<$Res, Poll>;
  @useResult
  $Res call(
      {int id,
      int userId,
      String pollComment,
      String itemIds,
      List<int> numberOfVotes,
      List<String> itemComment,
      List<int>? finalChoice,
      String? finalComment,
      int isDeleted,
      int state,
      String profileImage,
      int colorIndex,
      String createAt,
      String? updateAt,
      List<Cart> items,
      bool like,
      int likeLength,
      List<Comment> comments,
      List<int>? joins,
      PollUsersInfo? user});

  $PollUsersInfoCopyWith<$Res>? get user;
}

/// @nodoc
class _$PollCopyWithImpl<$Res, $Val extends Poll>
    implements $PollCopyWith<$Res> {
  _$PollCopyWithImpl(this._value, this._then);

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
    Object? createAt = null,
    Object? updateAt = freezed,
    Object? items = null,
    Object? like = null,
    Object? likeLength = null,
    Object? comments = null,
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
              as List<int>,
      itemComment: null == itemComment
          ? _value.itemComment
          : itemComment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      finalChoice: freezed == finalChoice
          ? _value.finalChoice
          : finalChoice // ignore: cast_nullable_to_non_nullable
              as List<int>?,
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
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as String,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Cart>,
      like: null == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as bool,
      likeLength: null == likeLength
          ? _value.likeLength
          : likeLength // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
      joins: freezed == joins
          ? _value.joins
          : joins // ignore: cast_nullable_to_non_nullable
              as List<int>?,
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
abstract class _$$_PollCopyWith<$Res> implements $PollCopyWith<$Res> {
  factory _$$_PollCopyWith(_$_Poll value, $Res Function(_$_Poll) then) =
      __$$_PollCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int userId,
      String pollComment,
      String itemIds,
      List<int> numberOfVotes,
      List<String> itemComment,
      List<int>? finalChoice,
      String? finalComment,
      int isDeleted,
      int state,
      String profileImage,
      int colorIndex,
      String createAt,
      String? updateAt,
      List<Cart> items,
      bool like,
      int likeLength,
      List<Comment> comments,
      List<int>? joins,
      PollUsersInfo? user});

  @override
  $PollUsersInfoCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_PollCopyWithImpl<$Res> extends _$PollCopyWithImpl<$Res, _$_Poll>
    implements _$$_PollCopyWith<$Res> {
  __$$_PollCopyWithImpl(_$_Poll _value, $Res Function(_$_Poll) _then)
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
    Object? createAt = null,
    Object? updateAt = freezed,
    Object? items = null,
    Object? like = null,
    Object? likeLength = null,
    Object? comments = null,
    Object? joins = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_Poll(
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
          ? _value._numberOfVotes
          : numberOfVotes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      itemComment: null == itemComment
          ? _value._itemComment
          : itemComment // ignore: cast_nullable_to_non_nullable
              as List<String>,
      finalChoice: freezed == finalChoice
          ? _value._finalChoice
          : finalChoice // ignore: cast_nullable_to_non_nullable
              as List<int>?,
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
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as String,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Cart>,
      like: null == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as bool,
      likeLength: null == likeLength
          ? _value.likeLength
          : likeLength // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
      joins: freezed == joins
          ? _value._joins
          : joins // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PollUsersInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Poll implements _Poll {
  _$_Poll(
      {required this.id,
      required this.userId,
      required this.pollComment,
      required this.itemIds,
      required final List<int> numberOfVotes,
      required final List<String> itemComment,
      final List<int>? finalChoice,
      this.finalComment,
      required this.isDeleted,
      required this.state,
      required this.profileImage,
      required this.colorIndex,
      required this.createAt,
      this.updateAt,
      required final List<Cart> items,
      required this.like,
      required this.likeLength,
      required final List<Comment> comments,
      final List<int>? joins,
      this.user})
      : _numberOfVotes = numberOfVotes,
        _itemComment = itemComment,
        _finalChoice = finalChoice,
        _items = items,
        _comments = comments,
        _joins = joins;

  factory _$_Poll.fromJson(Map<String, dynamic> json) => _$$_PollFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final String pollComment;
  @override
  final String itemIds;
  final List<int> _numberOfVotes;
  @override
  List<int> get numberOfVotes {
    if (_numberOfVotes is EqualUnmodifiableListView) return _numberOfVotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_numberOfVotes);
  }

  final List<String> _itemComment;
  @override
  List<String> get itemComment {
    if (_itemComment is EqualUnmodifiableListView) return _itemComment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemComment);
  }

  final List<int>? _finalChoice;
  @override
  List<int>? get finalChoice {
    final value = _finalChoice;
    if (value == null) return null;
    if (_finalChoice is EqualUnmodifiableListView) return _finalChoice;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
  final String createAt;
  @override
  final String? updateAt;
  final List<Cart> _items;
  @override
  List<Cart> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool like;
  @override
  final int likeLength;
  final List<Comment> _comments;
  @override
  List<Comment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  final List<int>? _joins;
  @override
  List<int>? get joins {
    final value = _joins;
    if (value == null) return null;
    if (_joins is EqualUnmodifiableListView) return _joins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final PollUsersInfo? user;

  @override
  String toString() {
    return 'Poll(id: $id, userId: $userId, pollComment: $pollComment, itemIds: $itemIds, numberOfVotes: $numberOfVotes, itemComment: $itemComment, finalChoice: $finalChoice, finalComment: $finalComment, isDeleted: $isDeleted, state: $state, profileImage: $profileImage, colorIndex: $colorIndex, createAt: $createAt, updateAt: $updateAt, items: $items, like: $like, likeLength: $likeLength, comments: $comments, joins: $joins, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Poll &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.pollComment, pollComment) ||
                other.pollComment == pollComment) &&
            (identical(other.itemIds, itemIds) || other.itemIds == itemIds) &&
            const DeepCollectionEquality()
                .equals(other._numberOfVotes, _numberOfVotes) &&
            const DeepCollectionEquality()
                .equals(other._itemComment, _itemComment) &&
            const DeepCollectionEquality()
                .equals(other._finalChoice, _finalChoice) &&
            (identical(other.finalComment, finalComment) ||
                other.finalComment == finalComment) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.colorIndex, colorIndex) ||
                other.colorIndex == colorIndex) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.like, like) || other.like == like) &&
            (identical(other.likeLength, likeLength) ||
                other.likeLength == likeLength) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            const DeepCollectionEquality().equals(other._joins, _joins) &&
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
        const DeepCollectionEquality().hash(_numberOfVotes),
        const DeepCollectionEquality().hash(_itemComment),
        const DeepCollectionEquality().hash(_finalChoice),
        finalComment,
        isDeleted,
        state,
        profileImage,
        colorIndex,
        createAt,
        updateAt,
        const DeepCollectionEquality().hash(_items),
        like,
        likeLength,
        const DeepCollectionEquality().hash(_comments),
        const DeepCollectionEquality().hash(_joins),
        user
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PollCopyWith<_$_Poll> get copyWith =>
      __$$_PollCopyWithImpl<_$_Poll>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PollToJson(
      this,
    );
  }
}

abstract class _Poll implements Poll {
  factory _Poll(
      {required final int id,
      required final int userId,
      required final String pollComment,
      required final String itemIds,
      required final List<int> numberOfVotes,
      required final List<String> itemComment,
      final List<int>? finalChoice,
      final String? finalComment,
      required final int isDeleted,
      required final int state,
      required final String profileImage,
      required final int colorIndex,
      required final String createAt,
      final String? updateAt,
      required final List<Cart> items,
      required final bool like,
      required final int likeLength,
      required final List<Comment> comments,
      final List<int>? joins,
      final PollUsersInfo? user}) = _$_Poll;

  factory _Poll.fromJson(Map<String, dynamic> json) = _$_Poll.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get pollComment;
  @override
  String get itemIds;
  @override
  List<int> get numberOfVotes;
  @override
  List<String> get itemComment;
  @override
  List<int>? get finalChoice;
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
  String get createAt;
  @override
  String? get updateAt;
  @override
  List<Cart> get items;
  @override
  bool get like;
  @override
  int get likeLength;
  @override
  List<Comment> get comments;
  @override
  List<int>? get joins;
  @override
  PollUsersInfo? get user;
  @override
  @JsonKey(ignore: true)
  _$$_PollCopyWith<_$_Poll> get copyWith => throw _privateConstructorUsedError;
}
