part of 'staff_zone_bloc_bloc.dart';

abstract class StaffZoneEvent {}

class FetchStaffZone extends StaffZoneEvent {
  final int page;
  final int siteId;

  FetchStaffZone({required this.page, required this.siteId});
}


