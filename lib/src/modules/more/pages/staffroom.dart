import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smart_sense/src/config/constant/app_colors.dart';
import 'package:smart_sense/src/modules/more/bloc/roombloc/bloc/room_bloc_bloc.dart';
import 'package:smart_sense/src/modules/more/bloc/roombloc/bloc/room_bloc_event.dart';
import 'package:smart_sense/src/modules/more/bloc/roombloc/bloc/room_bloc_state.dart';
import 'package:smart_sense/src/network/controller/authentication_siteId.dart';

class  StaffRoom extends StatelessWidget {
  const  StaffRoom({super.key});

  @override
  Widget build(BuildContext context) {
   final siteIdNotifier = Provider.of<SiteIdNotifier>(context);
  // final roomBloc  =  BlocProvider.of<RoomBloc>(context);
        //  return Text('zone area');
       
       return   BlocProvider(
            create: (context) => RoomBloc()..add(FetchPage(page: 1, siteId: siteIdNotifier.siteId ?? 0)),
            child:

             Scaffold(
              
              appBar: AppBar(
              backgroundColor: mainColor,
          title: const Text('Rooms'),
          centerTitle: true,
        ),
               body: 
                       Padding(
                         padding: const EdgeInsets.only(top: 20),
                         child: SizedBox(
                          width: 300,
                          height: 500,
                          child: BlocBuilder<RoomBloc, Roomstate>(
                            builder: (context, state) {
                              if (state.status == RoomStatus.loading) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (state.status == RoomStatus.failure) {
                                return const Center(child: Text('Failed to fetch zone data'));
                              } else if (state.status == RoomStatus.success) {
                                if (state.roomlist.isEmpty) {
                                  return const Center(child: Text('No data available'));
                                }
                                return
                                 Padding(
                                   padding: const EdgeInsets.only(left: 30),
                                   child: ListView.builder(
                                    
                                    itemCount: state.roomlist.length,
                                    itemBuilder: (context, index) {
                                      final zone = state.roomlist[index];
                                      return ListTile(
                                        title: Text(zone.roomName),
                                      
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
