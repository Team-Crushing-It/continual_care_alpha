import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:flutter/material.dart';
import 'package:jobs_api/jobs_api.dart';

Future<void> startJobModal(
  BuildContext context,
  Job upcomingJob,
  Job recentJob,
) async {
  final tasks = upcomingJob.tasks;
  final recentComments = recentJob.logs.first.comments;

  return showDialog(
    context: context,
    builder: (newContext) {
      return AlertDialog(
        title: Text(
            '${upcomingJob.startTime.toDateIosFormat()} ${upcomingJob.client}',
            style: Theme.of(context).textTheme.headline1),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 32,
                        child: Text(
                          "Recent Comments",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Color(0xff626262),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: recentComments.isEmpty
                              ? [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('no recent comments'),
                                  )
                                ]
                              : recentComments
                                  .map<Widget>(
                                      (comment) => Text(comment.comment))
                                  .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 32,
                        child: Text(
                          "Tasks",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Color(0xff626262),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: tasks.isEmpty
                              ? [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('no tasks'),
                                  )
                                ]
                              : tasks
                                  .map<Widget>((task) => Text(task.action))
                                  .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Would you like to start the job?',
              style: TextStyle(
                color: Color(0xff989898),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(newContext);
              Navigator.of(context).push(
                LogFlow.route(job: upcomingJob),
              );
            },
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(newContext);
            },
            child: Text(
              'No',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
