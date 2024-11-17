import 'package:fastporte/common/constants/button_type.enum.dart';
import 'package:fastporte/widgets/app_bar/logged.app_bar.dart';
import 'package:fastporte/widgets/elevated_button/custom.elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app.constraints.constant.dart';
import '../../../widgets/container/shadow.box_decoration.dart';
import 'NotificationType.dart';

class ClientNotificationsScreen extends StatefulWidget {
  const ClientNotificationsScreen({super.key});

  @override
  State<ClientNotificationsScreen> createState() =>
      _ClientNotificationsScreenState();
}

class _ClientNotificationsScreenState extends State<ClientNotificationsScreen> {
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
        child: Column(
          children: [
            const SizedBox(height: AppConstrainsts.spacingLarge),
            Expanded(
              child :
                //Lista de notificaciones
                ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const NotificationComponent(
                      notificationType: NotificationType.tripAssigned,
                    );
                  },
                ),

            ),
          ],
        ),
      ),
    );
  }
}


class NotificationComponent extends StatefulWidget {
  const NotificationComponent({super.key, required this.notificationType});

  final NotificationType notificationType;

  @override
  State<NotificationComponent> createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {

  String? _notificationTitle;
  String? _notificationImageUrl;

  @override
  Widget build(BuildContext context) {

    switch (widget.notificationType) {
      case NotificationType.tripAssigned:
        _notificationTitle = 'Trip assigned';
        _notificationImageUrl = 'https://static.vecteezy.com/system/resources/previews/046/014/200/non_2x/check-mark-icon-symbols-free-png.png';
        break;
      case NotificationType.tripCancelled:
        _notificationTitle = 'Trip cancelled';
        _notificationImageUrl = 'https://png.pngtree.com/png-vector/20190215/ourmid/pngtree-vector-cancel-icon-png-image_533028.jpg';
        break;
      case NotificationType.tripFinished:
        _notificationTitle = 'Trip completed';
        _notificationImageUrl = 'https://thumbs.dreamstime.com/b/task-completed-vector-icon-isolated-white-background-83422757.jpg';
        break;
      case NotificationType.tripStarted:
        _notificationTitle = 'Trip started';
        _notificationImageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXhHbH6ioC2SAdojY2CgLwX4FQhhcWZcQKOA&s';
        break;
      default:
        _notificationTitle = 'Trip assigned';
        _notificationImageUrl = 'https://static.vecteezy.com/system/resources/previews/046/014/200/non_2x/check-mark-icon-symbols-free-png.png';
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
            backgroundImage: NetworkImage(_notificationImageUrl!)
          ),
          const SizedBox(width: AppConstrainsts.spacingLarge),
          Column(
            children: [
              RichText(text: TextSpan(
                text: _notificationTitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )),
              const SizedBox(height: AppConstrainsts.spacingSmall),
              CustomElevatedButton(
                text: 'View details',
                type: ButtonType.primary,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}


