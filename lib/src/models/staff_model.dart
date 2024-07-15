// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class StaffModel extends Equatable {
  final int? customer_id;
  final String? customer_name;
  final String? email;
  final String? first_name;
  final String? full_name;
  final int? id;
  final String? imageContentType;
  final int? role_id;
  final int? site_id;
  final String? site_name;
  final String? userImg;

  const StaffModel( {
    this.customer_id,
    this.customer_name,
    this.email,
    this.first_name,
    this.full_name,
    this.id,
     this.imageContentType,
    this.role_id,
    this.site_id,
    this.site_name,
     this.userImg,
  });

  StaffModel copyWith({
    int? customer_id,
    String? customer_name,
    String? email,
    String? first_name,
    String? full_name,
    int? id,
     String? imageContentType,
    int? role_id,
    int? site_id,
    String? site_name,
    String? userImg,
  }) {
    return StaffModel(
      customer_id: customer_id ?? this.customer_id,
      customer_name: customer_name ?? this.customer_name,
      email: email ?? this.email,
      first_name: first_name ?? this.first_name,
      full_name: full_name ?? this.full_name,
      id: id?? this.id,
      imageContentType: imageContentType?? this.imageContentType,
      role_id: role_id ?? this.role_id,
      site_id: site_id ?? this.site_id,
      site_name: site_name ?? this.site_name,
      userImg: userImg?? this.userImg
    );
  }

  @override
  List<Object?> get props => [
        customer_id,
        customer_name,
        email,
        first_name,
        full_name,
        id,
        imageContentType,
        role_id,
        site_id,
        site_name,
        userImg
      ];

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      customer_id: json['customer_id'],
      customer_name: json['customer_name'],
      email: json['email'],
      first_name: json['first_name'],
      full_name: json['full_name'],
      id: json['id'],
      imageContentType: json['img_content_type'],
      role_id: json['role_id'],
      site_id: json['site_id'],
      site_name: json['site_name'],
      userImg: json['userImg'],
    );
  }

  @override
  String toString() {
    return 'StaffModel{customer_id: $customer_id, customer_name: $customer_name, email: $email, first_name: $first_name, full_name: $full_name,id: $id,img_content_type: $imageContentType, role_id: $role_id, site_id: $site_id, site_name: $site_name, userImg: $userImg}';
  }
}


