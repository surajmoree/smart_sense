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
import 'package:workmanager/workmanager.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await initializeService();// for initialize background service 
   await initializeNotifications();//initialize  for getting notification
  final auth = Authentication();
  final isLogin = await auth.checkLogin();
  final socketManager = SocketManager(auth);
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
// callbackDispatcher function we create to handle task dispatched by workmManager
// even if app is running at background or fully closed
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var setting = InitializationSettings(android: android);
    flip.initialize(setting);
  final auth= Authentication();
  await auth.checkLogin();
    // Initialize the socket connection
    final socketManager = SocketManager(auth);
    socketManager.connectSocket();

  
    

    // Listen for alert notifications and show notifications
  
       socketManager.onAlertNotification = (data) {
        if(auth.loggedIn)
        {
          print('login status---------------${auth.loggedIn}');
 _showNotificationWithDefaultSound(flip, 'Alert', 'You got an alert: ${data['message']}');
        }
     
    };

  
   

    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(FlutterLocalNotificationsPlugin flip, String title, String body) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id', 'your_channel_name',
    importance: Importance.max, priority: Priority.high
  );
  var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  await flip.show(0, title, body, platformChannelSpecifics, payload: 'default_sound');
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
