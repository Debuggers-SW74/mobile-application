import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/common/constants/default_data.constant.dart';
import 'package:fastporte/models/entities/trip.model.dart';
import 'package:fastporte/services/trip/trip.service.dart';
import 'package:fastporte/widgets/contracts/driver_resume.widget.dart';
import 'package:fastporte/widgets/contracts/trip_resume.widget.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/app.colors.constant.dart';

class PendingSupervisorTripsTab extends StatefulWidget {
  const PendingSupervisorTripsTab({super.key});

  @override
  State<PendingSupervisorTripsTab> createState() => _PendingSupervisorTripsTabState();
}

class _PendingSupervisorTripsTabState extends State<PendingSupervisorTripsTab> {
  final ScrollController _scrollController = ScrollController();
  final TripService _tripService = TripService();
  late Future<void> _futureTrips;
  List<Trip> _trips = []; // Mantener la lista de trips como un estado persistente

  @override
  void initState() {
    super.initState();
    _futureTrips = _loadTrips();
  }

  Future<void> _loadTrips() async {
    final results = await Future.wait([
      _tripService.getTripsBySupervisorIdAndStatusId(DefaultData.PENDING_STATUS_ID),
      _tripService.getTripsBySupervisorIdAndStatusId(DefaultData.IN_PROGRESS_STATUS_ID),
    ]);

    // Combinar las listas en una sola
    setState(() {
      _trips = results.expand((trips) => trips).toList();
    });
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
          FutureBuilder<void>(
            future: _futureTrips,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (_trips.isEmpty) {
                return const Center(child: Text('No pending trips found'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _trips.length,
                    itemBuilder: (context, index) {
                      Trip trip = _trips[index];
                      if (trip.status == 'IN_PROGRESS') {
                        return TripResume(
                          userResume: DriverResume(trip: trip),
                          rowButtons: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomElevatedButton(
                                onPressed: () async {
                                  final success = await _tripService.changeTripStatusToFinish(trip.tripId!);

                                  if (success) {
                                    setState(() {
                                      _trips.removeAt(index);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Trip finished successfully'),
                                          backgroundColor: AppColors.secondary,
                                        ),
                                      );
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Failed to finish trip'),
                                        backgroundColor: AppColors.error,
                                      ),
                                    );
                                  }
                                },
                                text: 'Finish',
                                type: ButtonType.secondary,
                                isEnabled: true,
                              ),
                              CustomElevatedButton(
                                onPressed: () async {
                                  final success = await _tripService.changeTripStatusToCancel(trip.tripId!);

                                  if (success) {
                                    setState(() {
                                      _trips.removeAt(index);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Trip cancelled successfully'),
                                          backgroundColor: AppColors.secondary,

                                        ),
                                      );
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Failed to cancel trip'),
                                        backgroundColor: AppColors.error,
                                      ),
                                    );
                                  }
                                },
                                text: 'Cancel',
                                type: ButtonType.error,
                                isEnabled: trip.status == 'IN_PROGRESS' ? false : true,
                              ),
                            ],
                          ),
                          trip: trip,
                        );
                      }
                      else if (trip.status == 'PENDING') {
                        return TripResume(
                          userResume: DriverResume(trip: trip),
                          rowButtons: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomElevatedButton(
                                onPressed: () async {
                                  final success = await _tripService.changeTripStatusToStart(trip.tripId!);

                                  if (success) {
                                    setState(() {
                                      trip.status = 'IN_PROGRESS';
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Trip started successfully'),
                                          backgroundColor: AppColors.secondary,
                                        ),
                                      );
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Failed to start trip'),
                                        backgroundColor: AppColors.error,
                                      ),
                                    );
                                  }
                                },
                                text: 'Start',
                                type: ButtonType.secondary,
                                isEnabled: true,
                              ),
                              CustomElevatedButton(
                                onPressed: () async {
                                  final success = await _tripService.changeTripStatusToCancel(trip.tripId!);

                                  if (success) {
                                    setState(() {
                                      _trips.removeAt(index);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Trip cancelled successfully'),
                                          backgroundColor: AppColors.secondary,

                                        ),
                                      );
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Failed to cancel trip'),
                                        backgroundColor: AppColors.error,
                                      ),
                                    );
                                  }
                                },
                                text: 'Cancel',
                                type: ButtonType.error,
                                isEnabled: trip.status == 'IN_PROGRESS' ? false : true,
                              ),
                            ],
                          ),
                          trip: trip,
                        );
                      }
                      else {
                        return const Text('');
                      }
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
