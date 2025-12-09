import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  // Convert a DateTime in 'yyyy-MM-dd' format to a String
  String toStringDateTimeIso() {
    try {
      return  DateFormat('yyyy-MM-dd').format(this);
    } catch (e) {
      throw FormatException('${AppStrings.errorDatetimeToString} $this');
    }
  }

}

extension DateTimeStringExtension on String {
  // Convert string 'yyyy-MM-dd' format to DateTime
  DateTime toStringDateTimeFromIso() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      throw FormatException('${AppStrings.errorStringToDatetime} $this');
    }
  }
}