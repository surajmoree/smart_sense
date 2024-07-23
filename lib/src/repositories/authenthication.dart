import 'package:http/http.dart'as http;

import '../network/api/user_api.dart';
import 'repository.dart';

class AuthenticationRepo extends Repository {
  final UserApi userApi = UserApi();
  Future<dynamic> submitLoginForm(jsonData) async =>
      await UserApi().userLogin(jsonData);

        Future<void> logout(String token) async {
    return await userApi.logout(token);
  }

  // Future<dynamic> userChangePassword(jsonData) async
  // {
  //   return await userApi.userChangePassword(jsonData);
  // }

  

  Future<dynamic> userChangePassword(Map<String, String> fields, List<http.MultipartFile> files) async
  {
    return await userApi.userChangePassword(fields,files);
  }

  

}