import 'package:fastporte/screens/driver/contracts/widgets/history_contracts.tab.dart';
import 'package:fastporte/screens/driver/contracts/widgets/pending_contracts.tab.dart';
import 'package:fastporte/screens/driver/contracts/widgets/sent_contracts.tab.dart';
import 'package:fastporte/widgets/app_bar/logged.app_bar.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app.colors.constant.dart';

class ClientContractsScreen extends StatelessWidget {
  const ClientContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: LoggedAppBar(title: 'Contracts'),
        body: Column(
          children: [
            ScreenTemplate(
              children: [
                TabBar(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  indicatorColor: AppColors.primary,
                  dividerColor: AppColors.noFocus,
                  tabs: <Widget>[
                    //Tab(child: Text('Sent')),
                    Tab(child: Text('Pending')),
                    Tab(child: Text('History')),
                  ],
                ),
              ]
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  //SentContractsTab(),
                  PendingContractsTab(),
                  HistoryContractsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
