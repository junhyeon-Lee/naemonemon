import 'package:freezed_annotation/freezed_annotation.dart';
part 'cart.freezed.dart';
part 'cart.g.dart';

@freezed
class Cart with _$Cart {
  factory Cart({
    int? id,
    int? userID,
    required String localId,
    required String url,
    String? image,
    String? title,
    required String groupIds,
    int? isDeleted,
    String? createdAt,
    String? updatedAt,
    int? numberOfVote
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) =>
      _$CartFromJson(json);
}

