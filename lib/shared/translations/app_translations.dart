import 'package:get/get.dart';
import 'package:luvit/shared/translations/en_us_translation.dart';
import 'package:luvit/shared/translations/kr_translation.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUs,
        'kr': kr,
      };
}
