import 'package:fastporte/screens/supervisor/trips/widgets/cancelled_trips.tab.dart';
import 'package:fastporte/screens/supervisor/trips/widgets/history_trips.tab.dart';
import 'package:fastporte/screens/supervisor/trips/widgets/pending_trips.tab.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app.colors.constant.dart';
import '../../../widgets/app_bar/logged.app_bar.dart';

class SupervisorTripsScreen extends StatelessWidget {
  const SupervisorTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: LoggedAppBar(title: 'Trips'),
        body: Column(
          children: [
            ScreenTemplate(
                children: [
                  TabBar(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    indicatorColor: AppColors.primary,
                    dividerColor: AppColors.noFocus,
                    tabs: <Widget>[
                      //Tab(child: Text('Sent')),
                      Tab(child: Text('Pending')),
                      Tab(child: Text('Finished')),
                      Tab(child: Text('Cancelled')),
                    ],
                  ),
                ]
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  //SentContractsTab(),
                  PendingSupervisorTripsTab(),
                  FinishedSupervisorTripsTab(),
                  CancelledSupervisorTripsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
