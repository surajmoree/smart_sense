
// class ZoneModel {
//   final int id;
//   final int siteId;
//   final String xMax;
//   final String xMin;
//   final String yMax;
//   final String yMin;
//   final String zoneName;

//   ZoneModel({
//     required this.id,
//     required this.siteId,
//     required this.xMax,
//     required this.xMin,
//     required this.yMax,
//     required this.yMin,
//     required this.zoneName,
//   });

//   factory ZoneModel.fromJson(Map<String, dynamic> json) {
//     return ZoneModel(
//       id: json['id'] ?? 0,
//       siteId: json['site_id'] ?? 0,
//       xMax: json['x_max'] ?? '',
//       xMin: json['x_min'] ?? '',
//       yMax: json['y_max'] ?? '',
//       yMin: json['y_min'] ?? '',
//       zoneName: json['zone_name'] ?? '',
//     );
//   }
// }



import 'package:equatable/equatable.dart';

class ZoneModel extends Equatable{
  final int? id;
  final int? siteId;
  final String? xMax;
  final String? xMin;
  final String? yMax;
  final String? yMin;
  final String? zoneName;

  const ZoneModel({
     this.id,
     this.siteId,
     this.xMax,
     this.xMin,
     this.yMax,
     this.yMin,
     this.zoneName,
  });

    @override
  
  List<Object?> get props =>[
     id,
     siteId,
     xMax,
     xMin,
     yMax,
     yMin,
     zoneName,
  ];

  ZoneModel copyWith({
    int? id,
    int? siteId,
   String? xMax,
   String? xMin,
  String? yMax,
   String? yMin,
   String? zoneName,

  })
  {
  return    ZoneModel(
   id: id?? this.id,
   siteId: siteId?? this.siteId,
   xMax: xMax?? this.xMax,
   xMin: xMin?? this.xMax,
   yMax: yMax?? this.yMax,
   yMin: yMin?? this.yMin,
   zoneName: zoneName?? this.zoneName,
    );
    
  }
  

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json['id'],
      siteId: json['site_id'],
      xMax: json['x_max'],
      xMin: json['x_min'],
      yMax: json['y_max'],
      yMin: json['y_min'],
      zoneName: json['zone_name'],
    );
  }
  
  @override
  String toString() => '{id: $id, siteid: $siteId, xmax: $xMax, xmin: $xMin, ymax: $yMax, ymin: $yMin,zonename: $zoneName}';
  

}

