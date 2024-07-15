part of 'edit_bloc_bloc.dart';
  

  enum EditStatus {
  initial,
  loading,
  success,
  failure,
  updating,
  updated
}

class EditState extends Equatable {
   EditStatus? status;
   ApiResponse? listdata;


   EditState({
    this.status = EditStatus.initial,
    this.listdata,
    
  });

  @override
  List<Object?> get props => [status, listdata,];

  EditState copyWith({
    EditStatus? status,
    ApiResponse? listdata,
    
  }) {
    return EditState(
      status: status ?? this.status,
      listdata: listdata ?? this.listdata,
     
    );
  }
}

