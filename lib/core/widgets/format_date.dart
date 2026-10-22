import 'package:easy_localization/easy_localization.dart';
// ignore: unnecessary_import
import 'package:intl/intl.dart';
class FormatDate {
  String formatDate(DateTime? date) {
    if (date == null) {
      return 'no_data'.tr();
    }
    return DateFormat('yyyy-MM-dd | HH:mm').format(date);
  }
}