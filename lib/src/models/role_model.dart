class RoleModel {
  final int id;
  final String roleName;

  RoleModel({required this.id, required this.roleName});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'] ?? 0,
      roleName: json['role_name'] ?? '',
    );
  }
}