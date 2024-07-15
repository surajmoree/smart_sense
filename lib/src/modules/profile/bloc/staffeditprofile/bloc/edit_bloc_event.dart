part of 'edit_bloc_bloc.dart';

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

  const UpdateStaffData({ this.formData, required this.id});
}