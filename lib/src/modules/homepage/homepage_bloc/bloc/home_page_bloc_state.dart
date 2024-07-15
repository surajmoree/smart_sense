part of 'home_page_bloc_bloc.dart';

enum StaffStatus {
  initial,
  loading,
  success,
  failure,
}

class HomePageState extends Equatable {
  final StaffStatus status;
  final List<StaffModel> listStaff;

  const HomePageState({
    this.status = StaffStatus.initial,
    this.listStaff = const [],
  });

  @override
  List<Object?> get props => [status, listStaff];

  HomePageState copyWith({
    StaffStatus? status,
    List<StaffModel>? listStaff,
  }) {
    return HomePageState(
      status: status ?? this.status,
      listStaff: listStaff ?? this.listStaff,
    );
  }
}


// final class HomePageBlocInitial extends HomePageState {}

