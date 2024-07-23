import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_sense/src/components/app/app_layout/main_layout.dart';
import 'package:smart_sense/src/modules/login/bloc/login_bloc_bloc.dart';
import 'package:smart_sense/src/modules/login/bloc/login_bloc_event.dart';

import '../../components/menu/bottom_menu.dart';
import '../../config/constant/app_colors.dart';
import '../../config/constant/app_icons.dart';
import '../homepage/homepage_bloc/bloc/home_page_bloc_bloc.dart';
import '../profile/bloc/staffeditprofile/bloc/edit_bloc_bloc.dart';
import '../profile/bloc/staffeditprofile/bloc/edit_bloc_event.dart';
import '../profile/pages/staffEditProfile.dart';
class MorePage extends StatelessWidget {

  const MorePage({super.key, });

  @override
  Widget build(BuildContext context) {
    final homePageBloc = BlocProvider.of<HomePageBloc>(context);
    homePageBloc.add(FetchStaffDataEvent());

    return Scaffold(
      body: MainLayout(
        bootomNavigationBar: const BottomMenu(),
        body: Column(
          children: [
            BlocBuilder<HomePageBloc, HomePageState>(builder: (context,state)
            {
                final staffdata = state.listStaff.first;
              return   ListTile(
              leading: const Icon(personIcon),
              title: const Text('Edit Profile'),
              onTap: () {
                if (staffdata.id != null && staffdata.id != null) {
                  context.read<EditBloc>().add(EditStaffEvent(id: staffdata.id.toString()));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StaffProfileData(),
                    ),
                  );
                } else {
              
                  Fluttertoast.showToast(
                    msg: "Profile data is not available",
                    backgroundColor: redColor,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              },
            );

              
            }),
            
            ListTile(
              leading: const Icon(roomIcon),
              title: const Text('Rooms'),
              onTap: () {
                Navigator.pushNamed(context, '/rooms');
              },
            ),
            ListTile(
              leading: const Icon(deviceIcon),
              title: const Text('Devices'),
              onTap: () {
                Navigator.pushNamed(context, '/devices');
              },
            ),
            ListTile(
              leading: const Icon(logoutIcon),
              title: const Text('Logout'),
              onTap: () {
                context.read<LoginBloc>().add(LogOutEvent());
                Navigator.pushNamedAndRemoveUntil(
                    context, '/loginScreen', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
