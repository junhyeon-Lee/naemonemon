import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shovving_pre/models/local_model/group/group.dart';
part 'url_data.freezed.dart';
part 'url_data.g.dart';

@freezed
class UrlData with _$UrlData {
  factory UrlData({
    required String id,
    required String url,
    String? image,
    String? title,
    required List<String> group,
  }) = _UrlData;

  factory UrlData.fromJson(Map<String, dynamic> json) =>
      _$UrlDataFromJson(json);
}

