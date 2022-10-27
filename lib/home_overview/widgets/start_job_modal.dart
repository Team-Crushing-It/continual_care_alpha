import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:flutter/material.dart';
import 'package:jobs_api/jobs_api.dart';

Future<void> startJobModal(
  BuildContext context,
  Job upcomingJob,
  Job? recentJob,
) async {
  final tasks = upcomingJob.tasks;
  final recentComments = recentJob == null ? [Comment(comment: 'no comments')] : recentJob.logs.first.comments;


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
                        child: Text("Recent Comments",
                            style: Theme.of(context).textTheme.headline2),
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
                          children: recentComments
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
                        child: Text("Tasks",
                            style: Theme.of(context).textTheme.headline2),
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
                                  .map<Widget>((task) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        child: Container(
                                            child: Row(
                                          children: [
                                            Container(
                                              height: 16,
                                              width: 16,
                                              child: Checkbox(
                                                  value: false,
                                                  onChanged: (bool) {}),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(task.action),
                                            ),
                                          ],
                                        )),
                                      ))
                                  .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text('Would you like to start the job?',
                style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(newContext);
              Navigator.of(context).push(
                LogFlow.route(job: upcomingJob),
              );
            },
          ),
          TextButton(
            child: Text(
              'No',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(newContext);
            },
          ),
        ],
      );
    },
  );
}
