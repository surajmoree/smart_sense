import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:smart_sense/config.dart';
import 'package:smart_sense/src/modules/profile/bloc/changepassword/bloc/change_password_event.dart';

import '../../../components/app/app_layout/main_layout.dart';
import '../../../config/constant/app_colors.dart';
import '../bloc/changepassword/bloc/change_password_bloc.dart';
import '../bloc/changepassword/bloc/change_password_state.dart';
/*
class Changepassword extends StatefulWidget
{
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocListener<ChangePasswordBloc,ChangePasswordState>(
      listener: (context,state)
    {
      if(state.status.isSubmissionSuccess)
      {
         Fluttertoast.cancel();
          Fluttertoast.showToast(
              msg: "Login Successfully",
              backgroundColor: mainColor,
              toastLength: Toast.LENGTH_SHORT);
      }
      if (state.status.isSubmissionInProgress) {
           Center(
            child: CircularProgressIndicator(
              backgroundColor: redColor, 
              valueColor: AlwaysStoppedAnimation(mainColor), 
              strokeWidth: 5,
            ),
          );
        }
        if (state.status.isSubmissionFailure) {
          Fluttertoast.showToast(
              msg: "Login Failed",
              backgroundColor: redColor,
              toastLength: Toast.LENGTH_SHORT);
        }
    },
    child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: MainLayout(
          
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.only(left: 13, right: 13, top: 18),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 15, right: 15, bottom: 10),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: const [
                                Text(
                                  "New Password:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: blackColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(Icons.star, color: redColor, size: 10)
                              ],
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        
                        Container(
                          height: 55,
                          child: TextFormField(
                            controller: _passwordController,
                            onChanged:(value) {
                            //  context.read<ChangePasswordBloc>().add(PasswordUpdate(value))
                               context.read<ChangePasswordBloc>().add(PasswordUpdate(value));
                            },
                            keyboardType: TextInputType.text,
                           
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: lightGreyColor,
                              hintText: "Enter New Password",
                              
                              hintStyle: TextStyle(
                                  color: hintTextColor,
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ///////////////////////////
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: const [
                                Text(
                                  "Confirm Password:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: blackColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(Icons.star, color: redColor, size: 10)
                              ],
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 55,
                          child: TextFormField(
                            controller: _confPasswordController,
                            keyboardType: TextInputType.text,
                            
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: lightGreyColor,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                  color: hintTextColor,
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                                  width: 150,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: mainColor,
                                  ),
                                  child: ElevatedButton(
                                   onPressed: () async{
                                    final String? id = await storage.read(key: 'id');
                                     context.read<ChangePasswordBloc>().add( UpdateForm(id: id.toString()));
                                   },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(color: whiteColor),
                                    ),
                                  ),
                                ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
*/


class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Fluttertoast.cancel();
          Fluttertoast.showToast(
            msg: "Password changes successfully",
            backgroundColor: mainColor,
            toastLength: Toast.LENGTH_SHORT,
          );
        }
        if (state.status.isSubmissionInProgress) {
          Center(
            child: CircularProgressIndicator(
              backgroundColor: redColor,
              valueColor: AlwaysStoppedAnimation(mainColor),
              strokeWidth: 5,
            ),
          );
        }
        if (state.status.isSubmissionFailure) {
        print('Submission failed: ${state.errorMessage}');
        Fluttertoast.showToast(
          msg: "Password change failed: ${state.errorMessage}",
          backgroundColor: redColor,
          toastLength: Toast.LENGTH_SHORT,
        );
      }
      },
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: MainLayout(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.only(left: 13, right: 13, top: 18),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15, top: 15, right: 15, bottom: 10,
                    ),
                    child: 
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text(
                                "New Password:",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.star, color: redColor, size: 10)
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        BlocBuilder<ChangePasswordBloc, ChangePasswordState>(builder: (context,state)
                        {
                          return SizedBox(
                          height: 55,
                          child: TextFormField(
                            controller: _passwordController,
                            onChanged: (value) {
                              context
                                .read<ChangePasswordBloc>()
                                .add(PasswordUpdate(value));
                            },
                            keyboardType: TextInputType.text,
                            decoration:  InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: lightGreyColor,
                              hintText: "Enter new password",
                              errorText: state.password.invalid ? 'Please enter password': null,
                              hintStyle: const TextStyle(
                                color: hintTextColor,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                        }),
                        
                        const SizedBox(height: 15),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text(
                                "Confirm password:",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.star, color: redColor, size: 10)
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        BlocBuilder<ChangePasswordBloc, ChangePasswordState>(builder: (context,state)
                        {
                          return   SizedBox(
                          height: 55,
                          child: TextFormField(
                            controller: _confPasswordController,
                            onChanged: (value) {
                              context
                                .read<ChangePasswordBloc>()
                                .add(ConfirmPassUpdate(value));
                            },
                            keyboardType: TextInputType.text,
                            decoration:  InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: lightGreyColor,
                              hintText: "Confirm Password",
                              errorText: state.confPassword.invalid ? 'Please enter confirm password' : null,
                              hintStyle: const TextStyle(
                                color: hintTextColor,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                        }),
                      
                        const SizedBox(height: 15),
                        Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: mainColor,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              final String? id = await storage.read(key: 'id');
                              context
                                .read<ChangePasswordBloc>()
                                .add(UpdateForm(id: id.toString()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
