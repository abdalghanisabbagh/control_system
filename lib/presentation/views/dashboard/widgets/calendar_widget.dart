import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  CalendarWidgetState createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(2, 15), // changes position of shadow
          ),
        ],
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat("MMM, yyyy").format(_focusedDay),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: ColorManager.black,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(
                        () {
                          _focusedDay =
                              DateTime(_focusedDay.year, _focusedDay.month - 1);
                        },
                      );
                    },
                    child: const Icon(
                      Icons.chevron_left,
                      color: ColorManager.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(
                        () {
                          _focusedDay =
                              DateTime(_focusedDay.year, _focusedDay.month + 1);
                        },
                      );
                    },
                    child: const Icon(
                      Icons.chevron_right,
                      color: ColorManager.black,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TableCalendar(
            focusedDay: _focusedDay,
            currentDay: DateTime.now(),
            firstDay: DateTime.utc(2010),
            lastDay: DateTime.utc(2040),
            headerVisible: false,
            onFormatChanged: (result) {},
            weekendDays: const [DateTime.friday, DateTime.saturday],
            daysOfWeekStyle: const DaysOfWeekStyle(
              // dowTextFormatter: (date, locale) {
              //   return DateFormat("EEE").format(date).toUpperCase();
              // },
              weekendStyle: TextStyle(
                fontWeight: FontWeight.w300,
                color: ColorManager.black,
                decoration: TextDecoration.lineThrough,
                fontSize: 14,
              ),
              weekdayStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorManager.black,
                fontSize: 14,
              ),
            ),
            onPageChanged: (day) {
              _focusedDay = day;
              setState(() {});
            },
            calendarStyle: CalendarStyle(
              defaultTextStyle: const TextStyle(
                color: ColorManager.black,
                fontWeight: FontWeight.bold,
              ),
              todayDecoration: BoxDecoration(
                color: ColorManager.bgSideMenu,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: ColorManager.bgSideMenu,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }
}
