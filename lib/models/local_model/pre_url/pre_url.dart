import 'package:freezed_annotation/freezed_annotation.dart';
part 'pre_url.freezed.dart';
part 'pre_url.g.dart';

@freezed
class PreUrl with _$PreUrl {
  factory PreUrl({
    required String image,
    required String url,
    required String name,
  }) = _PreUrl;

  factory PreUrl.fromJson(Map<String, dynamic> json) =>
      _$PreUrlFromJson(json);
}

