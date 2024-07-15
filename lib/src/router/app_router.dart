import 'package:flutter/material.dart';
import 'package:smart_sense/src/modules/login/login_screen.dart';

import '../modules/audiopage/audioPage.dart';
import '../modules/homepage/mainpage.dart';
import '../modules/message/message.dart';
import '../modules/more/more_page.dart';
import '../modules/profile/pages/staffEditProfile.dart';
import '../modules/more/pages/staffdevice.dart';
import '../modules/more/pages/staffroom.dart';


class AppRouter 
{
  Route? onGenerateRoute(RouteSettings routeSettings)
  {
    switch(routeSettings.name)
    {
      case '/loginScren':
      return MaterialPageRoute(builder: (_)=> const LoginScreen());

      case '/homepage':
      return MaterialPageRoute(builder: (_)=>const Homepage());

      case '/morepage':
      return MaterialPageRoute(builder: (_)=> const MorePage());

      case '/editprofile':
      return MaterialPageRoute(builder: (_)=> const StaffProfileData());

      case '/rooms':
      return MaterialPageRoute(builder: (_)=> const StaffRoom() );

      case '/devices':
      return MaterialPageRoute(builder: (_)=>  const StaffDevice());

      case '/audio':
      return MaterialPageRoute(builder: (_)=> const AudioPage() );

      case '/message':
      return MaterialPageRoute(builder: (_)=>  const MessagePage());

      default : 
       return MaterialPageRoute(builder: (_)=>const  LoginScreen());
    

    }
  }
}