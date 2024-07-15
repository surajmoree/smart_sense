import 'package:equatable/equatable.dart';

import '../../../../models/role_model.dart';


enum RoleStatus {
  initial,
  loading,
  success,
  failure,
}

class RoleState extends Equatable {
  final RoleStatus status;
  final List<RoleModel> rolelist;

  const RoleState({this.rolelist = const [], this.status = RoleStatus.initial});

  RoleState copyWith({RoleStatus? status, List<RoleModel>? rolelist}) {
    return RoleState(
      status: status ?? this.status,
      rolelist: rolelist ?? this.rolelist,
    );
  }

  @override
  List<Object?> get props => [rolelist, status];
}


