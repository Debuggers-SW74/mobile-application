import 'package:fastporte/widgets/app_bar/logged.app_bar.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:flutter/material.dart';

class ClientEditProfileScreen extends StatefulWidget {
  const ClientEditProfileScreen({super.key, required this.from});
  final String from;

  @override
  State<ClientEditProfileScreen> createState() =>
      _ClientEditProfileScreenState();
}

class _ClientEditProfileScreenState extends State<ClientEditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LoggedAppBar(title: 'Edit Profile', backLeading: true),
      body: ScreenTemplate(
        children: [
          Text('Client Edit Profile Page'),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text('Go to profile'),
          // )
        ],
      ),
    );
  }
}
