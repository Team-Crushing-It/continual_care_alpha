import 'package:continual_care_alpha/schedule/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePicker extends StatefulWidget {
  const SchedulePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<SchedulePicker> createState() => _SchedulePickerState();
}

class _SchedulePickerState extends State<SchedulePicker> {
  late ScrollController _controller;
  late DateTime nCurrent;
  late DateTime cSelected;

  @override
  void initState() {
    final now = DateTime.now();
    final timeNow = DateTime(now.year, now.month, now.day);
    nCurrent = timeNow.subtract(new Duration(days: timeNow.weekday - 1));
    _controller = ScrollController(initialScrollOffset: 350);
    cSelected = nCurrent;

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  animateToTile(double pozish) {
    _controller.animateTo(pozish,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Color(0xffF6E7E7),
      child: ListView.builder(
        controller: _controller,
        physics: ClampingScrollPhysics(),
        itemCount: 20,
        itemBuilder: ((context, index) {
          /// Start from 10 weeks in the past, and
          /// with every iteration of index,
          /// move one week up
          final startDate = nCurrent
              .subtract(Duration(days: 7 * 10))
              .add(Duration(days: index * 7));

          /// The end date for the filter
          final endDate = startDate.add(Duration(days: 6));

          /// this is for determining whether or not to display
          /// the month in the list
          var isMonth = false;
          final firstDate = nCurrent.subtract(Duration(days: 7 * 10));

          /// if end date is at the beginning of a month,
          /// (less than seven days into it)
          /// then display the month in a tile
          if (endDate.day < 8) {
            isMonth = true;
          }
          return WeekListTile(
            key: Key('weekListTile_key${startDate.toString}'),
            isMonth: isMonth,
            startDate: startDate,
            endDate: endDate,
            isSelected: startDate == cSelected,
            onPressed: () {
              /// Whenever this specific tile is selected, update
              /// the state of the widget, [cSelected]
              setState(() {
                cSelected = startDate;
              });

              /// This offset is used to determine how many month
              /// tiles are in the way so that the scrollController
              /// can correctly land on the right place
              ///
              /// if one moves onto the next year, the offset is corrected
              final offset = startDate.year > firstDate.year
                  ? (firstDate.month - startDate.month) + 12
                  : startDate.month - firstDate.month;
              // Animate to the position, knowing that each tile is 33px high
              animateToTile(
                (33 * (index + offset)).toDouble(),
              );

              /// This updates the filter
              /// Calls the bloc to update the filter
              context.read<ScheduleBloc>().add(ScheduleFilterChanged(
                  filterBegin: startDate, filterEnd: endDate.add(Duration(days: 1))));
            },
          );
        }),
      ),
    );
  }
}
