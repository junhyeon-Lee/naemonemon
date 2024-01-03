import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shovving_pre/models/local_model/group/group.dart';
part 'group_list.freezed.dart';
part 'group_list.g.dart';

@freezed
class GroupList with _$GroupList {
  factory GroupList({
    required List<Group> groupList,
  }) = _GroupList;

  factory GroupList.fromJson(Map<String, dynamic> json) => _$GroupListFromJson(json);
}

