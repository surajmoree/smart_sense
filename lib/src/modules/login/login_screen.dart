import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:smart_sense/src/config/constant/app_colors.dart';
import 'package:smart_sense/src/modules/login/bloc/login_bloc_bloc.dart';
import 'package:smart_sense/src/modules/login/bloc/login_bloc_event.dart';
import 'package:smart_sense/src/modules/login/bloc/login_bloc_state.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Fluttertoast.cancel();
          Fluttertoast.showToast(
              msg: "Login Successfully",
              backgroundColor: mainColor,
              toastLength: Toast.LENGTH_SHORT);
          Navigator.pushNamed(context,'/homepage');
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
          exit(0);
        },
        child: Scaffold(
       //   backgroundColor: Colors.green,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 420,
                      color: mainColor,
                      child:  Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 180),
                            child: Text(
                              'Welcome back!',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          Text(
                            'Sign in to continue...',
                            style: TextStyle(color: whiteColor),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 270,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: Card(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 10,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            width: MediaQuery.of(context).size.width * 0.88,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: whiteColor,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                EmailInputBox(emailController:emailController ,),
                                 const SizedBox(
                                  height: 20,
                                ),
                                PasswordInputBox(passwordController: passwordController,),
                                const SizedBox(
                                  height: 20,
                                ),
                                LoginButton(emailController:emailController , passwordController: passwordController,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );


  }
}

class EmailInputBox extends StatelessWidget {
  final TextEditingController? emailController;
  const EmailInputBox({super.key, this.emailController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: emailController,
              onChanged: (value) {
                context.read<LoginBloc>().add(EmailUpdate(value));
              },
              textAlign: TextAlign.start,
              keyboardType: TextInputType.emailAddress,
              style:  TextStyle(color: blackColor),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
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
                fillColor: whiteGrey,
                hintText: "Email",
                errorText:
                    state.email.invalid ? 'Please enter email address' : null,
                hintStyle:  TextStyle(
                    color: greyColor,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ));
      },
    );
  }
}


class PasswordInputBox extends StatelessWidget {
  final TextEditingController? passwordController;
  const PasswordInputBox({super.key,  this.passwordController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(
      builder: (context, state) {
        return Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: passwordController,
              onChanged: (value) {
                context.read<LoginBloc>().add(PasswordUpdate(value));
              },
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              style:  TextStyle(color: blackColor),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                //  hintStyle: TextStyle(color: Colors.grey.shade700),
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
                fillColor: whiteGrey,
                hintText: "Password",
                errorText: state.password.invalid
                    ? 'Please enter password'
                    : null,
                hintStyle:  TextStyle(
                    color: greyColor,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ));
      },
    );
  }
}


class LoginButton extends StatelessWidget
{
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const LoginButton({super.key, this.emailController, this.passwordController});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<LoginBloc,LoginState>(builder: (context,state)
    {
      return Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
         width: MediaQuery.of(context).size.width,
         height: 48,
         decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(10)
         ),
        child: ElevatedButton(onPressed: ()async{
          
          if(state.status.isValid)
          {
            await context.read<LoginBloc>().submitLoginForm();
       
          }else
          {
            context.read<LoginBloc>().add(EmailUpdate(emailController!.text));
            context.read<LoginBloc>().add(PasswordUpdate(passwordController!.text));
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: mainColor,shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10))),
        
         child:  Text('Sign In',style: TextStyle(
          fontFamily: 'Mulish',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: whiteColor

        ),)),
      );
    });
  }
}



