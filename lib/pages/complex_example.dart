import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:volkswagen/colors.dart';
import 'package:volkswagen/widget/roof.dart';
import 'package:volkswagen/widget/window.dart';

import '../utils.dart';
import '../widget/bumper.dart';
import '../widget/number_plate.dart';

class TableComplexExample extends StatefulWidget {
  const TableComplexExample({Key? key}) : super(key: key);

  @override
  _TableComplexExampleState createState() => _TableComplexExampleState();
}

class _TableComplexExampleState extends State<TableComplexExample> {
  late PageController _pageController;
  late final ValueNotifier<List<Event>> _selectedEvents;
  late final Size size = MediaQuery.of(context).size;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDays.add(_focusedDay.value);
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return _getEventsForDays(days);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }

      _focusedDay.value = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay.value = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _selectedDays.clear();
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: color1[100],
          image: const DecorationImage(
            image: AssetImage('assets/IMG_7126.jpg'),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            const Roof(),
            const Window(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(6.0, 20.0, 6.0, 0.0),
                color: color1[500],
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        color: color1[500],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18.0)),
                        boxShadow: [
                          BoxShadow(
                            color: color1[900]!.withOpacity(.25),
                            offset: const Offset(.0, -6.0),
                            blurRadius: 6.0,
                          ),
                          BoxShadow(
                            color: color1[100]!.withOpacity(.25),
                            offset: const Offset(.0, 6.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ValueListenableBuilder<DateTime>(
                            valueListenable: _focusedDay,
                            builder: (context, value, _) {
                              return _CalendarHeader(
                                focusedDay: value,
                                clearButtonVisible: canClearSelection,
                                onTodayButtonTap: () {
                                  setState(
                                      () => _focusedDay.value = DateTime.now());
                                },
                                onClearButtonTap: () {
                                  setState(() {
                                    _rangeStart = null;
                                    _rangeEnd = null;
                                    _selectedDays.clear();
                                    _selectedEvents.value = [];
                                  });
                                },
                                onLeftArrowTap: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                },
                                onRightArrowTap: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                },
                              );
                            },
                          ),
                          TableCalendar<Event>(
                            firstDay: kFirstDay,
                            lastDay: kLastDay,
                            focusedDay: _focusedDay.value,
                            headerVisible: false,
                            selectedDayPredicate: (day) =>
                                _selectedDays.contains(day),
                            rangeStartDay: _rangeStart,
                            rangeEndDay: _rangeEnd,
                            rowHeight: 59.03,
                            calendarFormat: _calendarFormat,
                            rangeSelectionMode: _rangeSelectionMode,
                            eventLoader: _getEventsForDay,
                            holidayPredicate: (day) {
                              // Every 20th day of the month will be treated as a holiday
                              return day.day == 20;
                            },
                            onDaySelected: _onDaySelected,
                            onRangeSelected: _onRangeSelected,
                            onCalendarCreated: (controller) =>
                                _pageController = controller,
                            onPageChanged: (focusedDay) =>
                                _focusedDay.value = focusedDay,
                            onFormatChanged: (format) {
                              if (_calendarFormat != format) {
                                setState(() => _calendarFormat = format);
                              }
                            },
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ValueListenableBuilder<List<Event>>(
                        valueListenable: _selectedEvents,
                        builder: (context, value, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  onTap: () => print('${value[index]}'),
                                  title: Text('${value[index]}'),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const NumberPlate(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const Bumper(),
      extendBody: true,
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          SizedBox(
            width: 120.0,
            child: Text(
              headerText,
              style: const TextStyle(fontSize: 26.0),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today, size: 20.0),
            visualDensity: VisualDensity.compact,
            onPressed: onTodayButtonTap,
          ),
          if (clearButtonVisible)
            IconButton(
              icon: const Icon(Icons.clear, size: 20.0),
              visualDensity: VisualDensity.compact,
              onPressed: onClearButtonTap,
            ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: onLeftArrowTap,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}
