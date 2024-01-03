import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shovving_pre/models/local_model/poll/poll.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:encrypt/encrypt.dart';
import 'dart:convert';

Future<void> shareLink(Poll data, String subject) async {
   String webBaseUrl = 'https://naemonemon.com/?pollId=';

   final key = Key.fromUtf8('dhrmeoduqntjwlwl');
   final iv = IV.fromLength(16);
   final encrypter = Encrypter(AES(key));
   String encrptText = encrypter.encrypt(data.id.toString(), iv: iv).base64;


   String webPollUrl =  '$webBaseUrl$encrptText';


  bool isKakaoTalkSharingAvailable = await ShareClient.instance.isKakaoTalkSharingAvailable();

  final FeedTemplate defaultFeed = FeedTemplate(
    content: Content(
      title: subject,
      imageUrl: Uri.parse(data.items[0].image!),
      link: Link(
          webUrl: Uri.parse(webPollUrl),
          mobileWebUrl: Uri.parse(webPollUrl)),
    ),
    buttons: [
      Button(
        title: '투표하러 가기',
        link: Link(
          webUrl: Uri.parse(webPollUrl),
          mobileWebUrl: Uri.parse(webPollUrl),
        ),
      ),
    ],
  );

  if (isKakaoTalkSharingAvailable) {
    try {
      Uri uri = await ShareClient.instance.shareDefault(template: defaultFeed);
      await ShareClient.instance.launchKakaoTalk(uri);
    } catch (error) {
      safePrint(error);
    }
  } else {
  }
}

