import 'package:flutter/services.dart';

class FirstNameInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'[^a-zA-Z]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Reemplaza lo que no sean letras
    String newText = newValue.text.replaceAll(_regExp, '');

    int newSelectionIndex = newText.length < newValue.selection.end ? newText.length : newValue.selection.end;

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newSelectionIndex),
        composing: TextRange.empty);
  }
}
