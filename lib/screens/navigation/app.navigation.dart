import 'package:fastporte/common/constants/app.routes.constant.dart';
import 'package:fastporte/screens/auth/login/login.screen.dart';
import 'package:fastporte/screens/auth/register/account_information.screen.dart';
import 'package:fastporte/screens/auth/register/personal_information.screen.dart';
import 'package:fastporte/screens/auth/reset_password/forgot_password.screen.dart';
import 'package:fastporte/screens/auth/reset_password/insert_new_password.screen.dart';
import 'package:fastporte/screens/driver/contracts/contracts.screen.dart';
import 'package:fastporte/screens/driver/home/favourites.screen.dart';
import 'package:fastporte/screens/driver/home/home.screen.dart';
import 'package:fastporte/screens/driver/main.screen.dart';
import 'package:fastporte/screens/driver/more/more.screen.dart';
import 'package:fastporte/screens/driver/notifications/notifications.screen.dart';
import 'package:fastporte/screens/driver/profile/edit_profile.screen.dart';
import 'package:fastporte/screens/driver/profile/profile.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../driver/trip_data/home.current_trip_data.screen.dart';

class AppNavigation {
  AppNavigation._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  //Client keys
  static final _clientHomeNavigatorKey = GlobalKey<NavigatorState>();
  static final _clientSearchNavigatorKey = GlobalKey<NavigatorState>();
  static final _clientContractsNavigatorKey = GlobalKey<NavigatorState>();
  static final _clientNotificationsNavigatorKey = GlobalKey<NavigatorState>();
  static final _clientMoreNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          path: '/login',
          name: AppRoutes.login,
          pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const LoginPage(),
                // transitionsBuilder: (context, animation, secondaryAnimation, child) {
                //   return FadeTransition(opacity: animation, child: child);
                // },
              ),
          routes: [
            GoRoute(
              path: 'register/personal-information',
              name: AppRoutes.registerPersonalInformation,
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const PersonalInformationPage(),
              ),
              routes: [
                GoRoute(
                  path: 'account-information',
                  name: AppRoutes.registerAccountInformation,
                  pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    child: const AccountInformationPage(),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'reset/forgot-password',
              name: AppRoutes.resetForgotPassword,
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const ForgotPassword(),
              ),
              routes: [
                GoRoute(
                  path: 'insert-new-password',
                  name: AppRoutes.resetInsertNewPassword,
                  pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    child: const InsertNewPassword(),
                  ),
                )
              ],
            )
          ]),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, navigationShell) {
          return ClientMainScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _clientHomeNavigatorKey,
            routes: [
              GoRoute(
                  path: '/driver/home',
                  name: AppRoutes.driverHome,
                  builder: (context, state) => const ClientHomeScreen(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'favourites',
                      name: AppRoutes.driverFavourites,
                      builder: (context, state) => const ClientFavouritesScreen(),
                    ),
                    ..._profileRoutes(AppRoutes.driverHome),
                  ])
            ],
          ),
          /*StatefulShellBranch(
            navigatorKey: _clientSearchNavigatorKey,
            routes: [
              GoRoute(
                path: '/driver/search',
                name: AppRoutes.driverSearch,
                builder: (context, state) => const ClientSearchScreen(),
                routes: [
                  GoRoute(
                    path: ':typeVehicle/:quantity',
                    name: AppRoutes.driverSearchResults,
                    builder: (context, state) => ClientSearchResultsScreen(
                      typeVehicle: state.pathParameters['typeVehicle']!,
                      capacity: state.pathParameters['quantity']!,
                    ),
                  ),
                  ..._serviceRequestRoutes(AppRoutes.driverSearch),
                ],
              )
            ],
          ),*/
          StatefulShellBranch(
            navigatorKey: _clientContractsNavigatorKey,
            routes: [
              GoRoute(
                path: '/driver/contracts',
                name: AppRoutes.driverContracts,
                builder: (context, state) => const ClientContractsScreen(),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _clientNotificationsNavigatorKey,
            routes: [
              GoRoute(
                path: '/driver/notifications',
                name: AppRoutes.driverNotifications,
                builder: (context, state) => const ClientNotificationsScreen(),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _clientMoreNavigatorKey,
            routes: [
              GoRoute(
                path: '/driver/more',
                name: AppRoutes.driverMore,
                builder: (context, state) => const ClientMoreScreen(),
                routes: [
                  ..._profileRoutes(AppRoutes.driverMore),
                ],
              )
            ],
          ),
        ],
      ),
    ],
  );

  static List<GoRoute> _profileRoutes(String from) {
    return [
      GoRoute(
        path: 'profile',
        name: '${from}_profile',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ClientProfileScreen(from: from),
        routes: [
          GoRoute(
            path: 'edit',
            name: '${from}_edit_profile',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => ClientEditProfileScreen(from: from),
            routes: [
              GoRoute(
                path: 'change-password',
                name: '${from}_change_password',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => ClientProfileScreen(from: from),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: 'current-trip-data',
        name: '${from}_current_trip_data',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const DriverCurrentTripDataScreen(),
      )
    ];
  }
}
