import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogProgress extends StatelessWidget {
  const LogProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final status = context.read<LogBloc>().state.status;
    List<LogStatus> logStatus = [
      LogStatus.initial,
      LogStatus.caregiverCompleted,
      LogStatus.tasksCompleted,
      LogStatus.iadlsCompleted,
      LogStatus.badlsCompleted,
      LogStatus.commentsCompleted,
    ];
    return ProgressChecks(checksNumber: logStatus.indexOf(status));
  }
}

class ProgressChecks extends StatelessWidget {
  ProgressChecks({
    Key? key,
    required this.checksNumber,
  }) : super(key: key);

  final int checksNumber;
  List<_ProgressBox> progress = [
    _ProgressBox(
      title: 'caregiver',
      status: LogStatus.initial,
    ),
    _ProgressBox(
      title: 'tasks',
      status: LogStatus.caregiverCompleted,
    ),
    _ProgressBox(
      title: 'iadls',
      status: LogStatus.tasksCompleted,
    ),
    _ProgressBox(
      title: 'badls',
      status: LogStatus.iadlsCompleted,
    ),
    _ProgressBox(
      title: 'comments',
      status: LogStatus.commentsCompleted,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xff626262),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: progress.map((item) {
            if (progress.indexOf(item) < checksNumber)
              return item.copyWith(value: true);
            return item;
          }).toList(),
        ),
      ),
    );
  }
}

class _ProgressBox extends StatelessWidget {
  const _ProgressBox({
    required this.status,
    required this.title,
    this.value,
  });

  final String title;
  final bool? value;
  final LogStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 24,
              width: 24,
              child: Checkbox(
                value: value ?? false,
                onChanged: (bool) {
                  context.read<LogBloc>().add(
                        LogStatusChanged(status),
                      );
                },
              ),
            ),
            Text(title, style: TextStyle(fontSize: 10)),
          ],
        ));
  }

  _ProgressBox copyWith({
    String? title,
    bool? value,
    LogStatus? status,
  }) {
    return _ProgressBox(
      title: title ?? this.title,
      value: value ?? this.value,
      status: status ?? this.status,
    );
  }
}
