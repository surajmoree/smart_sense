part of 'home_page_bloc_bloc.dart';

 class HomePageEvent extends Equatable {
  @override
  List<Object> get props => [];
 }


class FetchStaffDataEvent extends HomePageEvent
{
  final StaffStatus? status;

  FetchStaffDataEvent({this.status});
}