import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:fastporte/widgets/container/shadow.box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InformationRow extends StatelessWidget {
  const InformationRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: AppConstrainsts.spacingMedium),
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: AppTextStyles.labelLarge(context).copyWith(
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
        const SizedBox(width: AppConstrainsts.spacingMedium),
        Expanded(
          child: InkWell(
            onLongPress: () {
              //Copiar al portapapeles
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Copied to clipboard'),
                  duration: Duration(seconds: 1),
                  backgroundColor: AppColors.secondary,
                ),
              );
            },
            highlightColor: Colors.white , //color transparente
            borderRadius: BorderRadius.circular(AppConstrainsts.borderRadius),
            child: Container(
              height: AppConstrainsts.rowHeight,
              padding: const EdgeInsets.symmetric(horizontal: 36),
              decoration: shadowBoxDecoration(),
              child: Center(
                  child: Text(
                value,
                style: AppTextStyles.bodySmall(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
            ),
          ),
        ),
      ],
    );
  }
}
