import 'package:flutter/foundation.dart';

void safePrint(dynamic value) {
  if (kReleaseMode) {
    return;
  } else if (kDebugMode) {
    debugPrint(value.toString());
  }
}
