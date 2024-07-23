
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../config/constant/app_colors.dart';
import 'displayProfileImage.dart';

class SelectImage extends StatelessWidget {

    final Function(ImageSource) takeImage;
  final File imageFile;
  final String existedImageUrl;
  const SelectImage(
      {super.key,
      
      required this.imageFile,
   
      this.existedImageUrl = "", required this.takeImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, top: 15, bottom: 15),
      child: Column(
        children: [
           DisplaySelectedImage(imageFile: imageFile,existedImageUrl: existedImageUrl,),
          const SizedBox(height: 15),
          Container(
                                  width: 150,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: mainColor,
                                  ),
                                  child: ElevatedButton(
                                     onPressed: () => (showImageSource(context)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: const Text(
                                      'Profile Photo',
                                      style: TextStyle(color: whiteColor),
                                    ),
                                  ),
                                ),
        ],
      ),
     
    );
  }

  Future<void> showImageSource(BuildContext context)async
  {
   await showDialog(context: context, builder: (BuildContext context)
   {
    return AlertDialog( title: const Center(child: Text("Select Image From")),content: SingleChildScrollView(
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget> [
          TextButton.icon(onPressed: (){
          Navigator.pop(context);
          takeImage(ImageSource.camera);
          },  icon: Icon(Icons.camera_alt,color: mainColor),
                  label: Text("Camera",style: TextStyle(color: mainColor),),),
       
          TextButton.icon(onPressed: ()
          {
            Navigator.pop(context);
            takeImage(ImageSource.gallery);
          },icon:  Icon(Icons.photo,color: mainColor,), label: Text("Gallary",style: TextStyle(color: mainColor),),)
         
          
        ],
      ),
    ),);
   });
  }
}
