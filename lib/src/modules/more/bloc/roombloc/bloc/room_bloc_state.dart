import 'package:equatable/equatable.dart';

import '../../../../../models/staff_room_model.dart';

enum RoomStatus {
  initial,
  loading,
  success,
  failure,
}

class Roomstate extends Equatable {
  final RoomStatus status;
  final List<RoomModel> roomlist;
  final int totalCount;

  const Roomstate(
      {this.status = RoomStatus.initial,
      this.roomlist = const [],
      this.totalCount = 0});

  Roomstate copyWith({
    RoomStatus? status,
    List<RoomModel>? roomlist,
    int? totalCount,
  }) {
    return Roomstate(
        status: status ?? this.status,
        roomlist: roomlist ?? this.roomlist,
        totalCount: totalCount ?? this.totalCount);
  }

  @override
  List<Object?> get props => [status,roomlist,totalCount];
}
