import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sense/src/components/menu/bloc/menu_bloc.dart';
import 'package:smart_sense/src/config/constant/app_colors.dart';

import '../../config/constant/app_icons.dart';

List<String> bottomNavRoutes = ["/homepage", "/audio", "/message", "/morepage",];

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    MenuBloc menuBloc = BlocProvider.of<MenuBloc>(context);
    final state = context.watch<MenuBloc>().state;
    return BottomNavigationBar(
      backgroundColor: mainColor,
      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(alertIcon),
          label: 'Alert',
           backgroundColor: mainColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(micIcon),
          label: 'Audio',
          backgroundColor: mainColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(chatIcon),
          label: 'Chat',
          backgroundColor: mainColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon( moreIcon),
          label: 'More',
          backgroundColor: mainColor,
        ),
      

      
      ],
      currentIndex: state.bottomMenuSelectedIndex,
      selectedItemColor: Colors.black,
      onTap: (value) {
        if (state.bottomMenuSelectedIndex != value) {
          menuBloc.add(MenuSelected(
              bottomMenuSelectedIndex: value,
              leftMenuSelectedIndex: state.leftMenuSelectedIndex));
          Navigator.pushNamed(context, bottomNavRoutes[value]);
        }
      },
    );
  }
}