import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/models/entities/notification.dart';
import 'package:fastporte/services/notifications/notification.service.dart';
import 'package:fastporte/widgets/app_bar/logged.app_bar.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app.constraints.constant.dart';
import '../../../widgets/container/shadow.box_decoration.dart';

class ClientNotificationsScreen extends StatefulWidget {
  const ClientNotificationsScreen({super.key, required this.userType});

  final String userType;
  @override
  State<ClientNotificationsScreen> createState() =>
      _ClientNotificationsScreenState();
}

class _ClientNotificationsScreenState extends State<ClientNotificationsScreen> {
  final NotificationService _notificationService = NotificationService();
  late Future<List<UserNotification>> _futureNotifications;

  @override
  void initState() {
    super.initState();
    _futureNotifications = _notificationService.getNotificationByUserId(widget.userType);
  }

  Future<void> _refreshNotifications() async {
    setState(() {
      _futureNotifications = _notificationService.getNotificationByUserId(widget.userType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoggedAppBar(title: 'Notifications'),
      body: Container(
        padding: const EdgeInsets.only(
          right: 48.0,
          left: 48.0,
          bottom: AppConstrainsts.spacingLarge,
        ),
        child: RefreshIndicator(
          onRefresh: _refreshNotifications,
          child: FutureBuilder<List<UserNotification>>(
            future: _futureNotifications,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No notifications found'));
              } else {
                List<UserNotification> notifications = snapshot.data!.toList();

                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationComponent(
                      notification: notifications[index],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class NotificationComponent extends StatefulWidget {
  const NotificationComponent({super.key, required this.notification});

  final UserNotification notification;

  @override
  State<NotificationComponent> createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {
  String? _notificationTitle;
  String? _notificationImage;

  @override
  Widget build(BuildContext context) {
    switch (widget.notification.type) {
      case 'TRIP_ASSIGNED':
        _notificationTitle = 'Trip assigned';
        _notificationImage = 'assets/images/trip_created.png';
        break;
      case 'TRIP_CANCELLED':
        _notificationTitle = 'Trip cancelled';
        _notificationImage = 'assets/images/trip_cancelled.png';
        break;
      case 'TRIP_FINISHED':
        _notificationTitle = 'Trip finished';
        _notificationImage = 'assets/images/trip_finished.png';
        break;
      case 'TRIP_STARTED':
        _notificationTitle = 'Trip started';
        _notificationImage = 'assets/images/trip_started.png';
        break;
      case 'TRIP_CREATED':
        _notificationTitle = 'Trip created';
        _notificationImage = 'assets/images/trip_created.png';
      default:
        _notificationTitle = '';
        _notificationImage =
        '';
    }

    return Container(
      decoration: shadowBoxDecoration(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstrainsts.spacingLarge,
        vertical: AppConstrainsts.spacingLarge,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            backgroundImage: AssetImage(_notificationImage!),
          ),
          const SizedBox(width: AppConstrainsts.spacingLarge),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: _notificationTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppConstrainsts.spacingSmall),
              CustomElevatedButton(
                text: 'View details',
                type: ButtonType.primary,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}