import 'package:flutter/material.dart';

class LinkViewHorizontal extends StatelessWidget {
  final String url;
  final String title;
  final String description;
  final ImageProvider? imageProvider;
  final Function() onTap;
  final TextStyle? titleTextStyle;
  final TextStyle? bodyTextStyle;
  final bool? showMultiMedia;
  final TextOverflow? bodyTextOverflow;
  final int? bodyMaxLines;
  final double? radius;
  final Color? bgColor;

  const LinkViewHorizontal({
    Key? key,
    required this.url,
    required this.title,
    required this.description,
    required this.imageProvider,
    required this.onTap,
    this.titleTextStyle,
    this.bodyTextStyle,
    this.showMultiMedia,
    this.bodyTextOverflow,
    this.bodyMaxLines,
    this.bgColor,
    this.radius,
  }) : super(key: key);

  double computeTitleFontSize(double width) {
    var size = width * 0.13;
    if (size > 15) {
      size = 15;
    }
    return size;
  }

  int computeTitleLines(layoutHeight) {
    return layoutHeight >= 100 ? 2 : 1;
  }

  int computeBodyLines(layoutHeight) {
    var lines = 1;
    if (layoutHeight > 40) {
      lines += (layoutHeight - 40.0) ~/ 15.0 as int;
    }
    return lines;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var layoutWidth = constraints.biggest.width;

            TextStyle(
              fontSize: computeTitleFontSize(layoutWidth),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );

            TextStyle(
              fontSize: computeTitleFontSize(layoutWidth) - 1,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            );

        return InkWell(
          onTap: () {
            debugPrint(title);
            debugPrint(description);
            }
          ,
          child: showMultiMedia!
              ? imageProvider == null
                  ? Container(color: bgColor ?? Colors.grey)
                  : Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider!,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: radius == 0
                                ? BorderRadius.zero
                                : BorderRadius.all(
                                    Radius.circular(radius!),
                                  ),
                          ),
                        ),
                      Text(title),
                    ],
                  )
              : const SizedBox(width: 5),
        );
      },
    );
  }
}
