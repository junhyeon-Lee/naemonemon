import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/modules/main/home/cart_screen/cart_controller.dart';
import 'package:shovving_pre/util/url_previewer/src/parser/base.dart';
import 'package:string_validator/string_validator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'link_analyzer.dart';
import '../widgets/link_view_horizontal.dart';

enum UIDirection { uiDirectionVertical, uiDirectionHorizontal }

class AnyLinkPreview extends StatefulWidget {
  final UIDirection displayDirection;

  final LaunchMode urlLaunchMode;

  final String link;

  final Color? backgroundColor;

  final Widget? placeholderWidget;

  final Widget? errorWidget;

  final String? errorTitle;

  final String? errorBody;

  final String? errorImage;

  final TextOverflow bodyTextOverflow;

  final int bodyMaxLines;

  final Duration cache;

  final TextStyle? titleStyle;

  final TextStyle? bodyStyle;

  final bool showMultimedia;

  final double? borderRadius;

  final bool removeElevation;

  final List<BoxShadow>? boxShadow;

  final String? proxyUrl;

  final Map<String, String>? headers;

  final void Function()? onTap;

  final double? previewHeight;

  final Widget Function(BuildContext, MetadataH, ImageProvider?)? itemBuilder;

  final int index;

  const AnyLinkPreview({
    Key? key,
    required this.link,
    this.cache = const Duration(days: 1),
    this.titleStyle,
    this.bodyStyle,
    this.displayDirection = UIDirection.uiDirectionVertical,
    this.showMultimedia = true,
    this.backgroundColor = const Color.fromRGBO(235, 235, 235, 1),
    this.bodyMaxLines = 3,
    this.bodyTextOverflow = TextOverflow.ellipsis,
    this.placeholderWidget,
    this.errorWidget,
    this.errorBody,
    this.errorImage,
    this.errorTitle,
    this.borderRadius,
    this.boxShadow,
    this.removeElevation = false,
    this.proxyUrl,
    this.headers,
    this.onTap,
    this.previewHeight,
    this.urlLaunchMode = LaunchMode.platformDefault, required this.index,
  })  : itemBuilder = null,
        super(key: key);

  AnyLinkPreview.builder({
    Key? key,
    required this.link,
    required this.itemBuilder,
    this.cache = const Duration(days: 1),
    this.placeholderWidget,
    this.errorWidget,
    this.proxyUrl,
    this.headers, required this.index,
  })  : titleStyle = null,
        bodyStyle = null,
        displayDirection = UIDirection.uiDirectionVertical,
        showMultimedia = true,
        backgroundColor = null,
        bodyMaxLines = 3,
        bodyTextOverflow = TextOverflow.ellipsis,
        borderRadius = null,
        errorBody = null,
        errorImage = null,
        errorTitle = null,
        boxShadow = null,
        removeElevation = false,
        onTap = null,
        previewHeight = null,
        urlLaunchMode = LaunchMode.platformDefault,
        super(key: key);

  @override
  AnyLinkPreviewState createState() => AnyLinkPreviewState();





  static Future<MetadataH?> getMetadata({required String link, String? proxyUrl = '', Duration? cache = const Duration(days: 1), Map<String, String>? headers,}) async {
    var linkValid = isValidLink(link);
    var proxyValid = true;
    if ((proxyUrl ?? '').isNotEmpty) proxyValid = isValidLink(proxyUrl!);
    if (linkValid && proxyValid) {
      // removing www. from the link if available
      if (link.startsWith('www.')) link = link.replaceFirst('www.', '');
      var linkToFetch = ((proxyUrl ?? '') + link).trim();
      return getMetadataInfo(
        linkToFetch,
        cache: cache,
        headers: headers ?? {},
      );
    } else if (!linkValid) {
      throw Exception('Invalid link');
    } else {
      throw Exception('Proxy URL is invalid. Kindly pass only if required');
    }
  }

  static Future<MetadataH?> getMetadataInfo(String link, {Duration? cache = const Duration(days: 1), Map<String, String>? headers,}) async {
    try {
      var info = await LinkAnalyzer.getInfo(
        link,
        cache: cache,
        headers: headers ?? {},
      );
      if (info == null || info.hasData == false) {
        // if info is null or data is empty try to read url metadata from client side
        info = await LinkAnalyzer.getInfoClientSide(
          link,
          cache: cache,
          headers: headers ?? {},
        );
      }
      return info;
    } catch (error) {
      return null;
    }
  }

  static bool isValidLink(String link, {List<String> protocols = const ['http', 'https', 'ftp'], List<String> hostWhitelist = const [], List<String> hostBlacklist = const [], bool requireTld = true, bool requireProtocol = false, bool allowUnderscore = false,}) {
    if (link.isEmpty) return false;
    Map<String, Object>? options = {
      'require_tld': requireTld,
      'require_protocol': requireProtocol,
      'allow_underscores': allowUnderscore,
    };
    if (protocols.isNotEmpty) options['protocols'] = protocols;
    if (hostWhitelist.isNotEmpty) options['host_whitelist'] = hostWhitelist;
    if (hostBlacklist.isNotEmpty) options['host_blacklist'] = hostBlacklist;
    var isValid = isURL(link, options);
    return isValid;
  }
}

class AnyLinkPreviewState extends State<AnyLinkPreview> {
  BaseMetaInfo? _info;
  late String _errorImage, _errorTitle, _errorBody;
  bool _loading = false;
  bool _linkValid = false, _proxyValid = true;
  String originalLink = '';

  @override
  void initState() {
    originalLink = widget.link;
    _errorImage = widget.errorImage ??
        'https://github.com/sur950/any_link_preview/blob/master/lib/assets/giphy.gif?raw=true';
    _errorTitle = widget.errorTitle ?? 'Something went wrong!';
    _errorBody = widget.errorBody ??
        'Oops! Unable to parse the url. We have sent feedback to our developers & we will try to fix this in our next release. Thanks!';

    _linkValid = AnyLinkPreview.isValidLink(originalLink);
    if ((widget.proxyUrl ?? '').isNotEmpty) {
      _proxyValid = AnyLinkPreview.isValidLink(widget.proxyUrl!);
    }
    if (_linkValid && _proxyValid) {
      // removing www. from the link if available
      if (originalLink.startsWith('www.')) {
        originalLink = originalLink.replaceFirst('www.', '');
      }
      var linkToFetch = ((widget.proxyUrl ?? '') + originalLink).trim();
      _loading = true;
      _getInfo(linkToFetch).then((value) => {


      Get.find<CartController>().fetchDataList(widget.index, _info)


      });
    }





    super.initState();
  }

  Future<void> _getInfo(String link) async {
    _info = await AnyLinkPreview.getMetadataInfo(
      link,
      cache: widget.cache,
      headers: widget.headers,
    );
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  void _launchURL(url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: widget.urlLaunchMode);
    } else {
      try {
        await launchUrl(uri, mode: widget.urlLaunchMode);
      } catch (err) {
        throw Exception('Could not launch $url. Error: $err');
      }
    }
  }

  Widget _buildPlaceHolder(double defaultHeight) {
    return Container(
      height: defaultHeight,
      child: LayoutBuilder(builder: (context, constraints) {
        var layoutWidth = constraints.biggest.width;
        var layoutHeight = constraints.biggest.height;

        return Container(
          color: widget.backgroundColor,
          width: layoutWidth,
          height: layoutHeight,
        );
      }),
    );
  }

  Widget _buildLinkContainer(double height, MetadataH info) {
    final image = LinkAnalyzer.isNotEmpty(info.image)
        ? ((widget.proxyUrl ?? '') + (info.image ?? ''))
        : null;

    if (widget.itemBuilder != null) {
      return widget.itemBuilder!(context, info, _buildImageProvider(image));
    }

    final title =
        LinkAnalyzer.isNotEmpty(info.title) ? info.title! : _errorTitle;
    final desc = LinkAnalyzer.isNotEmpty(info.desc) ? info.desc! : _errorBody;
    final imageProvider = _buildImageProvider(image ?? _errorImage);

    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        boxShadow: widget.removeElevation
            ? []
            : widget.boxShadow ??
                [BoxShadow(blurRadius: 3, color: Colors.grey)],
      ),
      height: height,
      child: LinkViewHorizontal(
              key: widget.key ?? Key(originalLink.toString()),
              url: originalLink,
              title: title,
              description: desc,
              imageProvider: imageProvider,
              onTap: widget.onTap ?? () => _launchURL(originalLink),
              titleTextStyle: widget.titleStyle,
              bodyTextStyle: widget.bodyStyle,
              bodyTextOverflow: widget.bodyTextOverflow,
              bodyMaxLines: widget.bodyMaxLines,
              showMultiMedia: widget.showMultimedia,
              bgColor: widget.backgroundColor,
              radius: widget.borderRadius ?? 12,
            )

    );
  }

  ImageProvider? _buildImageProvider(String? image) {
    ImageProvider? imageProvider = image != null ? NetworkImage(image) : null;
    if (image != null && image.startsWith('data:image')) {
      imageProvider = MemoryImage(
        base64Decode(image.substring(image.indexOf('base64') + 7)),
      );
    }
    return imageProvider;
  }

  @override
  Widget build(BuildContext context) {
    final info = _info as MetadataH?;
    var height =  ((MediaQuery.of(context).size.height) * 0.15);


    Widget loadingErrorWidget = Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        color: Colors.grey[200],
      ),
      alignment: Alignment.center,
      child: Container(
        ///추후 패치하는 동안에 보여줄 이미지 또는 위젯이 필요함
        width: (Get.width-90)/2,
        height:(Get.width-90)/2,
        child: Center(
          child: Text(
            !_linkValid
                ? 'Invalid Link'
                : !_proxyValid
                    ? 'Proxy URL is invalid. Kindly pass only if required'
                    : 'Fetching data...',
          ),
        ),
      ),
    );

    if (_loading) {
      return (!_linkValid || !_proxyValid)
          ? loadingErrorWidget
          : (widget.placeholderWidget ?? loadingErrorWidget);
    }

    return info == null
        ? widget.errorWidget ?? _buildPlaceHolder(height)
        : _buildLinkContainer(height, info);
  }
}
