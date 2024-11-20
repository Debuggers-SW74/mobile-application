import 'package:flutter/material.dart';

class ScreenTemplate extends StatelessWidget {
  const ScreenTemplate(
      {super.key,
      required this.children,
      this.paddingTop = 24.0,
      this.paddingBottom = 24.0});
  final List<Widget> children;
  final double paddingTop;
  final double paddingBottom;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: paddingTop, right: 48.0, left: 48.0, bottom: paddingBottom),
        child: Center(
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
