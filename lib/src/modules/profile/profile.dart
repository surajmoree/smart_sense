import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_sense/src/components/app/app_layout/main_layout.dart';
import 'package:smart_sense/src/modules/homepage/homepage_bloc/bloc/home_page_bloc_bloc.dart';

import '../../config/constant/app_colors.dart';
import '../../config/constant/app_icons.dart';
import 'bloc/staffeditprofile/bloc/edit_bloc_bloc.dart';
import 'bloc/staffeditprofile/bloc/edit_bloc_event.dart';
import 'pages/changePassword.dart';
import 'pages/staffEditProfile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageBloc = BlocProvider.of<HomePageBloc>(context);
  
    
    homePageBloc.add(FetchStaffDataEvent());
  
    return MainLayout(
        body: Column(
      children: [
        Card(
          margin: const EdgeInsets.only(left: 13, right: 13, top: 15),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                                radius: 33,
                                backgroundColor: mainColor,
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(30),
                                    child: Image.asset(
                                      'assets/images/person.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    BlocBuilder<HomePageBloc,HomePageState>(builder: (context,state)
                    {
                     final staffData = state.listStaff.first;
                      return    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          staffData.customer_name.toString(),
                          style: const TextStyle(
                              color: blackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(staffData.email.toString(),
                            style: const TextStyle(
                                color: hintTextColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500))
                      ],
                    );
                    })
                 
                  ],
                )
              ],
            ),
          ),
        ),
        BlocBuilder<HomePageBloc,HomePageState>(builder: (context,state)
        {
          final staffData = state.listStaff.first;
          return   Card(
                    margin: const EdgeInsets.only(left: 13, right: 13, top: 15),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Padding(
                            padding: EdgeInsets.only(top: 2, right: 15),
                            child: Icon(personIcon,size: 20,),
                          ),
                          title: Transform.translate(
                            offset: const Offset(-16, 0),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 7, right: 8, bottom: 4),
                              height: 30,
                              child: const Text(
                                "Update profile",
                                style: TextStyle(color: blackColor),
                              ),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: blackColor,
                          ),
                          onTap: () {
                            if (staffData.id != null) {
                  context.read<EditBloc>().add(EditStaffEvent(id: staffData.id.toString()));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  const StaffProfileData(),
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
                        ),
                        const Divider(
                          color: backgroundColor,
                          thickness: 4,
                        ),
                        ListTile(
                          leading: const Padding(
                            padding: EdgeInsets.only(top: 2, right: 15),
                            child: Icon(personIcon,size: 20,),
                          ),
                          title: Transform.translate(
                            offset: const Offset(-16, 0),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 7, right: 8, bottom: 4),
                              height: 30,
                              child: const Text(
                                "Change Password",
                                style: TextStyle(color: blackColor),
                              ),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: blackColor,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Changepassword()));
                          },
                        ),
                        const Divider(
                          color: backgroundColor,
                          thickness: 4,
                        ),
                       
                      ],
                    ),
                  );
        })
       
      ],
    ));
  }
}
