import 'package:fastporte/common/entities/id_type_config.entity.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class IdTypeConfigs {
  static const String DNI = 'DNI';
  static const String CE = 'CE';

  static Map<String, IdTypeConfig> configs = {
    DNI: IdTypeConfig(
      name: DNI,
      mask: MaskTextInputFormatter(mask: '########', filter: {"#": RegExp(r'[0-9]')}),
      length: 8,
    ),
    CE: IdTypeConfig(
      name: CE,
      mask: MaskTextInputFormatter(mask: '############', filter: {"#": RegExp(r'[0-9]')}),
      length: 12,
    ),
  };
}
