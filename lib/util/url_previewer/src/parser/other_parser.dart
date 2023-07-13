import 'package:html/dom.dart';
import 'util.dart';
import 'base.dart';

/// Parses [MetadataH] from [<meta attribute: 'name' property='*'>] tags
class OtherParser with BaseMetaInfo {
  /// The [document] to be parse
  final Document? _document;
  OtherParser(this._document);

  /// Get [MetadataH.title] from 'title'
  @override
  String? get title =>
      getProperty(_document, attribute: 'name', property: 'title');

  /// Get [MetadataH.desc] from 'description'
  @override
  String? get desc =>
      getProperty(_document, attribute: 'name', property: 'description');

  /// Get [MetadataH.image] from 'image'
  @override
  String? get image =>
      getProperty(_document, attribute: 'name', property: 'image');

  /// Get [MetadataH.url] from 'url'
  @override
  String? get url => getProperty(_document, attribute: 'name', property: 'url');

  @override
  String toString() => parse().toString();
}
