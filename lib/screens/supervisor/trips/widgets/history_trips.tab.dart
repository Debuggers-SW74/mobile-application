import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/default_data.constant.dart';
import 'package:fastporte/models/entities/trip.model.dart';
import 'package:fastporte/services/trip/trip.service.dart';
import 'package:fastporte/widgets/contracts/driver_resume.widget.dart';
import 'package:fastporte/widgets/contracts/trip_resume.widget.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/app.colors.constant.dart';
import '../../../../common/constants/button_type.enum.dart';
import '../../../../widgets/elevated_button/custom.elevated_button.dart';

class FinishedSupervisorTripsTab extends StatefulWidget {
  const FinishedSupervisorTripsTab({super.key});

  @override
  State<FinishedSupervisorTripsTab> createState() => _FinishedSupervisorTripsTabState();
}

class _FinishedSupervisorTripsTabState extends State<FinishedSupervisorTripsTab> {

  final ScrollController _scrollController = ScrollController();
  final TripService _tripService = TripService();
  late Future<List<Trip>> _futureTrips;

  @override
  void initState() {
    super.initState();

    _futureTrips = _tripService.getTripsBySupervisorIdAndStatusId(DefaultData.FINISHED_STATUS_ID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 48.0,
        left: 48.0,
        bottom: AppConstrainsts.spacingLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text(
              'Trips finished',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: AppConstrainsts.spacingSmall),
          FutureBuilder<List<Trip>>(
            future: _futureTrips,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No finished trips found'));
              } else {
                List<Trip> trips = snapshot.data!.toList();

                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      Trip trip = trips[index];
                      return TripResume(
                        userResume: DriverResume(trip: trip),
                        rowButtons: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                          ],
                        ),
                        trip: trip,
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}