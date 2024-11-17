import 'package:fastporte/common/constants/app.routes.constant.dart';
import 'package:fastporte/widgets/app_bar/logged.app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientFavouritesScreen extends StatefulWidget {
  const ClientFavouritesScreen({super.key});

  @override
  State<ClientFavouritesScreen> createState() => _ClientFavouritesScreenState();
}

class _ClientFavouritesScreenState extends State<ClientFavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoggedAppBar(
        title: 'Favourites',
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Favourites Screen!'),
            ElevatedButton(
                onPressed: () {
                  context.goNamed(AppRoutes.driverHome);
                },
                child: const Text("Home"))
          ],
        ),
      ),
    );
  }
}
