class RoomModel {
  final int id;
  final String roomName;
  final int siteId;
  final String xmax;
  final String xmin;
  final String ymax;
  final String ymin;
  final int zoneId;
  final String zoneName;

  RoomModel(
      {required this.id,
      required this.roomName,
      required this.siteId,
      required this.xmax,
      required this.xmin,
      required this.ymax,
      required this.ymin,
      required this.zoneId,
      required this.zoneName});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
        id: json['id'] ?? 0,
        roomName: json['room_name']?? '',
        siteId: json['site_id'] ?? 0,
        xmax: json['x_max']?? '',
        xmin: json['x_min']?? '',
        ymax: json['y_max']?? '',
        ymin: json['y_min']?? '',
        zoneId: json['zone_id']?? '',
        zoneName: json['zone_name']?? '');
  }

  
}
