part of 'staff_zone_bloc_bloc.dart';

enum ZoneStatus {
  initial,
  loading,
  success,
  failure,
}

class StaffZoneState extends Equatable {
  final ZoneStatus status;
  final List<ZoneModel> zonelist;
  final int totalCount;

 const StaffZoneState({
    this.status = ZoneStatus.initial,
    this.zonelist = const [],
    this.totalCount =0,
  });

  StaffZoneState copyWith({
    ZoneStatus? status,
    List<ZoneModel>? zonelist,
    int? totalCount,
  }) {
    return StaffZoneState(
      status: status ?? this.status,
      zonelist: zonelist ?? this.zonelist,
      totalCount: totalCount ?? this.totalCount
    );
  }

  @override
  List<Object?> get props => [status, zonelist,totalCount];
}
