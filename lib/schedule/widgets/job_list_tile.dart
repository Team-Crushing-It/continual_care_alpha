import 'package:continual_care_alpha/schedule/schedule.dart';
import 'package:continual_care_alpha/schedule/widgets/date_ios_format.dart';
import 'package:continual_care_alpha/schedule/widgets/time_format.dart';
import 'package:flutter/material.dart';
import 'package:jobs_repository/jobs_repository.dart';
import 'package:intl/intl.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class JobListTile extends StatefulWidget {
  const JobListTile({
    super.key,
    required this.job,
    this.onDismissed,
    this.onTap,
  });

  final Job job;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  State<JobListTile> createState() => _JobListTileState();
}

class _JobListTileState extends State<JobListTile> {
  late DateTime endTime;
  late bool hourly;

  @override
  void initState() {
    hourly = widget.job.duration > 0 ? true : false;
    if (hourly) {
      endTime = widget.job.startTime
          .add(Duration(hours: widget.job.duration.toInt()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    hourly = widget.job.duration > 0 ? true : false;
    if (hourly) {
      endTime = widget.job.startTime
          .add(Duration(hours: widget.job.duration.toInt()));
    }

    return Dismissible(
      key: UniqueKey(),
      onDismissed: widget.onDismissed,
      direction: DismissDirection.endToStart,
      child: Container(
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          minVerticalPadding: 0,
          onTap: widget.onTap,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.job.startTime.dateIosFormat()!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyText2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        hourly
                            ? ' ${widget.job.startTime.timeFormat()!} - ${endTime.timeFormat()!} '
                            : widget.job.startTime.timeFormat()!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        // style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Container(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconText(
                        icon: Icons.location_on,
                        text: widget.job.location,
                      ),
                      IconText(
                        icon: Icons.medical_information,
                        text: widget.job.client ?? '',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
