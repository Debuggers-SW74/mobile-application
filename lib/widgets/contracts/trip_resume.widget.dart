import 'package:fastporte/widgets/contracts/driver_resume.widget.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app.colors.constant.dart';
import '../../common/constants/app.constraints.constant.dart';
import '../container/shadow.box_decoration.dart';
import '../divider/custom.divider.dart';
import '../text/custom_detail.rich_text.dart';

class TripResume extends StatelessWidget {
  const TripResume({super.key, required this.userResume, required this.rowButtons});

  final Widget userResume;
  final Row rowButtons;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: shadowBoxDecoration(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstrainsts.spacingLarge,
        vertical: AppConstrainsts.spacingLarge,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDetailRichText(
            title: 'From: ',
            description: 'Avenida Arica 601 Lima 05, Breña 15083', //widget.requestService.origin,
          ),
          const SizedBox(height: AppConstrainsts.spacingMedium),
          CustomDetailRichText(
            title: 'To: ',
            description: 'Ciudad de Caral, Lomas de Lachay', //widget.requestService.destination,
          ),
          const SizedBox(height: AppConstrainsts.spacingMedium),
          CustomDetailRichText(
            title: 'Service Type: ',
            description: 'Moving', //widget.requestService.typeOfService,
          ),
          const SizedBox(height: AppConstrainsts.spacingMedium),
          CustomDetailRichText(
            title: 'Date: ',
            description: '21/10/2022', //widget.requestService.date,
          ),
          const SizedBox(height: AppConstrainsts.spacingMedium),
          CustomDetailRichText(
            title: 'Time: ',
            description: '09:00 - 15:00',
            //'${widget.requestService.startTime} - ${widget.requestService.endTime}',
          ),
          const CustomDivider(),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 8,
                  child: userResume,
                ),
                const SizedBox(width: AppConstrainsts.spacingSmall),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'S/. 123', //${widget.requestService.amount}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstrainsts.spacingMedium),
          rowButtons,
        ],
      ),
    );
  }
}
