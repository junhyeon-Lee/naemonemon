import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showDefaultDialog(String text, String confirmText, String cancelText, Function() onConfirm, Function() onCancel) {
  Get.defaultDialog(
    title: '알림',
    content : Text(text),
    textConfirm: confirmText,
    confirmTextColor: Colors.white,
    onConfirm: onConfirm,
    textCancel: cancelText,
    onCancel: onCancel
  );
}
