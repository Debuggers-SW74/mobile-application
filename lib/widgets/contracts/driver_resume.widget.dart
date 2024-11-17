import 'package:flutter/material.dart';

import '../../common/constants/app.constraints.constant.dart';
import '../text/custom_detail.rich_text.dart';

class DriverResume extends StatelessWidget {
  const DriverResume({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Driver data',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppConstrainsts.spacingSmall),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                'https://www.shutterstock.com/image-photo/cellphone-smile-portrait-man-studio-260nw-2469535563.jpg',
                //widget.requestService.driver.profilePicture),
              ),
            ),
            const SizedBox(width: AppConstrainsts.spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDetailRichText(
                    title: '',
                    description: 'John Doe', //widget.requestService.driver.name,
                  ),
                  const SizedBox(height: AppConstrainsts.spacingSmall),
                  CustomDetailRichText(
                    title: 'Cel.: ',
                    description:
                    '987654321', //widget.requestService.driver.phoneNumber,
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
