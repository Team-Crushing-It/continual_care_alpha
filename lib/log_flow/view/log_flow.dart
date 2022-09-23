import 'package:continual_care_alpha/app/bloc/app_bloc.dart';
import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_api/jobs_api.dart';
import 'package:jobs_repository/jobs_repository.dart';

List<Page> onGenerateLocationPages(LogState state, List<Page> pages) {
  return [
    if (state.status == LogStatus.initial) CaregiverPage.page(),
    if (state.status == LogStatus.caregiverCompleted) TasksPage.page(),
    if (state.status == LogStatus.tasksCompleted) TasksPage.page(),
    if (state.status == LogStatus.iadlsCompleted) TasksPage.page(),
    if (state.status == LogStatus.badlsCompleted) TasksPage.page(),
  ];
}

class LogFlow extends StatelessWidget {
  const LogFlow({super.key});

  static Route<void> route({Log? initialLog, required Job job}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => LogBloc(
          user: User(
            id: context.read<AppBloc>().state.user.id,
            name: context.read<AppBloc>().state.user.name,
            email: context.read<AppBloc>().state.user.email,
            photo: context.read<AppBloc>().state.user.photo,
          ),
          jobsRepository: context.read<JobsRepository>(),
          initialLog: initialLog,
          job: job,
        ),
        child: const LogFlow(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLogFlow();
  }
}

class _buildLogFlow extends StatelessWidget {
  const _buildLogFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<LogState>(
      state: context.select((LogBloc bloc) => bloc.state),
      onGeneratePages: onGenerateLocationPages,
    );
  }
}
