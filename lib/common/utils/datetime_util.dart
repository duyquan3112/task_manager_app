import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/common/utils/text_util.dart';

enum DateTimeFormat {
  dd_MM_yyyy,
  yyyy_MM_dd,
  HH_mm_dd_MM_yyyy,
  HH_mm_dd_MM,
  dd_MM_yyyy_HH_mm,
  yyyy_MM_dd_HH_mm_ssSS,
  yyyy_MM_dd_HH_mm,
}

extension DateTimeFormatExtension on DateTimeFormat {
  String get getString {
    switch (this) {
      case DateTimeFormat.yyyy_MM_dd_HH_mm:
        return "yyyy-MM-dd HH:mm";
      case DateTimeFormat.yyyy_MM_dd_HH_mm_ssSS:
        return "yyyy-MM-dd HH:mm:ssZ";
      case DateTimeFormat.dd_MM_yyyy:
        return "dd-MM-yyyy";
      case DateTimeFormat.yyyy_MM_dd:
        return "yyyy-MM-dd";
      case DateTimeFormat.HH_mm_dd_MM_yyyy:
        return "HH:mm - dd/MM/yyyy";
      case DateTimeFormat.HH_mm_dd_MM:
        return "HH:mm - dd/MM";
      case DateTimeFormat.dd_MM_yyyy_HH_mm:
        return "dd-MM-yyyy - HH:mm";
    }
  }
}

class DateTimeUtil {
  DateTimeUtil._();

  static String convertDate(
    String? dateString, {
    DateTimeFormat fromFormat = DateTimeFormat.dd_MM_yyyy,
    DateTimeFormat toFormat = DateTimeFormat.yyyy_MM_dd,
    bool isFromUtc = false,
    String? locale,
  }) {
    if ((locale ?? '').isNotEmpty) {
      initializeDateFormatting(locale);
    }

    if (TextUtils.isEmpty(dateString)) return '';
    if (isFromUtc) {
      final date = DateFormat(fromFormat.getString).parseUTC(dateString!).toLocal();
      return DateFormat(toFormat.getString, locale).format(date);
    }
    final date = DateFormat(fromFormat.getString).parse(dateString!);
    return DateFormat(toFormat.getString, locale).format(date);
  }

  static DateTime? getDate(
    String? date, {
    DateTimeFormat format = DateTimeFormat.dd_MM_yyyy,
    bool isFromUTC = false,
  }) {
    try {
      if (TextUtils.isEmpty(date)) {
        return null;
      }
      if (isFromUTC) {
        return DateFormat(format.getString).parseUTC(date!).toLocal();
      }
      return DateFormat(format.getString).parse(date!);
    } catch (e) {
      return null;
    }
  }
}
