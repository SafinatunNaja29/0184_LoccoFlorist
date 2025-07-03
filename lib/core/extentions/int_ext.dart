import 'package:intl/intl.dart';

/// Extension untuk format integer menjadi Rupiah
extension IntegerExt on int {
  String get formatToRupiah => NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      ).format(this);
}
