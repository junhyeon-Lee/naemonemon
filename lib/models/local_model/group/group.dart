import 'package:freezed_annotation/freezed_annotation.dart';
part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  factory Group({
    required String groupName,
    required String groupId,
    required int groupColorId,
    required int groupIconId,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) =>
      _$GroupFromJson(json);
}

