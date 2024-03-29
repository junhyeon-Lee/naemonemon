
import 'dart:async' as async;
import 'dart:convert';


import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart' show Document;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_function/url_previewer/src/parser/base.dart';
import 'package:string_validator/string_validator.dart';

import '../parser/html_parser.dart';
import '../parser/json_ld_parser.dart';
import '../parser/og_parser.dart';
import '../parser/twitter_parser.dart';
import '../parser/other_parser.dart';
import '../parser/util.dart';
import 'cache_manager.dart';

class LinkAnalyzer {
  /// Is it an empty string
  static bool isNotEmpty(String? str) {
    return str != null && str.trim().isNotEmpty;
  }

  /// return [MetadataH] from cache if available
  static Future<MetadataH?> getInfoFromCache(String url) async {
    MetadataH? info_;
    try {
      final infoJson = await CacheManager.getJson(key: url);
      if (infoJson != null) {
        info_ = MetadataH.fromJson(infoJson);

        var isEmpty_ = info_.title == null || info_.title == 'null';



        if (isEmpty_ || !info_.timeout.isAfter(DateTime.now())) {
          async.unawaited(CacheManager.deleteKey(url));
        }
        if (isEmpty_) info_ = null;
      }else{
      }
    } catch (e) {
      debugPrint('Error while retrieving cache data => $e');
      return info_;
    }
    return info_;
  }

  /// deletes [MetadataH] from cache if available
  static void _deleteFromCache(String url) {
    // print(url);
    try {
      async.unawaited(CacheManager.deleteKey(url));
    } catch (e) {
      debugPrint('Error retrieving cache data => $e');
    }
  }

  // Twitter generates meta tags on client side so it's impossible to read
  // So we use this hack to fetch server side rendered meta tags
  // This helps for URL's who follow client side meta tag generation technique

  static Future<MetadataH?> getInfoClientSide(
      String url, {
        Duration? cache = const Duration(hours: 24),
        Map<String, String> headers = const {},
      }) {
    return getInfo(
        url,
        cache: const Duration(hours: 24),
        headers: headers,
        userAgent:'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)'
    );
  }


  /// Fetches a [url], validates it, and returns [MetadataH].
  static Future<MetadataH?> getInfo(
      String url, {
        Duration? cache = const Duration(hours: 24),
        Map<String, String> headers = const {},
        String? userAgent,
      }) async {



    MetadataH? info;
    if ((cache?.inSeconds ?? 0) > 0) {

      info = await getInfoFromCache(url);





    } else {
      _deleteFromCache(url);
    }
    if (info != null) return info;

    // info = await _getInfo(url, multimedia);
    if (!isURL(url)) return null;

    /// Default values; Domain name as the [title],
    /// URL as the [description]
    info?.title = getDomain(url);
    info?.desc = url;
    info?.url = url;


    try {
      safePrint('링크 데이터 파싱');
      safePrint(url);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          ...headers,
          // ...{
           // 'User-Agent': userInfoController.userAgent,//'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101 Firefox/90.0'
            "Accept-Language" : "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3"
          // } ,
        },
      );


      safePrint('링크 데이터 파싱 종료');
      //'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101 Firefox/90.0'
      final headerContentType = response.headers['content-type'];



      if (headerContentType != null && headerContentType.startsWith('image/')) {
        info?.title = '';
        info?.desc = '';
        info?.image = url;


        return info;
      }

      final document = responseToDocument(response);
      if (document == null){
        return info;
      }else{
        final data_ = _extractMetadata(document, url: url);
        if (data_ == null) {
          return info;
        } else if (cache != null) {
          data_.timeout = DateTime.now().add(cache);
          await CacheManager.setJson(key: url, value: data_.toJson());
        }

        return data_;
      }

    } catch (error) {
      debugPrint('AnyLinkPreview - Error in $url response ($error)');
      // Any sort of exceptions due to wrong URL's, host lookup failure etc.
      return null;
    }
  }

  /// Takes an [http.Response] and returns a [html.Document]
  static Document? responseToDocument(http.Response response) {
    if (response.statusCode != 200) return null;

    Document? document;
    try {
      document = parse(utf8.decode(response.bodyBytes));
    } catch (err) {
      return document;
    }

    return document;
  }

  /// Returns instance of [MetadataH] with data extracted from the [html.Document]
  /// Provide a given url as a fallback when there are no Document url extracted
  /// by the parsers.
  ///
  /// Future: Can pass in a strategy i.e: to retrieve only OpenGraph, or OpenGraph and Json+LD only
  static MetadataH? _extractMetadata(Document document, {String? url}) {
    return _parse(document, url: url);
  }

  /// This is the default strategy for building our [MetadataH]
  ///
  /// It tries [OpenGraphParser], then [TwitterParser],
  /// then [JsonLdParser], and falls back to [HTMLMetaParser] tags for missing data.
  /// You may optionally provide a URL to the function,
  /// used to resolve relative images or to compensate for the
  /// lack of URI identifiers from the metadata parsers.
  static MetadataH _parse(Document? document, {String? url}) {
    final output = MetadataH();

    final parsers = [
      _openGraph(document),
      _twitterCard(document),
      _jsonLdSchema(document),
      _htmlMeta(document),
      _otherParser(document),
    ];

    for (final p in parsers) {
      if (p == null) break;

      output.title ??= p.title;
      output.desc ??= p.desc;
      output.image ??= p.image;
      output.url ??= p.url ?? url;

      if (output.hasAllMetadata) break;
    }
    // If the parsers did not extract a URL from the metadata, use the given
    // url, if available. This is used to attempt to resolve relative images.
    final url_ = output.url ?? url;
    final image = output.image;
    if (url_ != null && image != null) {
      output.image = Uri.parse(url_).resolve(image).toString();
    }

    return output;
  }

  static MetadataH? _openGraph(Document? document) {
    try {
      return OpenGraphParser(document).parse();
    } catch (e) {
      return null;
    }
  }

  static MetadataH? _htmlMeta(Document? document) {
    try {
      return HtmlMetaParser(document).parse();
    } catch (e) {
      return null;
    }
  }

  static MetadataH? _jsonLdSchema(Document? document) {
    try {
      return JsonLdParser(document).parse();
    } catch (e) {
      return null;
    }
  }

  static MetadataH? _twitterCard(Document? document) {
    try {
      return TwitterParser(document).parse();
    } catch (e) {
      return null;
    }
  }

  static MetadataH? _otherParser(Document? document) {
    try {
      return OtherParser(document).parse();
    } catch (e) {
      return null;
    }
  }
}
