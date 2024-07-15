 
 import 'package:equatable/equatable.dart';

import '../../../../../models/staff_device_model.dart';

enum DeviceStatus{
  initial,
  loading,
  success,
  failure,
  
}
 
 
 class DeviceState extends Equatable{
  final DeviceStatus status;
  final List<DeviceModel> devicelist;
  final int totalCount;

  const DeviceState({ this.status = DeviceStatus.initial,  this.devicelist = const[],  this.totalCount =0});

  DeviceState copyWith({
    DeviceStatus? status,
    List<DeviceModel>? devicelist,
    int? totalCount,

  })
  {
    return DeviceState(status: status?? this.status, devicelist: devicelist?? this.devicelist, totalCount: totalCount?? this.totalCount);
  }
  @override
 
  List<Object?> get props =>[status,devicelist,totalCount];
  
 }


