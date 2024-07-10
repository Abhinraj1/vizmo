import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../core/model/event_model.dart';
import '../core/repository/main_repo.dart';

class MyCalendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  late Future<List<Data>> futureEvents;
  Map<DateTime, List<Data>> events = {};

  @override
  void initState() {
    super.initState();
    futureEvents = fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Calendar'),
      ),
      body: FutureBuilder<List<Data>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            events = _groupEventsByDate(snapshot.data!);
            return TableCalendar<Data>(
              eventLoader: (day) {
                DateTime formattedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(day));

                // day.isAtSameMomentAs(other);
                print("day======$formattedDate===and=====events=====${events}");
                return events[formattedDate] ?? [];
              },

              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  // Handle day selection if needed
                });
              }, focusedDay: DateTime.now(),
              firstDay: DateTime.now().subtract(Duration(days: 900)),
              lastDay: DateTime.now().add(Duration(days: 900)),
              // Additional configurations for TableCalendar
            );
          }
        },
      ),
    );
  }

  Map<DateTime, List<Data>> _groupEventsByDate(List<Data> events) {
    Map<DateTime, List<Data>> groupedEvents = {};

    for (var event in events) {
      DateTime date = DateTime.parse(event.startAt.toString());
      DateTime formattedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
      print(date);
      // DateTime date = DateTime(event.startAt?.year, event.startTime.month, event.startTime.day);
      if (groupedEvents[formattedDate] == null) groupedEvents[formattedDate] = [];
      groupedEvents[formattedDate]!.add(event);
    }

    return groupedEvents;
  }
}
