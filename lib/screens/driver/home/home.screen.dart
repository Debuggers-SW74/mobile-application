import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/app.routes.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/common/constants/default_data.constant.dart';
import 'package:fastporte/models/entities/driver.dart';
import 'package:fastporte/providers/driver_info.provider.dart';
import 'package:fastporte/services/driver/driver.service.dart';
import 'package:fastporte/widgets/app_bar/logged.app_bar.dart';
import 'package:fastporte/widgets/container/shadow.box_decoration.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../models/entities/trip.model.dart';
import '../../../services/trip/trip.service.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  late Driver? driver;

  final DriverService driverService = DriverService();
  final TripService _tripService = TripService();
  late Future<List<Trip>> _futureTrips;

  Logger logger = Logger();

  @override
  void initState() {
    super.initState();

    _futureTrips = _tripService.getTripsByDriverId();
  }

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverInfoProvider>(context);
    driver = driverProvider.driver;

    return Scaffold(
      appBar: const LoggedAppBar(
        title: 'Home',
      ),
      body: (driver != null) ? homeHead(driver!) : homeUserNotFound(),
    );
  }

  ScreenTemplate homeHead(Driver driver) {
    return ScreenTemplate(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const NetworkImage(DefaultData.DEFAULT_PROFILE_IMAGE),
                  ),
                  const SizedBox(height: AppConstrainsts.spacingMedium),
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.titleLarge(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(text: 'Hi, '),
                        TextSpan(text: driver.name),
                        const TextSpan(text: '!'),
                      ],
                    ),
                    maxLines: 2,
                    //overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                    text: 'View trips',
                    type: ButtonType.primary,
                    onPressed: () {
                      context.goNamed(AppRoutes.driverContracts);
                    },
                  ),
                  const SizedBox(height: AppConstrainsts.spacingMedium),
                  GestureDetector(
                    onTap: () {
                      context.goNamed('${AppRoutes.driverHome}_profile');
                    },
                    child: Text(
                      'My account',
                      style: AppTextStyles.labelLarge(context)
                          .copyWith(color: AppColors.onSurface, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstrainsts.spacingLarge),
        const SizedBox(height: AppConstrainsts.spacingLarge),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 32.0,
              child: VerticalDivider(
                width: 1.0,
                thickness: 3.0,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppConstrainsts.spacingMedium),
            Text(
              'Popular Drivers',
              style: AppTextStyles.headlineSmall(context).copyWith(
                color: AppColors.primary,
              ),
            )
          ],
        ),
        const SizedBox(height: AppConstrainsts.spacingMedium),
        Container(
          height: 160.0,
          decoration: const BoxDecoration(
            color: AppColors.surface,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 250.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                decoration: shadowBoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage(client.profileUrl),
                        ),
                        const SizedBox(height: AppConstrainsts.spacingSmall),
                        //Rate del conductor junto con una estrella
                        SizedBox(
                          //width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '4.5',
                                style: AppTextStyles.labelMedium(context),
                              ),
                              const SizedBox(width: 4.0),
                              const Icon(
                                Icons.star,
                                color: AppColors.primary,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: AppConstrainsts.spacingSmall),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${client.name.firstName}\n${client.name.lastName}',
                          style: AppTextStyles.labelMedium(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.onSurface),
                        ),
                        const SizedBox(height: AppConstrainsts.spacingMedium),
                        Text(
                          'Type of Service:',
                          style: AppTextStyles.labelSmall(context),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Heavy Truck',
                          style: AppTextStyles.bodySmall(context).copyWith(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        */
        const SizedBox(height: AppConstrainsts.spacingLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                  height: 32.0,
                  child: VerticalDivider(
                    width: 1.0,
                    thickness: 3.0,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppConstrainsts.spacingMedium),
                Text(
                  'Recent trips',
                  style: AppTextStyles.headlineSmall(context).copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                context.goNamed(AppRoutes.driverContracts);
              },
              child: Text(
                'View all',
                style: AppTextStyles.labelSmall(context)
                    .copyWith(color: AppColors.primary, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstrainsts.spacingMedium),
        Container(
          height: 160.0,
          decoration: const BoxDecoration(
            color: AppColors.surface,
          ),
          child: FutureBuilder<List<Trip>>(
            future: _futureTrips,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No trips found'));
              } else {
                List<Trip> trips = snapshot.data!.take(5).toList(); // Toma solo los primeros 5 trips

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    Trip trip = trips[index];
                    return InkWell(
                      onTap: () {
                        // Navega a la pantalla de detalles del viaje
                        // context.goNamed(AppRoutes.clientContracts);
                      },
                      child: Container(
                        width: 250.0,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        decoration: shadowBoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: const NetworkImage(DefaultData.DEFAULT_PROFILE_IMAGE),
                                ),
                                const SizedBox(height: AppConstrainsts.spacingSmall),
                              ],
                            ),
                            const SizedBox(width: AppConstrainsts.spacingSmall),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Driver info:',
                                    style: AppTextStyles.labelSmall(context).copyWith(color: AppColors.onSurface),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    '${trip.driverName}',
                                    style: AppTextStyles.labelMedium(context).copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.onSurface,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(height: AppConstrainsts.spacingSmall),
                                  Text('From: ${trip.origin}', style: AppTextStyles.labelSmall(context), overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 2.0),
                                  Text('To: ${trip.destination}', style: AppTextStyles.labelSmall(context), overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 2.0),
                                  Text('Date: ${trip.date}', style: AppTextStyles.labelSmall(context), overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 2.0),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        const SizedBox(height: AppConstrainsts.spacingLarge),
        const SizedBox(height: AppConstrainsts.spacingLarge),
        const SizedBox(height: AppConstrainsts.spacingLarge),
        CustomElevatedButton(
          text: 'View current trip data',
          type: ButtonType.secondary,
          onPressed: () {
            context.goNamed('${AppRoutes.driverHome}_current_trip_data');
          },
        ),
      ],
    );
  }

  ScreenTemplate homeUserNotFound() {
    return const ScreenTemplate(
      children: [
        //Circular progress
        CircularProgressIndicator(),
      ],
    );
  }
}
