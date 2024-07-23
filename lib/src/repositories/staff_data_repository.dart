import 'package:http/http.dart'as http;
import 'package:smart_sense/src/models/role_model.dart';
import 'package:smart_sense/src/models/staff_device_model.dart';
import 'package:smart_sense/src/models/staff_room_model.dart';
import 'package:smart_sense/src/models/staff_zone_model.dart';
import 'package:smart_sense/src/network/api/staff_data_api.dart';
import 'package:smart_sense/src/repositories/repository.dart';

import '../models/staff_model.dart';

class StaffDataRepository extends Repository {
  final StaffDataApi staffDataApi = StaffDataApi();

  Future<StaffModel> getStaffdata(Map<String, String> jsonData) async {
    return await staffDataApi.getStaffData(jsonData);
  }

  Future<List<ZoneModel>> getZoneData(
      {required int page, required int siteId, required String token}) async {
    return await staffDataApi.getZoneData(
        page: page, siteId: siteId, token: token);
  }

  Future<List<RoleModel>> getRoleData(
      {required String siteId, required String token}) async {
    return await staffDataApi.getRole(siteId: siteId, token: token);
  }

  Future<List<RoomModel>> getRoomData(
      {required int page, required siteId, required String token}) async {
    return await staffDataApi.getRoomData(
        page: page, siteId: siteId, token: token);
  }

  Future<List<DeviceModel>> getDeviceData(
      {required int page, required int siteId, required String token}) async {
    return await staffDataApi.getDeviceData(
        page: page, siteId: siteId, token: token);
  }

  Future<dynamic> editStaffData( jsondata)async
  {
    return staffDataApi.editStaffData(jsondata);
  }

  Future<dynamic> updateStaffData(Map<String,dynamic>fields, List<http.MultipartFile>files) async
  {
    return staffDataApi.updateStaffData(fields,files);
  }

}
