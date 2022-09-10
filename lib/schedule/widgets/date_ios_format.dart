

import 'package:intl/intl.dart';

extension DateIosFormat on DateTime {
    String? dateIosFormat() {
       try {
          return new DateFormat('EEE MMM d').format(this);
       } catch (e) {
          return null;
       }
    }
 }