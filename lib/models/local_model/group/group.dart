import 'package:freezed_annotation/freezed_annotation.dart';
part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  factory Group({
    int? id,
    required String localId,
    required String groupName,
    required int groupColorId,
    required int groupIconId,
    int? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) =>
      _$GroupFromJson(json);
}

