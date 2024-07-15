/*
class StaffImage {
  final String logo;
  final String logoContentType;

  StaffImage({required this.logo, required this.logoContentType});

  factory StaffImage.fromJson(Map<String, dynamic> json) {
    return StaffImage(
        logo: json['logo'], logoContentType: json['logo_content_type']);
  }

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'logo_content_type': logoContentType,
    };
  }
}

class StaffData {
  final int customerId;
  final String email;
  final String firstName;
  final String fullName;
  final int id;
  final String lastName;
  final String? middleName;
  final int roleId;
  final String roleName;

  StaffData(
      {required this.customerId,
      required this.email,
      required this.firstName,
      required this.fullName,
      required this.id,
      required this.lastName,
      required this.middleName,
      required this.roleId,
      required this.roleName});

      StaffData copyWith({
    int? id,
    int? customerId,
    String? email,
    String? firstName,
    String? lastName,
    String? fullName,
    String? middleName,
    int? roleId,
    String? roleName,
   
  }) {
    return StaffData(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      middleName: middleName ?? this.middleName,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      
    );
  }
  factory StaffData.fromJson(Map<String, dynamic> json) {
    return StaffData(
      customerId: json['customer_id'],
      email: json['email'],
      firstName: json['first_name'],
      fullName: json['full_name'],
      id: json['id'],
      lastName: json['last_name'],
      middleName: json['middle_name'],
      roleId: json['role_id'],
      roleName: json['role_name'],
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'email': email,
      'first_name': firstName,
      'full_name': fullName,
      'id': id,
      'last_name': lastName,
      'middle_name': middleName,
      'role_id': roleId,
      'role_name': roleName,
    };
  }
}

class ApiResponse
{
  final StaffImage staffImage;
  final StaffData staffData;

  ApiResponse({required this.staffImage, required this.staffData});


    factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      staffImage: StaffImage.fromJson(json['userImg']),
      staffData: StaffData.fromJson(json['users']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userImg': staffImage.toJson(),
      'users': staffData.toJson(),
    };
  }
  
}

*/

class StaffImage {
  final String logo;
  final String logoContentType;

  StaffImage( {required this.logo,required this.logoContentType,});

  factory StaffImage.fromJson(Map<String, dynamic> json) {
    return StaffImage(
      logo: json['logo'] ?? '', logoContentType: json['logo_content_type']?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'logo_content_type': logoContentType,
    };
  }
}


class StaffData {
  final int customerId;
  final String email;
  final String firstName;
  final String fullName;
  final int id;
  final String lastName;
  final String? middleName;
  final int roleId;
  final String roleName;

  StaffData(
      {required this.customerId,
      required this.email,
      required this.firstName,
      required this.fullName,
      required this.id,
      required this.lastName,
      required this.middleName,
      required this.roleId,
      required this.roleName});

   
  factory StaffData.fromJson(Map<String, dynamic> json) {
    return StaffData(
      customerId: json['customer_id']??0,
      email: json['email']??'',
      firstName: json['first_name']??'',
      fullName: json['full_name']??'',
      id: json['id']??0,
      lastName: json['last_name']??'',
      middleName: json['middle_name']??'',
      roleId: json['role_id']??0,
      roleName: json['role_name']??'',
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'email': email,
      'first_name': firstName,
      'full_name': fullName,
      'id': id,
      'last_name': lastName,
      'middle_name': middleName,
      'role_id': roleId,
      'role_name': roleName,
    };
  }
}

class ApiResponse
{
  final StaffImage staffImage;
  final StaffData staffData;

  ApiResponse({required this.staffImage, required this.staffData});


    factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      staffImage: StaffImage.fromJson(json['userImg']??{}),
      staffData: StaffData.fromJson(json['users']?? {}),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userImg': staffImage.toJson(),
      'users': staffData.toJson(),
    };
  }
  
}
