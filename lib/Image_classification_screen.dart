import 'package:flutter/material.dart';
import 'package:shovving_pre/ui_helper/common_widget/common_appbar.dart';

class ImageClassficationScreen extends StatelessWidget {
  const ImageClassficationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CommonAppbar(title: '이미지 분류',),
    );
  }
}
