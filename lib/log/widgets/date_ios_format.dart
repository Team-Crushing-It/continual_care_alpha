

import 'package:intl/intl.dart';

extension ToDateIosFormat on DateTime {
    String? toDateIosFormat() {
       try {
          return new DateFormat('EEE MMM d hh:mmp').format(this);
       } catch (e) {
          return null;
       }
    }
 }