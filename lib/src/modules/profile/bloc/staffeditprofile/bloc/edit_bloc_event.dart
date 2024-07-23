
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart'as http;
class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object?> get props => [];
}

class EditStaffEvent extends EditEvent {
  final String id;

  const EditStaffEvent({required this.id});
}

class UpdateStaffData extends EditEvent
{
  final Map<String, dynamic>? formData;
  final String id;
  final List<http.MultipartFile> files;
  final File profileImage;

  const UpdateStaffData( {   this.formData, required  this.profileImage, 
    required this.id,required this.files,
  });
}