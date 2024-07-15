import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc():super(const MenuDefaultState()){
      on<MenuSelected>(_selected);
  }
  
  void _selected(MenuSelected event, Emitter<MenuState> emit) {
    emit(MenuSelectedState(leftMenuSelectedIndex: state.leftMenuSelectedIndex, bottomMenuSelectedIndex: event.bottomMenuSelectedIndex));
  }
} 