import 'package:intl/intl.dart';

class Formatter {
  static String formatprice(int price) {
    final numberformat = NumberFormat('#,##,###');
    return numberformat.format(price);
  }
}
