// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupList _$GroupListFromJson(Map<String, dynamic> json) {
  return _GroupList.fromJson(json);
}

/// @nodoc
mixin _$GroupList {
  List<Group> get groupList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupListCopyWith<GroupList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupListCopyWith<$Res> {
  factory $GroupListCopyWith(GroupList value, $Res Function(GroupList) then) =
      _$GroupListCopyWithImpl<$Res, GroupList>;
  @useResult
  $Res call({List<Group> groupList});
}

/// @nodoc
class _$GroupListCopyWithImpl<$Res, $Val extends GroupList>
    implements $GroupListCopyWith<$Res> {
  _$GroupListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupList = null,
  }) {
    return _then(_value.copyWith(
      groupList: null == groupList
          ? _value.groupList
          : groupList // ignore: cast_nullable_to_non_nullable
              as List<Group>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupListCopyWith<$Res> implements $GroupListCopyWith<$Res> {
  factory _$$_GroupListCopyWith(
          _$_GroupList value, $Res Function(_$_GroupList) then) =
      __$$_GroupListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Group> groupList});
}

/// @nodoc
class __$$_GroupListCopyWithImpl<$Res>
    extends _$GroupListCopyWithImpl<$Res, _$_GroupList>
    implements _$$_GroupListCopyWith<$Res> {
  __$$_GroupListCopyWithImpl(
      _$_GroupList _value, $Res Function(_$_GroupList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupList = null,
  }) {
    return _then(_$_GroupList(
      groupList: null == groupList
          ? _value._groupList
          : groupList // ignore: cast_nullable_to_non_nullable
              as List<Group>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupList implements _GroupList {
  _$_GroupList({required final List<Group> groupList}) : _groupList = groupList;

  factory _$_GroupList.fromJson(Map<String, dynamic> json) =>
      _$$_GroupListFromJson(json);

  final List<Group> _groupList;
  @override
  List<Group> get groupList {
    if (_groupList is EqualUnmodifiableListView) return _groupList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groupList);
  }

  @override
  String toString() {
    return 'GroupList(groupList: $groupList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupList &&
            const DeepCollectionEquality()
                .equals(other._groupList, _groupList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_groupList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupListCopyWith<_$_GroupList> get copyWith =>
      __$$_GroupListCopyWithImpl<_$_GroupList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupListToJson(
      this,
    );
  }
}

abstract class _GroupList implements GroupList {
  factory _GroupList({required final List<Group> groupList}) = _$_GroupList;

  factory _GroupList.fromJson(Map<String, dynamic> json) =
      _$_GroupList.fromJson;

  @override
  List<Group> get groupList;
  @override
  @JsonKey(ignore: true)
  _$$_GroupListCopyWith<_$_GroupList> get copyWith =>
      throw _privateConstructorUsedError;
}
