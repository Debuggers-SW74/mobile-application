import 'package:flutter/services.dart';

class LastNamesInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'[^a-zA-Z\s]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(_regExp, '');
    newText = newText.replaceAll('  ', ' ');

    int newSelectionIndex = newText.length < newValue.selection.end ? newText.length : newValue.selection.end;

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newSelectionIndex),
        composing: TextRange.empty);
  }
}
