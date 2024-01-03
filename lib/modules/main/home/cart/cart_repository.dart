
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/models/api_model/cart/cart.dart';
import 'package:shovving_pre/models/local_model/group/group.dart';
import 'package:shovving_pre/models/local_model/url_data/url_data.dart';
import 'package:shovving_pre/util/dio/api_constants.dart';
import 'package:shovving_pre/util/dio/dio_api.dart';
import 'package:shovving_pre/util/local_repository/local_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';


class CartRepository{
  static final CartRepository _repository = CartRepository._intrnal();
  factory CartRepository() => _repository;
  CartRepository._intrnal();

  Dio dio = HttpService().to();
LocalRepository localRepository = LocalRepository();

  Future<void> addNewCart(UrlData newCart) async {
    safePrint('@@@=>try add new cart');
    try{
      final response = await dio.post(APIConstants.getCarts, data:
      [
        {
          "localId" : newCart.localId,
          "url": newCart.url,
          "image": newCart.image,
          "title": newCart.title,
          "groupIds": newCart.group==[]?'':newCart.group.join(','),
          "isDeleted": 0
        }

      ]
      );
      if(response.statusCode == 201||response.statusCode == 200){

        //여기서 카트 리스트를 패치하고 그 뭐야 그 해야됨
         await setCartList();
         await localRepository.findMyCartList();
         await cartController.filterNowCartList('all');
         cartController.update();


      }
    }catch(e){
      safePrint('error in add cart list : $e');
    }
  }

  Future<void> addPollItem(List<UrlData> dataList) async {
    safePrint('@@@=>add poll items');

    List tempList = [];
    for(int i=0; i<dataList.length; i++){

      Map<String, dynamic> tempData =  {
        "localId" : dataList[i].localId,
        "url": dataList[i].url,
        "image": dataList[i].image,
        "title": dataList[i].title,
        "groupIds": dataList[i].group==[]?'':dataList[i].group.join(','),
        "isDeleted": 0
      };

      tempList.add(tempData);
    }

    try{
      final response = await dio.post(APIConstants.getCarts, data:
      tempList,options: Options(contentType: Headers.jsonContentType),
      );
      if(response.statusCode == 201||response.statusCode == 200){
        await setCartList();
        await localRepository.findMyCartList();
        await cartController.filterNowCartList('all');
        cartController.update();
      }
    }catch(e){
      safePrint('error in add cart list : $e');
    }
  }

  Future<void> setCartList() async {

    safePrint('@@@=>try get cart list');
    try{
      final response = await dio.get(APIConstants.getCarts);
      if(response.statusCode == 201||response.statusCode == 200){

        List<Cart> serverCartList = (response.data as List<dynamic>).map((e) => Cart.fromJson(e as Map<String, dynamic>)).toList();
        List<UrlData> localCartList = [];
        for(int i=0; i<serverCartList.length; i++){
          UrlData tempCart = UrlData(
            id: serverCartList[i].id,
              userID: serverCartList[i].userID,
              localId: serverCartList[i].localId,
              url: serverCartList[i].url,
              image: serverCartList[i].image,
              title:serverCartList[i].title,
              group: serverCartList[i].groupIds==''?[]:serverCartList[i].groupIds.split(','),
              isDeleted : serverCartList[i].isDeleted,
              createdAt : serverCartList[i].createdAt,
              updatedAt : serverCartList[i].updatedAt,
          );

          localCartList.add(tempCart);

        }
       localRepository.initUpdateMyCartList(localCartList);
        await localRepository.findMyCartList();
        await cartController.filterNowCartList('all');
        cartController.update();
        homeController.update();
      }
    }catch(e){
      safePrint('error in set group list : $e');
    }
  }

  Future<void> deleteCart(List<UrlData> cartList)async {
    safePrint('@@@=>try delete new cart');

    List tempList = [];
    for(int i=0; i<cartList.length; i++){

      Map<String, dynamic> tempData =  {
        "localId" : cartList[i].localId,
        "url": cartList[i].url,
        "image": cartList[i].image,
        "title": cartList[i].title,
        "groupIds": cartList[i].group==[]?'':cartList[i].group.join(','),
        "isDeleted": 1
      };

      tempList.add(tempData);
    }

    try{
      final response = await dio.post(APIConstants.getCarts, data: tempList,options: Options(contentType: Headers.jsonContentType),);
      if(response.statusCode == 201||response.statusCode == 200){

        //여기서 카트 리스트를 패치하고 그 뭐야 그 해야됨
        setCartList();
        cartController.update();


      }
    }catch(e){
      safePrint('error in add cart list : $e');
    }
  }

  Future<void> deleteCartItem(List<UrlData> cartList)async {
    safePrint('@@@=>try delete new cart');

    List tempList = [];
    for(int i=0; i<cartList.length; i++){

      Map<String, dynamic> tempData =  {
        "localId" : cartList[i].localId,
        "url": cartList[i].url,
        "image": cartList[i].image,
        "title": cartList[i].title,
        "groupIds": cartList[i].group==[]?'':cartList[i].group.join(','),
        "isDeleted": 1
      };

      tempList.add(tempData);
    }

    try{
      final response = await dio.post(APIConstants.getCarts, data: tempList,options: Options(contentType: Headers.jsonContentType),);
      if(response.statusCode == 201||response.statusCode == 200){

        //여기서 카트 리스트를 패치하고 그 뭐야 그 해야됨
        setCartList();
        cartController.update();


      }
    }catch(e){
      safePrint('error in add cart list : $e');
    }
  }

  Future<void> updateCartList(List<UrlData> cartList)async {
    safePrint('@@@=>try delete new cart');

    List tempList = [];
    for(int i=0; i<cartList.length; i++){

      Map<String, dynamic> tempData =  {
        "localId" : cartList[i].localId,
        "url": cartList[i].url,
        "image": cartList[i].image,
        "title": cartList[i].title,
        "groupIds": cartList[i].group==[]?'':cartList[i].group.join(','),
        "isDeleted": 0
      };

      tempList.add(tempData);
    }

    try{
      final response = await dio.post(APIConstants.getCarts, data: tempList,options: Options(contentType: Headers.jsonContentType),);
      if(response.statusCode == 201||response.statusCode == 200){

        //여기서 카트 리스트를 패치하고 그 뭐야 그 해야됨
        setCartList();
        cartController.update();


      }
    }catch(e){
      safePrint('error in add cart list : $e');
    }
  }

  Future<void> updateCartImageList(UrlData cartData)async {
    safePrint('@@@=>try delete new cart');

      Map<String, dynamic> tempData =  {
        "localId" : cartData.localId,
        "url": cartData.url,
        "image": cartData.image,
        "title": cartData.title,
        "groupIds": [],
        "isDeleted": 0
      };



    try{
      final response = await dio.post(APIConstants.getCarts, data: [tempData],options: Options(contentType: Headers.jsonContentType),);
      if(response.statusCode == 201||response.statusCode == 200){

        //여기서 카트 리스트를 패치하고 그 뭐야 그 해야됨
        setCartList();
        cartController.update();


      }
    }catch(e){
      safePrint('error in add cart list : $e');
    }
  }

}