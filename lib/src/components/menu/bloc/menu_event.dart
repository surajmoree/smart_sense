part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
} 


class MenuSelected extends MenuEvent {
  const MenuSelected({required this.bottomMenuSelectedIndex, required this.leftMenuSelectedIndex});
  final int bottomMenuSelectedIndex;
  final int leftMenuSelectedIndex;
  @override
  List<Object?> get props => [bottomMenuSelectedIndex, leftMenuSelectedIndex];
}