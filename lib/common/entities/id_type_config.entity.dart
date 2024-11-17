import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class IdTypeConfig {
  final String name;
  final MaskTextInputFormatter? mask;
  final int length;

  const IdTypeConfig({
    required this.name,
    this.mask,
    required this.length,
  });
}
