abstract class DeviceEvent {}

class FetchDataEvent extends DeviceEvent
{
  final int page;
  final int siteId;

  FetchDataEvent({required this.page, required this.siteId});

  
}
