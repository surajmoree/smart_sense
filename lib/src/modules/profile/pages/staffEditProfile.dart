import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:smart_sense/src/components/app/app_layout/main_layout.dart';
import 'package:smart_sense/src/config/constant/app_colors.dart';

import '../../../components/form_field_title.dart';
import '../../../components/profileimage.dart';
import '../bloc/staffeditprofile/bloc/edit_bloc_bloc.dart';
import '../bloc/staffeditprofile/bloc/edit_bloc_event.dart';

/*

class StaffProfileData extends StatefulWidget {
  const StaffProfileData({super.key});

  @override
  State<StaffProfileData> createState() => _StaffProfileDataState();
}

class _StaffProfileDataState extends State<StaffProfileData> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  String _userImage = "";
  final _formKey = GlobalKey<FormState>();

  void assignValue(EditState state) {
    setState(() {
      _firstName.text = state.listdata?.firstName ?? '';
      _lastName.text = state.listdata?.lastName ?? '';
      _email.text = state.listdata?.email ?? '';
      print('/////////////$_email.text');
      
      print('imageee***** ${state.listdata!.customerId}');
    
      // if (state.listdata?.userImage?.logo != null) {
      //   _userImage = state.listdata!.userImage!.logo!;
      //   print("User image base64: $_userImage");
      // } else {
      //   print("User image is null");
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditBloc, EditState>(
      listener: (context, state) {
        if (state.status == EditStatus.success) {
          assignValue(state);
        } else if (state.status == EditStatus.updated) {
          Fluttertoast.cancel();
          Fluttertoast.showToast(
            msg: "Staff Profile Updated Successfully",
            backgroundColor: greenColor,
            toastLength: Toast.LENGTH_SHORT,
          );
          Navigator.pushNamed(context, '/homepage');
        } else if (state.status == EditStatus.failure) {
          Fluttertoast.showToast(
            msg: "Failed to update profile",
            backgroundColor: redColor,
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      },
      builder: (context, state) {
        if (state.status == EditStatus.loading || state.status == EditStatus.initial) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: redColor,
              valueColor: AlwaysStoppedAnimation(mainColor),
              strokeWidth: 5,
            ),
          );
        } else {
          return MainLayout(
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FormFieldTitle(title: "Profile Details:"),
                    Card(
                      margin: EdgeInsets.only(left: 13, right: 13, top: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 56,
                              backgroundColor: whiteColor,
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(53),
                                  child: _userImage.isNotEmpty
                                      ? Image.memory(
                                          base64Decode(_userImage),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/person.png', // Path to a default image
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: mainColor,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Implement profile photo update logic
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  'Profile Photo',
                                  style: TextStyle(color: whiteColor),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "First Name:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.star, color: redColor, size: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 55,
                              child: TextFormField(
                                controller: _firstName,
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
                                  hintText: "Enter First Name",
                                  hintStyle: TextStyle(
                                      color: hintTextColor,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "Last Name:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.star, color: redColor, size: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 55,
                              child: TextFormField(
                                controller: _lastName,
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
                                  hintText: "Enter Last Name",
                                  hintStyle: TextStyle(
                                      color: hintTextColor,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "Email:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.star, color: redColor, size: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 55,
                              child: TextFormField(
                                controller: _email,
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
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                      color: hintTextColor,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "Role Type:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.star, color: redColor, size: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 55,
                              child: TextFormField(
                                controller: _email,
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
                                  hintStyle: TextStyle(
                                      color: hintTextColor,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
*/

class StaffProfileData extends StatefulWidget {
  const StaffProfileData({
    super.key,
  });
// final RoleModel roleModel;
  @override
  State<StaffProfileData> createState() => _StaffProfileDataState();
}

class _StaffProfileDataState extends State<StaffProfileData> {
  final TextEditingController _customer_id = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _roleName = TextEditingController();
  final TextEditingController _id = TextEditingController();
  final TextEditingController _middle_Name = TextEditingController();
  final TextEditingController _role_Id = TextEditingController();

  String _userImage = "";
  File profileImage = File('');

  final _formKey = GlobalKey<FormState>();

  void assignValue(
    EditState state,
  ) {
    setState(() {
      _firstName.text = state.listdata?.staffData.firstName ?? '';
      _lastName.text = state.listdata?.staffData.lastName ?? '';
      _email.text = state.listdata?.staffData.email ?? '';
      _roleName.text = state.listdata?.staffData.roleName ?? '';
      _userImage = state.listdata?.staffImage.logo ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditBloc, EditState>(
      listener: (context, state) {
        if (state.status == EditStatus.success) {
          assignValue(state);
        } else if (state.status == EditStatus.updated) {
          Fluttertoast.cancel();
          Fluttertoast.showToast(
            msg: "Staff Profile Updated Successfully",
            backgroundColor: greenColor,
            toastLength: Toast.LENGTH_SHORT,
          );
          Navigator.pushNamed(context, '/homepage');
        } else if (state.status == EditStatus.failure) {
          Fluttertoast.showToast(
            msg: "Failed to update profile",
            backgroundColor: redColor,
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      },
      builder: (context, state) {
        if (state.status == EditStatus.loading ||
            state.status == EditStatus.initial) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: redColor,
              valueColor: AlwaysStoppedAnimation(mainColor),
              strokeWidth: 5,
            ),
          );
        } else {
          return MainLayout(
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const FormFieldTitle(title: "Profile details:"),
                    Card(
                      margin:
                          const EdgeInsets.only(left: 13, right: 13, top: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 15, right: 15, bottom: 10),
                        child: Column(
                          children: [
                            SelectImage(
                              imageFile: profileImage,
                              takeImage: takeImage,
                              existedImageUrl: _userImage,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "First Name:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.star, color: redColor, size: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 55,
                              child: TextFormField(
                                controller: _firstName,
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
                                  hintText: "Enter First Name",
                                  hintStyle: TextStyle(
                                      color: hintTextColor,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "Last Name:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.star, color: redColor, size: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 55,
                              child: TextFormField(
                                controller: _lastName,
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
                                  hintText: "Enter Last Name",
                                  hintStyle: TextStyle(
                                      color: hintTextColor,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "Email:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.star, color: redColor, size: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 55,
                              child: TextFormField(
                                readOnly: true,
                                controller: _email,
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
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                      color: hintTextColor,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "Role type:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.star, color: redColor, size: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 55,
                              child: TextFormField(
                                readOnly: true,
                                controller: _roleName,
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
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Map<String, String> fields = {
                                      'first_name': _firstName.text,
                                      'last_name': _lastName.text,
                                      'email': _email.text,
                                      'role_name': _roleName.text,
                                    };
                                    final List<http.MultipartFile> files = [];
                                    // if (profileImage != null) {
                                    //   print('file path ${profileImage!.path}');
                                    //   final file = File(profileImage!.path);
                                    //   print(
                                    //       'File exists: ${file.existsSync()}');

                                    //   if (file.existsSync()) {
                                    //     final imageFile =
                                    //         await http.MultipartFile.fromPath(
                                    //       'image',
                                    //       profileImage!.path,
                                    //       contentType:
                                    //           MediaType('image', 'jpeg'),
                                    //     );
                                    //     files.add(imageFile);
                                    //   } else {
                                    //     Fluttertoast.showToast(
                                    //       msg: 'file does not exist',
                                    //       backgroundColor: redColor,
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //     );
                                    //     return;
                                    //   }
                                    // }

                                    // ignore: use_build_context_synchronously
                                    context.read<EditBloc>().add(
                                        UpdateStaffData(
                                            id: state.listdata!.staffData.id
                                                .toString(),
                                            formData: fields,
                                            files: files, profileImage: profileImage));
                                  }

                                  // Map<String,String>formData =  {
                                  //   "first_name" : _firstName.text.toString(),
                                  //   "last_name" : _lastName.text.toString(),
                                  //   "email" : _email.text.toString(),
                                  //   "role_name" : _roleName.text.toString(),
                                  // };
                                  //   print("================formdata$formData");
                                  //   context.read<EditBloc>().add(UpdateStaffData(
                                  //     id: state.listdata!.staffData.id.toString(),
                                  //     formData: formData,
                                  //     ));

                                  // final String? id =
                                  //     await storage.read(key: 'id');
                                  // context
                                  //     .read<ChangePasswordBloc>()
                                  //     .add(UpdateForm(id: id.toString()));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text(
                                  'Update',
                                  style: TextStyle(color: whiteColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> takeImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 25,
    );

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }
}
