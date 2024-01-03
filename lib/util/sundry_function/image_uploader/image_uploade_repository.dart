

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/util/dio/api_constants.dart';
import 'package:shovving_pre/util/dio/dio_api.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:mime/mime.dart' ;
import 'package:flutter_image_compress/flutter_image_compress.dart';


class ImageUploadRepository{
  static final ImageUploadRepository _repository = ImageUploadRepository._intrnal();
  factory ImageUploadRepository() => _repository;
  ImageUploadRepository._intrnal();

  Dio dio = HttpService().to();



  Future<String?> imageUpload(File file) async {
    safePrint('@@@=>try image upload');
    final dio = Dio();

    safePrint('1');
    var bytes = await File(file.path).readAsBytes();
    safePrint('2');
    dio.options.contentType = 'multipart/form-data';
   // dio.options.maxRedirects.isFinite;
    var formData = FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});

    try{
      final response = await dio.post(APIConstants.imageUpload,
        data:formData
    );
      if(response.statusCode == 201||response.statusCode == 200){

        final body = response.data;

        return body["Location"];

      }
    }catch(e){
      safePrint('error in image upload : $e');

    }
    return null;
  }

  Future<String?> imageUploadCompress(File originFile) async {

    safePrint('@@@=>try image upload');
    final dio = Dio();


    safePrint(originFile);
    const directory = '/data/user/0/com.naemo.nemon/cache';

    XFile? originXFile = await FlutterImageCompress.compressAndGetFile(
      originFile.absolute.path, '$directory/screenshot${DateTime.now()}.jpg',
      quality: 25,
    );


    safePrint(originXFile?.path);
    File file = File(originXFile!.path);
    safePrint('44');
    var bytes = await File(file.path).readAsBytes();

    dio.options.contentType = 'multipart/form-data';
    // dio.options.maxRedirects.isFinite;
    var formData = FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});

    try{
      final response = await dio.post(APIConstants.imageUpload,
          data:formData
      );
      if(response.statusCode == 201||response.statusCode == 200){

        final body = response.data;

        return body["Location"];

      }
    }catch(e){
      safePrint('error in image upload : $e');

    }
    return null;
  }

  Future<List<String>> imageListUpload(List<File> fileList) async{
    List<String> imageUrlList = [];


    safePrint('이미지 파일 리스트');
    safePrint(fileList);

    for(int i=0; i<fileList.length; i++){
      String? imageUrl = await imageUploadCompress(fileList[i]);
      imageUrlList.add(imageUrl??"");
    }

    return imageUrlList;
  }



}