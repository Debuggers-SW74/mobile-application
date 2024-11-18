import 'package:fastporte/common/constants/default_data.constant.dart';
import 'package:fastporte/models/entities/trip.model.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app.constraints.constant.dart';
import '../text/custom_detail.rich_text.dart';

class DriverResume extends StatelessWidget {
  const DriverResume({super.key, required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Driver data',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppConstrainsts.spacingSmall),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                DefaultData.DEFAULT_PROFILE_IMAGE
                //widget.requestService.driver.profilePicture),
              ),
            ),
            SizedBox(width: AppConstrainsts.spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDetailRichText(
                    title: '',
                    description: trip.driverName! ?? "",
                  ),
                  SizedBox(height: AppConstrainsts.spacingSmall),
                  CustomDetailRichText(
                    title: 'Cel.: ',
                    description: trip.driverPhoneNumber ?? "",
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
