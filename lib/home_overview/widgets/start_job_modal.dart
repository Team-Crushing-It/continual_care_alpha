import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:flutter/material.dart';
import 'package:jobs_api/jobs_api.dart';

Future<void> startJobModal(
  BuildContext context,
  Job upcomingJob,
  // Job priorJob,
) async {
  final tasks = upcomingJob.logs.first.tasks;
  return showDialog(
    context: context,
    builder: (newContext) {
      return AlertDialog(
        title: Text(
            '${upcomingJob.startTime.toDateIosFormat()} ${upcomingJob.client}'),
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 32,
                    child: Text(
                      "Tasks",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  Text(
                    'Would you like to start the job?',
                    style: TextStyle(
                      color: Color(0xff989898),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(newContext);
              Navigator.of(context).push(
                LogFlow.route(),
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
