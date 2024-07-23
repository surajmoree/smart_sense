// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:smart_sense/src/modules/homepage/homepage_bloc/bloc/home_page_bloc_bloc.dart';
import 'package:smart_sense/src/modules/profile/bloc/changepassword/bloc/change_password_bloc.dart';
import 'package:smart_sense/src/modules/profile/bloc/rolebloc/role_bloc.dart';
import 'package:smart_sense/src/network/controller/authentication_controller.dart';
import 'package:smart_sense/src/network/controller/authentication_siteId.dart';
import 'package:smart_sense/src/router/app_router.dart';
import 'package:smart_sense/src/socket/bloc/socket_bloc.dart';
import 'package:smart_sense/src/socket/socket_manager.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'src/components/menu/bloc/menu_bloc.dart';
import 'src/modules/homepage/zone_area_bloc/bloc/staff_zone_bloc_bloc.dart';
import 'src/modules/login/bloc/login_bloc_bloc.dart';
import 'src/modules/more/bloc/devivebloc/bloc/device_bloc_bloc.dart';
import 'src/modules/more/bloc/roombloc/bloc/room_bloc_bloc.dart';
import 'src/modules/profile/bloc/staffeditprofile/bloc/edit_bloc_bloc.dart';
import 'src/socket/bloc/socket_event.dart';





// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final auth = Authentication();
//   final isLogin = await auth.checkLogin();
//   final socketManager = SocketManager();
//   socketManager.connectSocket(); 

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => siteIdNotifier..loadSiteId(),
//       child: MyApp(
//         appRouter: AppRouter(),
//         initialRoute: isLogin ? '/homepage' : '/loginScreen',
//         socketManager: socketManager,
//       ),
//     ),
//   );
// }


// class MyApp extends StatelessWidget {
//   final String? initialRoute;
//   final AppRouter appRouter;
//   final SocketManager socketManager;
//   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

//   const MyApp({
//     Key? key,
//     this.initialRoute,
//     required this.appRouter,
//     required this.socketManager,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => LoginBloc(),
//         ),
//         BlocProvider(create: (context) => HomePageBloc()),
//         BlocProvider(create: (context) => StaffZoneBloc()),
//         BlocProvider(create: (context) => MenuBloc()),
//         BlocProvider(create: (context) => RoleBloc()),
//         BlocProvider(
//           create: (context) => SocketBloc(socketManager)..add(ConnectSocket()),
//         ),
//          BlocProvider(create: (context) => RoomBloc()),
//          BlocProvider(create: (context) => DeviceBloc()),
//          BlocProvider(create: (context) => EditBloc()),
//          BlocProvider(create: (context) => ChangePasswordBloc()),
//         //EditBloc
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         initialRoute: initialRoute,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         navigatorKey: MyApp.navigatorKey,
//         onGenerateRoute: appRouter.onGenerateRoute,
//       ),
//     );
//   }
// }
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('app_icon');
  const  InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);
   tz.initializeTimeZones();
   

  final auth = Authentication();
  final isLogin = await auth.checkLogin();
  final socketManager = SocketManager();
  socketManager.connectSocket(); 

  runApp(
    ChangeNotifierProvider(
      create: (_) => siteIdNotifier..loadSiteId(),
      child: MyApp(
        appRouter: AppRouter(),
        initialRoute: isLogin ? '/homepage' : '/loginScreen',
        socketManager: socketManager,
      ),
    ),
  );
}


class MyApp extends StatelessWidget {
  final String? initialRoute;
  final AppRouter appRouter;
  final SocketManager socketManager;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const MyApp({
    Key? key,
    this.initialRoute,
    required this.appRouter,
    required this.socketManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(create: (context) => HomePageBloc()),
        BlocProvider(create: (context) => StaffZoneBloc()),
        BlocProvider(create: (context) => MenuBloc()),
        BlocProvider(create: (context) => RoleBloc()),
        BlocProvider(
          create: (context) => SocketBloc(socketManager)..add(ConnectSocket()),
        ),
         BlocProvider(create: (context) => RoomBloc()),
         BlocProvider(create: (context) => DeviceBloc()),
         BlocProvider(create: (context) => EditBloc()),
         BlocProvider(create: (context) => ChangePasswordBloc()),
        //EditBloc
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: initialRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: MyApp.navigatorKey,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}


