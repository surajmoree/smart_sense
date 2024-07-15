// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:smart_sense/src/models/role_model.dart';
import 'package:smart_sense/src/models/staff_device_model.dart';
import 'package:smart_sense/src/models/staff_model.dart';
import 'package:smart_sense/src/models/staff_room_model.dart';
import 'package:smart_sense/src/models/staff_zone_model.dart';
import 'package:smart_sense/src/network/api/api.dart';

import '../../models/staff_edit_profile.dart';

/*
class StaffDataApi extends Api {
  Future<dynamic> getStaffData(Map<String, String> jsonData) async {
    try {
      final response = await requestGET(
        path: '/api/v1/profile_information',
        parameters: jsonData,
      );
      print('API Response: ${response.toString()}'); // Log the raw response

      if (response.containsKey('user')) {
        return StaffModel.fromJson(response['user']);
      } else {
        throw Exception('User data not found in the response');
      }
    } catch (e) {
      print('Error in getStaffData: $e'); // Log errors
      throw e;
    }
  }

  Future<List<ZoneModel>> getZoneData({
    required int page,
    required int siteId,
    required String token,
  }) async {
    try {
      final response = await requestGET(
        path: '/api/v1/get/zone',
        parameters: {'page': '$page', 'site_id': '$siteId', 'token': token},
      );
      print('Zones : ${response.toString()}');

      if (response.containsKey('zone')) {
        List<dynamic> zoneData = response['zone'];
        return zoneData.map((json) => ZoneModel.fromJson(json)).toList();
      } else {
        throw Exception('Zone data not found in response');
      }
    } catch (e) {
      print('Error in getZoneData: $e');
      throw e;
    }
  }

  Future<List<RoomModel>> getRoomData(
      {required int page, required int siteId, required String token}) async {
    try {
      final response = await  requestGET(
          path: '/api/v1/get/room',
          parameters: {'page': '$page', 'site_id': '$siteId', 'token': token});
      print('-----------roomm $response');

      if (response.containsKey('room')) {
        List<dynamic> roomData = response['room'];
        return roomData.map((json) => RoomModel.fromJson(json)).toList();
      } else {
      throw  Exception('Room data is not found');
      }
    } catch (e) {
      print('errror $e');
      throw e;
    }
  }

  Future<List<DeviceModel>> getDeviceData({required int page,required int siteId, required String token})async
  {
    try 
    {
      final response = await  requestGET(path: '/api/v1/get/devices',parameters: {'page': '$page','site_id': '$siteId', 'token': token});
      print('----------device $response');

      if(response.containsKey('device'))
      {
        List<dynamic> deviceRoom = response['device'];
        return deviceRoom.map((json)=> DeviceModel.fromJson(json)).toList();
      }
      else
      {
        throw  Exception('device data is not found');
      }
    }catch(e)
    {
       print('errror $e');
      throw e;
    }
  }

  Future<List<RoleModel>> getRole({
    required int siteId,
    required String token,
  }) async {
    try {
      final response = await requestGET(
        path: '/api/v1/get/role',
        parameters: {'site_id': '$siteId', 'token': token},
      );
      print('------Roles response $response');

      if (response.containsKey('roles')) {
        List<dynamic> roleData = response['roles'];
        return roleData.map((json) => RoleModel.fromJson(json)).toList();
      } else {
        throw Exception('Role data not found');
      }
    } catch (e) {
      print('Error in getRole: $e');
      throw e;
    }
  }

  // Future<dynamic> editStaffData(jsonData)async
  // {
  //   try{
  //     final response = await requestGET(path: '/api/v1/get/user/${jsonData['id']}',parameters: jsonData);
  //      print('------profile response $response');
  //      final objectJson = json.decode(response);
  //      return objectJson;
  //   }catch(e)
  //   {
  //      print('Error in getProfile detail: $e');
  //     throw e;
  //   }
  // }
 Future<dynamic> editStaffData( jsonData) async {
    try {
      final response = await requestGET(
        path: '/api/v1/get/user/${jsonData['id']}',
        parameters: jsonData,
      );
      print('------profile response $response');
      final objectJson = json.decode(response);
      return objectJson;
    } catch (e) {
      print('Error in getProfile detail: $e');
      throw e;
    }
  }
  


  
}
*/

class StaffDataApi extends Api {
  Future<dynamic> getStaffData(Map<String, String> jsonData) async {
    try {
      final response = await requestGET(
        path: '/api/v1/profile_information',
        parameters: jsonData,
      );
      print('API Response: ${response.toString()}');

      if (response.containsKey('user')) {
        return StaffModel.fromJson(response['user']);
      } else {
        throw Exception('User data not found in the response');
      }
    } catch (e) {
      print('Error in getStaffData: $e');
      throw e;
    }
  }

  Future<List<ZoneModel>> getZoneData({
    //here we used list as return type because in api there is a list of zones
    required int page,
    required int siteId,
    required String token,
  }) async {
    try {
      final response = await requestGET(
        path: '/api/v1/get/zone',
        parameters: {'page': '$page', 'site_id': '$siteId', 'token': token},
      );
      print('Zones : ${response.toString()}');

      if (response.containsKey('zone')) {
        List<dynamic> zoneData = response['zone'];
        return zoneData.map((json) => ZoneModel.fromJson(json)).toList();
      } else {
        throw Exception('Zone data not found in response');
      }
    } catch (e) {
      print('Error in getZoneData: $e');
      throw e;
    }
  }

  Future<List<RoomModel>> getRoomData(
      {required int page, required int siteId, required String token}) async {
    try {
      final response = await requestGET(
          path: '/api/v1/get/room',
          parameters: {'page': '$page', 'site_id': '$siteId', 'token': token});
      print('-----------roomm $response');

      if (response.containsKey('room')) {
        List<dynamic> roomData = response['room'];

        return roomData.map((json) => RoomModel.fromJson(json)).toList();
      } else {
        throw Exception('Room data is not found');
      }
    } catch (e) {
      print('errror $e');
      throw e;
    }
  }

  Future<List<DeviceModel>> getDeviceData(
      {required int page, required int siteId, required String token}) async {
    try {
      final response = await requestGET(
          path: '/api/v1/get/devices',
          parameters: {'page': '$page', 'site_id': '$siteId', 'token': token});
      print('----------device $response');

      if (response.containsKey('device')) {
        List<dynamic> deviceRoom = response['device'];
        return deviceRoom.map((json) => DeviceModel.fromJson(json)).toList();
      } else {
        throw Exception('device data is not found');
      }
    } catch (e) {
      print('errror $e');
      throw e;
    }
  }

  Future<List<RoleModel>> getRole({
    required String siteId,
    required String token,
  }) async {
    try {
      final response = await requestGET(
        path: '/api/v1/get/role',
        parameters: {'site_id': '$siteId', 'token': token},
      );
      print('------Roles response $response');

      if (response.containsKey('roles')) {
        List<dynamic> roleData = response['roles'];
        return roleData.map((json) => RoleModel.fromJson(json)).toList();
      } else {
        throw Exception('Role data not found');
      }
    } catch (e) {
      print('Error in getRole: $e');
      throw e;
    }
  }

  Future<dynamic> editStaffData(jsonData) async {
    try {
      final response = await requestGET(
          path: '/api/v1/get/user/${jsonData['id']}', parameters: jsonData);
    //  await storage.write(key: 'id', value: jsonData['id'].toString());

      print('==============editdata $response');
     

      if (response.containsKey('users')) {
        return ApiResponse.fromJson(response);
      } else {
        throw Exception('User data not found in the response');
      }
    } catch (e) {
      print('Error in getProfile detailssss: $e');
      throw e;
    }
  }


  Future<dynamic> updateStaffData(jsonData, String id)async
  {
    try{
      final result  = await requestPUT(path: '/api/v1/update_user_profile/$id',parameters: jsonData);
      return result;
    }
    catch (er) {
      print("Error is---------$er");
    }
  }



}
