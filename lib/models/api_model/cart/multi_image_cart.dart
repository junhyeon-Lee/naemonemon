import 'package:freezed_annotation/freezed_annotation.dart';
part 'multi_image_cart.freezed.dart';
part 'multi_image_cart.g.dart';

@freezed
class MultiImageCart with _$MultiImageCart {
  factory MultiImageCart({
    int? id,
    int? userID,
    required String localId,
    required String url,
    required List<String> image,
    String? title,
    required String groupIds,
    int? isDeleted,
    String? createdAt,
    String? updatedAt
  }) = _MultiImageCart;

  factory MultiImageCart.fromJson(Map<String, dynamic> json) =>
      _$MultiImageCartFromJson(json);
}

