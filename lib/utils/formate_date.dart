

import 'package:intl/intl.dart';

DateTime formateDate(DateTime? date){
  DateTime formattedDate = DateTime.parse(
      DateFormat('yyyy-MM-dd').format(date ?? DateTime.now()));

  return formattedDate;
}