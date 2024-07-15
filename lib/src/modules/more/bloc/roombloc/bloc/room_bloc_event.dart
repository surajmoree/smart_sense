abstract class RoomEvent {}

class FetchPage extends RoomEvent
{
  final int page;
  final int siteId;

  FetchPage( {required this.page,required this.siteId,});

  
}
