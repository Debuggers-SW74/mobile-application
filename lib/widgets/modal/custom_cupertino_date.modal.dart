import 'package:flutter/cupertino.dart';

import '../../common/constants/app.colors.constant.dart';
import '../../common/constants/app.text_styles.constant.dart';

class CustomCupertinoDatePicker extends StatelessWidget {
  const CustomCupertinoDatePicker({
    super.key,
    this.selectedDate,
    this.minimumDate,
    this.maximumDate,
    this.mode = CupertinoDatePickerMode.date,
    required this.onDateTimeChanged,
    this.onOkPressed,
  });

  final DateTime? selectedDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final CupertinoDatePickerMode mode;
  final void Function(DateTime) onDateTimeChanged;
  final void Function()? onOkPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: AppTextStyles.labelTextFormField(context),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: mode,
                  use24hFormat: true,
                  dateOrder: DatePickerDateOrder.dmy,
                  minimumDate: minimumDate ?? DateTime.now(),
                  maximumDate: maximumDate ?? DateTime.now().add(const Duration(days: 365)),
                  initialDateTime: selectedDate ?? DateTime.now(),
                  onDateTimeChanged: onDateTimeChanged,
                ),
              ),
            ),
            CupertinoButton(
              onPressed: onOkPressed ?? () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: AppTextStyles.labelTextFormField(context)
                    .copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
