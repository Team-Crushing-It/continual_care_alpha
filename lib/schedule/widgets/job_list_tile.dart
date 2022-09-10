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
    final captionColor = theme.textTheme.caption?.color;
    hourly = widget.job.duration > 0 ? true : false;
    if (hourly) {
      endTime = widget.job.startTime
          .add(Duration(hours: widget.job.duration.toInt()));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: widget.onDismissed,
        direction: DismissDirection.endToStart,
        child: ListTile(
          onTap: widget.onTap,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  children: [
                    Text(
                      widget.job.startTime.dateIosFormat()!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        hourly
                            ? ' ${widget.job.startTime.timeFormat()!} - ${endTime.timeFormat()!} '
                            : widget.job.startTime.timeFormat()!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: captionColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Container(
            decoration: ShapeDecoration(
              shape: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconText(
                        icon: Icons.person,
                        text: widget.job.client,
                      ),
                      IconText(
                        icon: Icons.location_on,
                        text: widget.job.location,
                      ),
                      IconText(
                        icon: Icons.medical_information,
                        text: widget.job.coordinator.email ?? '',
                      )
                    ],
                  ),
                  SizedBox(
                    width: 70,
                    child: Text(
                      '\$${oCcy.format(widget.job.pay)}',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
