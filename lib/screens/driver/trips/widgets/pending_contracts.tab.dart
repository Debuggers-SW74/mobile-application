import 'package:fastporte/common/constants/default_data.constant.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/app.constraints.constant.dart';
import '../../../../models/entities/trip.model.dart';
import '../../../../services/trip/trip.service.dart';
import '../../../../widgets/contracts/trip_resume.widget.dart';
import '../../../../widgets/contracts/driver_resume.widget.dart';

class PendingContractsTab extends StatefulWidget {
  const PendingContractsTab({super.key});

  @override
  State<PendingContractsTab> createState() => _PendingContractsTabState();
}

class _PendingContractsTabState extends State<PendingContractsTab> {
  final ScrollController _scrollController = ScrollController();
  final TripService _tripService = TripService();
  late Future<List<Trip>> _futureTrips;

  @override
  void initState() {
    super.initState();

    _futureTrips = _tripService.getTripsByDriverIdAndStatusId(DefaultData.PENDING_STATUS_ID);
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
              'Pending trips',
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
                return const Center(child: Text('No pending trips found'));
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
                        rowButtons: Row(
                            /*children: [
                      TextButton(
                        onPressed: null,
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: null,
                        child: Text('View'),
                      ),
                    ],*/
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
