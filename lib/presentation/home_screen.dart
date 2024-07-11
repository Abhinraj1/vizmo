import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vizmo/core/cubit/home_cubit/home_cubit.dart';
import 'package:vizmo/core/cubit/home_cubit/home_cubit.dart';
import 'package:vizmo/utils/get_events_by_date.dart';

import '../core/cubit/event_details_cubit/event_details_cubit.dart';
import '../core/model/event_model.dart';
import '../maanger/color_manager.dart';
import '../maanger/font_manager.dart';
import '../utils/formate_date.dart';
import '../widgets/home_widgets/animated_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Data>> events = {};
  List<Data> eventByDate = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeCubit>(context).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            List<Data> dataList = [];
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeLoaded) {
              dataList = state.events;
              events = getEventsByDate(dataList);
              final formattedDate = formateDate(_selectedDay);
              eventByDate = events[formattedDate] ?? [];
            }
            return Column(
              children: [
                TableCalendar(
                  calendarStyle: CalendarStyle(
                    selectedTextStyle: calenderDefaultFont,
                    selectedDecoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                        color: appOrange,
                        borderRadius: BorderRadius.circular(8)),
                    markerDecoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    defaultTextStyle: calenderDefaultFont,
                    weekendTextStyle: calenderWeekendsFont,
                  ),

                  eventLoader: (day) {
                    DateTime formattedDate =
                        DateTime.parse(DateFormat('yyyy-MM-dd').format(day));
                    return events[formattedDate] ?? [];
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        final formattedDate = formateDate(_selectedDay);
                        eventByDate = events[formattedDate] ?? [];
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  firstDay: DateTime.now().subtract(const Duration(days: 1000)),
                  lastDay: DateTime.now().add(const Duration(days: 1000)),
                  // Additional configurations for TableCalendar
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: eventByDate.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          BlocProvider.of<EventDetailsCubit>(context)
                              .showDetails(id: eventByDate[index].id ?? "");
                        },
                        title: Text(
                          eventByDate[index].title ?? "N/A",
                          style: eventTileTitle,
                        ),
                        leading: const Icon(
                          CupertinoIcons.book_circle,
                          color: Colors.white,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            BlocProvider.of<HomeCubit>(context)
                                .deleteData(id:eventByDate[index].id ?? "");
                          },
                          icon: const Icon(
                            CupertinoIcons.delete,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
