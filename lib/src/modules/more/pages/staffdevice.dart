import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smart_sense/src/modules/more/bloc/devivebloc/bloc/device_bloc_bloc.dart';
import 'package:smart_sense/src/modules/more/bloc/devivebloc/bloc/device_bloc_event.dart';
import 'package:smart_sense/src/network/controller/authentication_siteId.dart';

import '../../../config/constant/app_colors.dart';
import '../bloc/devivebloc/bloc/device_bloc_state.dart';
class StaffDevice extends StatelessWidget
{
  const StaffDevice({super.key});

  @override
  Widget build(BuildContext context)
  {
    final siteIdNotifier = Provider.of<SiteIdNotifier>(context);
  //  final deviceBloc = BlocProvider.of<DeviceBloc>(context);

  return  BlocProvider(create: (context)=> DeviceBloc()..add(FetchDataEvent(page: 1, siteId: siteIdNotifier.siteId??0)),
    child: Scaffold(
       appBar: AppBar(
          backgroundColor: mainColor,
          title: const Text('Device'),
          centerTitle: true,
        ),
               body: 
                       Padding(
                         padding: const EdgeInsets.only(top: 20),
                         child: SizedBox(
                          width: 300,
                          height: 500,
                          child: BlocBuilder<DeviceBloc, DeviceState>(
                            builder: (context, state) {
                              if (state.status == DeviceStatus.loading) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (state.status == DeviceStatus.failure) {
                                return const Center(child: Text('Failed to fetch device data'));
                              } else if (state.status == DeviceStatus.success) {
                                if (state.devicelist.isEmpty) {
                                  return const Center(child: Text('No data available'));
                                }
                                return
                                 Padding(
                                   padding: const EdgeInsets.only(left: 30),
                                   child: ListView.builder(
                                    
                                    itemCount: state.devicelist.length,
                                    itemBuilder: (context, index) {
                                      final device = state.devicelist[index];
                                      return ListTile(
                                        title: Text(device.deviceName ),
                                        subtitle: Text(device.deviceAddress),
                                      
                                      );
                                    },
                                                               ),
                                 );
                                        
                                        
                              } else {
                                return const Center(child: Text('No data available'));
                              }
                            },
                          ),
                                               ),
                       ),
                    
                         
                
             ),
    );
   
  }
}