/*
 "device_mac_address": "D98399C5D9F4", 
      "device_name": "Id Card", 
      "device_type_id": 2, 
      "id": 228, 
      "room_name": "Designer Room", 
      "x_coordinate": 0.0, 
      "y_coordinate": 0.0, 
      "zone_name": "Deisnger Zone"
*/

class DeviceModel {
  final String deviceAddress;
  final String deviceName;
  final int deviceTypeId;
  final int id;
  final String roomName;
  final double xCoordinate;
  final double yCoordinate;
  final String zoneName;

  DeviceModel(
      {required this.deviceAddress,
      required this.deviceName,
      required this.deviceTypeId,
      required this.id,
      required this.roomName,
      required this.xCoordinate,
      required this.yCoordinate,
      required this.zoneName});

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
        deviceAddress: json['device_mac_address'],
        deviceName: json['device_name'],
        deviceTypeId: json['device_type_id'],
        id: json['id'],
        roomName: json['room_name'],
        xCoordinate: json['x_coordinate'],
        yCoordinate: json['y_coordinate'],
        zoneName: json['zone_name']);
  }
}
