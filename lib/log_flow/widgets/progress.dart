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

    if (status == LogStatus.initial) {
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
            children: [
              _ProgressBox(title: 'caregiver'),
              _ProgressBox(title: 'tasks'),
              _ProgressBox(title: 'iadls'),
              _ProgressBox(title: 'bads'),
              _ProgressBox(title: 'comments'),
            ],
          ),
        ),
      );
    }

    if (status == LogStatus.caregiverCompleted) {
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
            children: [
              _ProgressBox(title: 'caregiver', value: true),
              _ProgressBox(title: 'tasks'),
              _ProgressBox(title: 'iadls'),
              _ProgressBox(title: 'bads'),
              _ProgressBox(title: 'comments'),
            ],
          ),
        ),
      );
    }
    if (status == LogStatus.tasksCompleted) {
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
            children: [
              _ProgressBox(title: 'caregiver', value: true),
              _ProgressBox(title: 'tasks', value: true),
              _ProgressBox(title: 'iadls'),
              _ProgressBox(title: 'bads'),
              _ProgressBox(title: 'comments'),
            ],
          ),
        ),
      );
    }

    if (status == LogStatus.caregiverCompleted) {
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
            children: [
              _ProgressBox(title: 'caregiver', value: true),
              _ProgressBox(title: 'tasks'),
              _ProgressBox(title: 'iadls'),
              _ProgressBox(title: 'bads'),
              _ProgressBox(title: 'comments'),
            ],
          ),
        ),
      );
    }
    if (status == LogStatus.iadlsCompleted) {
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
            children: [
              _ProgressBox(title: 'caregiver', value: true),
              _ProgressBox(title: 'tasks', value: true),
              _ProgressBox(title: 'iadls', value: true),
              _ProgressBox(title: 'bads'),
              _ProgressBox(title: 'comments'),
            ],
          ),
        ),
      );
    }

    if (status == LogStatus.badlsCompleted) {
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
            children: [
              _ProgressBox(title: 'caregiver', value: true),
              _ProgressBox(title: 'tasks', value: true),
              _ProgressBox(title: 'iadls', value: true),
              _ProgressBox(title: 'bads', value: true),
              _ProgressBox(title: 'comments'),
            ],
          ),
        ),
      );
    }

    return Container();
  }
}

class _ProgressBox extends StatelessWidget {
  const _ProgressBox({required this.title, this.value});

  final String title;
  final bool? value;

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
                onChanged: (bool) => {},
              ),
            ),
            Text(title, style: TextStyle(fontSize: 10)),
          ],
        ));
  }
}
