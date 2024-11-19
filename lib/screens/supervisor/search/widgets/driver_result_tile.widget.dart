import 'package:fastporte/common/constants/default_data.constant.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/app.colors.constant.dart';
import '../../../../common/constants/app.constraints.constant.dart';
import '../../../../models/entities/driver.dart';
import '../../../../widgets/container/shadow.box_decoration.dart';

class DriverResultTile extends StatelessWidget {
  const DriverResultTile({
    super.key,
    required this.driver,
  });

  final Driver driver;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: shadowBoxDecoration(),
      margin: const EdgeInsets.symmetric(
        vertical: AppConstrainsts.spacingSmall,
        horizontal: AppConstrainsts.spacingSmall,
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[200],
            backgroundImage: const NetworkImage(DefaultData.DEFAULT_PROFILE_IMAGE),
            radius: 30,
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppConstrainsts.spacingLarge),
              Text(
                '${driver.name} ${driver.firstLastName} ${driver.secondLastName}',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppConstrainsts.spacingSmall),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: AppConstrainsts.textSizeXSmall,
                    color: AppColors.onSurface,
                  ),
                  children: [
                    TextSpan(
                      text: 'Email: ',
                      style: TextStyle(color: AppColors.onSurface.withOpacity(0.6)),
                    ),
                    TextSpan(
                      text: driver.email,
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppConstrainsts.spacingSmall),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: AppConstrainsts.textSizeXSmall,
                    color: AppColors.onSurface,
                  ),
                  children: [
                    TextSpan(
                      text: 'Phone: ',
                      style: TextStyle(color: AppColors.onSurface.withOpacity(0.6)),
                    ),
                    TextSpan(
                      text: driver.phone,
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppConstrainsts.spacingLarge),
            ],
          ),
          trailing: const Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstrainsts.borderRadius),
          ),
          onTap: () => {}
              /*showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return VehicleDetailBottomSheet(driver: driver);
            },
          ),*/
        ),
      ),
    );
  }
}
