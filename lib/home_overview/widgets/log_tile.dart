import 'package:continual_care_alpha/home_overview/home_overview.dart';
import 'package:flutter/material.dart';
import 'package:jobs_api/jobs_api.dart';

class JobTile extends StatelessWidget {
  const JobTile({
    Key? key,
    required this.initialJob,
    this.onTap,
  }) : super(key: key);

  final Job initialJob;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var log;
    
    final logExists = initialJob.logs.isNotEmpty;

    if (logExists) {
      log = initialJob.logs.first;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        minVerticalPadding: 0,
        onTap: onTap,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  logExists ? log.completed.toDateIosFormat()! : 'na',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text.rich(
                      overflow: TextOverflow.ellipsis,
                      TextSpan(children: [
                        TextSpan(
                            text: "Location: ",
                            style: TextStyle(color: Color(0xff989898))),
                        TextSpan(text: "🤩"),
                      ])),
                ),
              ],
            ),
          ],
        ),
        subtitle: Container(
          decoration: ShapeDecoration(
            shape: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 0.5,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InfoItem(
                    title: "Comments",
                    count: logExists ? log.comments.length : 0),
                // InfoItem(title: "Tasks", count: initialJob.tasks.length),
                InfoItem(
                    title: "IADL", count: logExists ? log.iadls.length : 0),
                InfoItem(title: "BADL", count: logExists ? log.badls.length : 0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
