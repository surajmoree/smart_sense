part of 'menu_bloc.dart';


abstract class MenuState extends Equatable {
  const MenuState({required this.leftMenuSelectedIndex, required this.bottomMenuSelectedIndex});
  final int leftMenuSelectedIndex;
  final int bottomMenuSelectedIndex;

  @override 
  List<Object> get props => [leftMenuSelectedIndex, bottomMenuSelectedIndex];
}


class MenuDefaultState extends MenuState {
  const MenuDefaultState({super.leftMenuSelectedIndex = 0, 
  super.bottomMenuSelectedIndex = 0});
}

class MenuSelectedState extends MenuState {
 const MenuSelectedState({ required super.bottomMenuSelectedIndex, required super.leftMenuSelectedIndex});
}
