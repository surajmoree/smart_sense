import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sense/src/components/app/app_layout/main_layout.dart';
import 'package:smart_sense/src/components/staffzone.dart';
import 'package:smart_sense/src/socket/bloc/socket_bloc.dart';
import 'package:smart_sense/src/socket/bloc/socket_event.dart';
import 'package:smart_sense/src/socket/bloc/socket_state.dart';

import '../../../config.dart';
import '../../components/menu/bottom_menu.dart';
import '../../config/constant/app_colors.dart';
import 'homepage_bloc/bloc/home_page_bloc_bloc.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? alertDataTab1;
  Map<String, dynamic>? alertDataTab2;
  String  profileImage ='';
  bool isClicked = false;
  bool isDialogActive = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homePageBloc = BlocProvider.of<HomePageBloc>(context);
    homePageBloc.add(FetchStaffDataEvent());

    final socketBloc = BlocProvider.of<SocketBloc>(context);
    socketBloc.add(ConnectSocket());

    return Scaffold(
      
      body: BlocListener<SocketBloc, SocketState>(
        listener: (context, state) {
          if (state is AlertNotificationState) {
            showAlertDialog(context, state.data);
          }
        },
        child: MainLayout(
          bootomNavigationBar: const BottomMenu(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: BlocBuilder<HomePageBloc, HomePageState>(
                    builder: (context, state) {
                      if (state.status == StaffStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.status == StaffStatus.failure) {
                        return const Center(child: Text('Failed to fetch data'));
                      } else if (state.status == StaffStatus.success) {
                        if (state.listStaff.isNotEmpty) {
                          final staffdata = state.listStaff.first;
                         //   print('Image URL: ${staffdata.userImg}');
                           storage.write(key: 'id', value: staffdata.id.toString());
                           storage.write(key: 'siteId', value: staffdata.site_id.toString());
                           storage.write(key: 'img',value: staffdata.userImg);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 35),
                              CircleAvatar(
                                radius: 56,
                                backgroundColor: mainColor,
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(53),
                                    child:  staffdata.userImg != null && staffdata.userImg!.isNotEmpty 
                                      ? Image.memory(base64Decode(staffdata.userImg!,),  
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/person.png',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          'assets/images/person.png',
                                          fit: BoxFit.cover,
                                        ),
                                    // Image.asset(
                                    //   'assets/images/person.png',
                                    // //  staffdata.userImg.toString(),
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    staffdata.customer_name ?? 'No Name',
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    staffdata.site_name ?? 'Site Name',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  // Text(
                                  //   '${staffdata.id}',
                                  //   style: const TextStyle(fontSize: 20),
                                  // ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return const Center(child: Text('No data available'));
                        }
                      } else {
                        return const Center(child: Text('No data available'));
                      }
                    },
                  ),
                ),
                const Row(
                  children: [
                    SizedBox(width: 40),
                    Text(
                      'Your active zones are:',
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const StaffZone(),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: mainColor,
                      ),
                      child:  ClipRRect(
                         borderRadius: BorderRadius.circular(20),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: whiteColor,
                          tabs: const [
                            Tab(text: 'Live alerts'),
                            Tab(text: 'Alerts attended'),
                            Tab(text: 'Closed alerts'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: BlocBuilder<HomePageBloc, HomePageState>(
                        builder: (context, state) {
                          if (state.status == StaffStatus.success && state.listStaff.isNotEmpty) {
                            final staffdata = state.listStaff.first;
                            return TabBarView(
                              controller: _tabController,
                              children: [
                                _buildTabContent('No active alerts', alertDataTab1, null),
                                _buildTabContent('No alerts in attending list', alertDataTab2, staffdata.customer_name),
                                _buildTabContent('No alert history', null, null),
                              ],
                            );
                          } else {
                            return TabBarView(
                              controller: _tabController,
                              children: [
                                _buildTabContent('No active alerts', alertDataTab1, null),
                                _buildTabContent('No alerts in attending list', alertDataTab2, null),
                                _buildTabContent('No alert history', null, null),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context, Map<String, dynamic> data) {
    Completer<void> dialogCompleter = Completer<void>();
    Timer? timer;

    if (isDialogActive) {
      return;
    }

    setState(() {
      isDialogActive = true;
    });

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        timer = Timer(const Duration(seconds: 20), () {
          if (!dialogCompleter.isCompleted) {
            dialogCompleter.complete();
            Navigator.of(context).pop();
          }
        });
        return AlertDialog(
          title: Text(isClicked ? 'Are you still attending?' : 'New Alert'),
          content: Text(
            'Alert Type: ${data['alert_type']}\n'
            'Device: ${data['Device']}\n'
            'Mac: ${data['Mac']}\n'
            'Room: ${data['Room']}\n'
            'Zone: ${data['Zone']}',
          ),
          actions: [
            TextButton(
              child: const Text('Accept'),
              onPressed: () {
                timer?.cancel();
                if (!dialogCompleter.isCompleted) {
                  dialogCompleter.complete();
                }
                setState(() {
                  alertDataTab2 = data;
                  alertDataTab1 = null;
                  isClicked = true;
                  _tabController.animateTo(1);
                  isDialogActive = false;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                timer?.cancel();
                if (!dialogCompleter.isCompleted) {
                  dialogCompleter.complete();
                }
                setState(() {
                  alertDataTab1 = data;
                  alertDataTab2 = null;
                  isClicked = false;
                  _tabController.animateTo(0);
                  isDialogActive = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {
      if (timer?.isActive ?? false) {
        timer?.cancel();
      }
      if (!dialogCompleter.isCompleted) {
        dialogCompleter.complete();
      }
      setState(() {
        if (!isClicked) {
          alertDataTab1 = data;
          alertDataTab2 = null;
        }
        isDialogActive = false;
      });
    });
  }

  Widget _buildTabContent(String content, Map<String, dynamic>? alertData, String? customerName) {
    if (alertData != null) {
      return Center(
        child: GestureDetector(
          onTap: () {
            showAlertDialog(context, alertData);
          },
          child: Container(
            height: 220,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: greenColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 36,
                  backgroundColor: mainColor,
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(53),
                      child: Image.asset(
                        'assets/images/male.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Alert From \n'
                  'Device: ${alertData['Device']}\n'
                  'Room: ${alertData['Room']}\n'
                  '${customerName != null ? 'Attended by: $customerName\n' : ''}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Center(
      child: Text(
        content,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}