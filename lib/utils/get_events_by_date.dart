import 'package:intl/intl.dart';

import '../core/model/event_model.dart';

Map<DateTime, List<Data>> getEventsByDate(List<Data> events) {
  Map<DateTime, List<Data>> groupedEvents = {};

  for (var event in events) {
    DateTime date = DateTime.parse(event.startAt.toString());
    DateTime formattedDate =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
    if (groupedEvents[formattedDate] == null) groupedEvents[formattedDate] = [];
    groupedEvents[formattedDate]!.add(event);
  }

  return groupedEvents;
}
