// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'dart:async';

import 'package:http/http.dart'as http;
import 'package:smart_sense/config.dart';
import 'package:smart_sense/src/network/api/api.dart';


class UserApi extends Api {
  Future<dynamic> userLogin(jsonData) async {
    try {
      final userResultData =
          await requestPOST(path: '/login', parameters: jsonData);
      print(userResultData);
      return userResultData;
    } catch (e, _) {
      print(e);
      print(_);
    }
  }
  
  Future<dynamic> userChangePassword(Map<String,String>fields,List<http.MultipartFile>files)async{
    final String? id = await storage.read(key: 'id');
    try{
      final userData = await requestPUTPass(path: '/api/v1/update_password/$id',fields:fields,files: files );
        print('============== Response Data: $userData');
        return userData;
    }catch (e, _) {
      print(e);
      print(_);
    }
  }

/*
 Future<dynamic> userChangePassword(jsonData) async
 {
  final String? id = await storage.read(key: 'id');
  try{
    final userData = await requestPUT(path: '/api/v1/update_password/$id',parameters: jsonData);
   print('============== Response Data: $userData');
   return userData;
  }catch (e, _) {
      print(e);
      print(_);
    }
  
 }
*/

/*
  Future<dynamic> userChangePassword(dynamic jsonData) async {
    final String? id = await storage.read(key: 'id');
    if (id == null) {
      throw Exception('User ID is null');
    }

    try {
      final userData = await requestPUT(path: '/api/v1/update_password/$id', parameters: jsonData);

      // Log the user data
      print('============== Response Data: $userData');
      print('============== User ID: $id');

      return userData;
    } catch (e, _) {
      print(e);
      print(_);
      rethrow;
    }
  }

  */

  



  
   Future<void> logout(String token) async {
    try {
      await requestGET(
        path: '/logout',
        parameters: {'token': token},
      );
    } catch (e) {
      print('Error in logout: $e');
      throw e;
    }
  }


}
