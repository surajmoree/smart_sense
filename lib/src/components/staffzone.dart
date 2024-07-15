import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smart_sense/src/modules/homepage/zone_area_bloc/bloc/staff_zone_bloc_bloc.dart';
import 'package:smart_sense/src/network/controller/authentication_siteId.dart';

class StaffZone extends StatelessWidget {
  const StaffZone({super.key});

  @override
  Widget build(BuildContext context) {
    final siteIdNotifier = Provider.of<SiteIdNotifier>(context);
    final staffZoneBloc = BlocProvider.of<StaffZoneBloc>(context);

    //  return Text('zone area');

    return BlocProvider(
      create: (context) => StaffZoneBloc()
        ..add(FetchStaffZone(page: 1, siteId: siteIdNotifier.siteId ?? 66)),
      child: SizedBox(
        width: 300,
        height: 250,
        //   color: Colors.pink,
        child: BlocBuilder<StaffZoneBloc, StaffZoneState>(
          builder: (context, state) {
            if (state.status == ZoneStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == ZoneStatus.failure) {
              return const Center(child: Text('Failed to fetch zone data'));
            } else if (state.status == ZoneStatus.success) {
              if (state.zonelist.isEmpty) {
                return const Center(child: Text('No data available'));
              }
              return Padding(
                padding: const EdgeInsets.only(left: 30),
                child: ListView.builder(
                  itemCount: state.zonelist.length,
                  itemBuilder: (context, index) {
                    final zone = state.zonelist[index];
                    return ListTile(
                      title: Text(zone.zoneName ?? 'No zone name'),
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
    );
  }
}





























/*
class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        centerTitle: true,
      ),
      body: BlocBuilder<StaffZoneBloc, StaffZoneState>(
        builder: (context, state) {
          if (state.status == ZoneStatus.loading && state.zonelist.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == ZoneStatus.failure && state.zonelist.isEmpty) {
            return Center(child: Text('Failed to fetch zone'));
          } else if (state.status == ZoneStatus.success) {
            if (state.zonelist.isEmpty) {
              return Center(child: Text('No zones available'));
            }

            // Fetch the siteId from the first zone in the list
            int siteId = state.zonelist.first.siteId;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.zonelist.length,
                    itemBuilder: (context, index) {
                      final zone = state.zonelist[index];
                      return ListTile(
                        title: Text(zone.zoneName),
                        subtitle: Text('Site ID: ${zone.siteId}'),
                      );
                    },
                  ),
                ),
                if (state.zonelist.length < state.totalCount) // Check if there are more pages
                  ElevatedButton(
                    onPressed: () {
                      int nextPage = (state.zonelist.length ~/ 3) + 1; // Adjust based on your pagination logic
                      context.read<StaffZoneBloc>().add(FetchStaffZone(page: nextPage, siteId: siteId));
                    },
                    child: Text('Load More'),
                  ),
                if (state.status == ZoneStatus.loading && state.zonelist.isNotEmpty)
                  Center(child: CircularProgressIndicator()),
                Text('Current Site ID: $siteId'), // Display the current siteId
              ],
            );
          } else {
            return Center(child: Text('Initial state'));
          }
        },
      ),
    );
  }
}











*/
