import 'package:intl/intl.dart';

extension TimeFormat on DateTime {
  String? timeFormat() {
    var out = 'P';
    try {
      if (this.hour < 13) {
        out = 'A';

      }
      return new DateFormat('h:mm$out').format(this);
    } catch (e) {
      return null;
    }
  }
}
