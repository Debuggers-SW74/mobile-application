import 'package:fastporte/common/constants/app.routes.constant.dart';
import 'package:fastporte/widgets/app_bar/logged.app_bar.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class ClientMoreScreen extends StatefulWidget {
  const ClientMoreScreen({super.key});

  @override
  State<ClientMoreScreen> createState() => ClientMoreScreenState();
}

class ClientMoreScreenState extends State<ClientMoreScreen> {
  var logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.w('ClientMoreScreen: build');

    return Scaffold(
      appBar: const LoggedAppBar(title: 'More'),
      body: ScreenTemplate(
        children: [
          const Text('Client More Page'),
          ElevatedButton(
            onPressed: () {
              context.goNamed('${AppRoutes.driverMore}_profile');
            },
            child: const Text('Go to profile'),
          )
        ],
      ),
    );
  }
}
