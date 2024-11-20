import 'package:flutter/material.dart';

class TemplatePrefixText extends StatelessWidget {
  const TemplatePrefixText({
    super.key,
    this.text = '+51',
    this.dividerThickness = 1.0,
    this.textColor = Colors.black,
    this.dividerColor = Colors.grey,
    
  });

  final String text;
  final double dividerThickness;
  final Color textColor;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        //padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 10.0),
            Text(text,
                style: TextStyle(
                  color: textColor,
                )),
            const SizedBox(width: 8.0),
            SizedBox(
              height: 24.0,
              child: VerticalDivider(
                width: 1.0,
                thickness: dividerThickness,
                color: dividerColor,
              ),
            ),
            const SizedBox(width: 8.0),
          ],
        ));
  }
}
