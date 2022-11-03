import 'package:intl/intl.dart';

extension ToDateIosFormatHr on DateTime {
    String? toDateIosFormatHr() {
       try {
          return new DateFormat('EEE MMM d hh:mmp').format(this);
       } catch (e) {
          return null;
       }
    }
 }