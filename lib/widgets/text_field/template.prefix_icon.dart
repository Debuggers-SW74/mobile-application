import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:flutter/material.dart';

class TemplatePrefixIcon extends StatelessWidget {

  final IconData iconData;
  final Color iconColor;
  final double dividerThickness;
  final Color dividerColor;

  const TemplatePrefixIcon({
    required this.iconData,
    this.iconColor = Colors.black,
    this.dividerThickness = 1.0,
    this.dividerColor = Colors.grey,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(iconData, color: iconColor, size: AppConstrainsts.iconSizeMedium),
            const SizedBox(width: 10),
            SizedBox(
              height: 24.0,
              child: VerticalDivider(
                width: 1.0,
                thickness: dividerThickness,
                color: dividerColor,
              ),
            ),
          ],
        ));
  }
}
